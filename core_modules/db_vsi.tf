/**
#################################################################################################################
*                           Virtual Server Instance Section for the DB Instance Module.
*                                 Start Here for the Resources Section 
#################################################################################################################
*/

data "ibm_is_image" "db_os" {
  identifier = var.db_image
}

locals {
  lin_userdata_db_ubuntu = <<-EOUD
      #!/bin/bash
      db_name=${var.db_name}
      db_user=${var.db_user}
      db_pwd=${var.db_pwd}
      sudo apt update -y
      sudo apt install -y mariadb-server mariadb-client
      sudo systemctl enable mariadb
      sudo systemctl start mariadb   
      mysql -u root -e "SHOW DATABASES;"
      mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
      mysql -u root -e "FLUSH PRIVILEGES;"
      /usr/bin/mysql -u root -e "CREATE DATABASE $db_name;"
      mysql -u root -e "CREATE USER '$db_user'@'%' IDENTIFIED BY '$db_pwd';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%';"
      mysql -u root -e "FLUSH PRIVILEGES;"
      sed -i s/'bind-address'/'#bind-address'/g /etc/mysql/mariadb.conf.d/50-server.cnf
      systemctl restart mariadb
      chmod 0755 /usr/bin/pkexec
      EOUD 

  lin_userdata_db_rhel = <<-EOUD
      #!/bin/bash
      if cat /etc/redhat-release |grep -i "release 7"
      then
      fi
      db_name=${var.db_name}
      db_user=${var.db_user}
      db_pwd=${var.db_pwd}      
      yum update -y 
      sudo yum install -y mariadb-server
      systemctl start mariadb
      systemctl enable mariadb
      mysql -u root -e "SHOW DATABASES;"
      mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
      mysql -u root -e "FLUSH PRIVILEGES;"
      /usr/bin/mysql -u root -e "CREATE DATABASE $db_name;"
      mysql -u root -e "CREATE USER '$db_user'@'%' IDENTIFIED BY '$db_pwd';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%';"
      mysql -u root -e "FLUSH PRIVILEGES;"
      if cat /etc/redhat-release |grep -i "release 7"
      then
      setenforce Permissive
      firewall-cmd --permanent --zone=public --add-port=3306/tcp
      firewall-cmd --reload
      setenforce Enforcing
      fi
      systemctl restart mariadb
      chmod 0755 /usr/bin/pkexec
      EOUD

}

/**
* Data Volume for DB servers
* Element : volume
* This extra storage volume will be attached to the DB servers as per the user specified size and bandwidth
**/
resource "ibm_is_volume" "data_volume" {
  count          = var.db_vsi_count
  name           = "${var.prefix}volume-${count.index + 1}-${var.zones[count.index % length(var.zones)]}"
  resource_group = var.resource_group_id
  profile        = var.tiered_profiles[var.iops_tier]
  zone           = var.zones[count.index % length(var.zones)]
  capacity       = var.data_vol_size
  tags           = var.tags
  depends_on     = [ibm_is_vpc.vpc]
}

/**
* Virtual Server Instance for DB
* Element : VSI
* This resource will be used to create a DB VSI as per the user input.
**/
resource "ibm_is_instance" "db" {
  count           = var.db_vsi_count
  name            = "${var.prefix}db-vsi-${count.index + 1}-${var.zones[count.index % length(var.zones)]}"
  keys            = [data.ibm_is_ssh_key.bastion_key_id.id]
  image           = var.db_image
  profile         = var.db_profile
  resource_group  = var.resource_group_id
  vpc             = ibm_is_vpc.vpc.id
  zone            = var.zones[count.index % length(var.zones)]
  placement_group = ibm_is_placement_group.db_placement_group.id
  user_data       = var.enable_automation ? split("-", data.ibm_is_image.db_os.os)[0] == "ubuntu" ? local.lin_userdata_db_ubuntu : local.lin_userdata_db_rhel : ""
  volumes         = [ibm_is_volume.data_volume.*.id[count.index]]
  tags            = var.tags
  primary_network_interface {
    subnet          = ibm_is_subnet.db_subnet[count.index % length(var.zones)].id
    security_groups = [ibm_is_security_group.db.id]
  }
  depends_on = [ibm_is_security_group.db]
}
