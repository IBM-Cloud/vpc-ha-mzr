# ha_mzr_core_module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Locals
This resource will be used to create and calculate local variables containing Subnet IP count.
If there is a requirement for extra ips please update the db\_ip\_count with extra required ips.
**/

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.45.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_autoscale"></a> [autoscale](#module\_autoscale) | ./ha-modules/autoscale | n/a |
| <a name="module_core_modules"></a> [core\_modules](#module\_core\_modules) | ./core_modules | n/a |
| <a name="module_cos"></a> [cos](#module\_cos) | ./ha-modules/cos | n/a |
| <a name="module_public_gateway"></a> [public\_gateway](#module\_public\_gateway) | ./ha-modules/public_gateway | n/a |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | ./ha-modules/vpn | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none | `string` | `"none"` | no |
| <a name="input_admin_state_up"></a> [admin\_state\_up](#input\_admin\_state\_up) | The VPN gateway connection status. If set to false, the VPN gateway connection is shut down. | `bool` | `"true"` | no |
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | This is the Application load balancer listener port | `number` | `80` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Please enter the IBM Cloud API key. | `string` | n/a | yes |
| <a name="input_app_aggregation_window"></a> [app\_aggregation\_window](#input\_app\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | `90` | no |
| <a name="input_app_config"></a> [app\_config](#input\_app\_config) | Application Configurations to be passed for App Instance Group creation | `map(any)` | <pre>{<br>  "application_port": "80",<br>  "instance_profile": "cx2-2x4",<br>  "memory_percent": "70",<br>  "network_in": "4000",<br>  "network_out": "4000"<br>}</pre> | no |
| <a name="input_app_cooldown_time"></a> [app\_cooldown\_time](#input\_app\_cooldown\_time) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | `120` | no |
| <a name="input_app_cpu_threshold"></a> [app\_cpu\_threshold](#input\_app\_cpu\_threshold) | Average target CPU Percent for CPU policy of App Instance Group | `number` | `70` | no |
| <a name="input_app_image"></a> [app\_image](#input\_app\_image) | Custom image id for the app VSI | `string` | n/a | yes |
| <a name="input_app_lb_type"></a> [app\_lb\_type](#input\_app\_lb\_type) | This variable will decide the type of App Load Balancer. Allowed values are public or private. | `string` | `"private"` | no |
| <a name="input_app_max_servers_count"></a> [app\_max\_servers\_count](#input\_app\_max\_servers\_count) | Maximum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_app_min_servers_count"></a> [app\_min\_servers\_count](#input\_app\_min\_servers\_count) | Minimum App servers count for the App Instance group | `number` | `1` | no |
| <a name="input_app_pg_strategy"></a> [app\_pg\_strategy](#input\_app\_pg\_strategy) | The strategy for App servers placement group - host\_spread: place on different compute hosts - power\_spread: place on compute hosts that use different power sources. | `string` | n/a | yes |
| <a name="input_authentication_algorithm"></a> [authentication\_algorithm](#input\_authentication\_algorithm) | Enter the algorithm that you want to use to authenticate IPSec peers. Available options are sha256, sha384 or sha512. | `string` | `"sha256"` | no |
| <a name="input_bastion_image"></a> [bastion\_image](#input\_bastion\_image) | Custom image id for the Bastion VSI | `string` | n/a | yes |
| <a name="input_bastion_ip_count"></a> [bastion\_ip\_count](#input\_bastion\_ip\_count) | IP count is the total number of total\_ipv4\_address\_count for Bastion Subnet | `number` | `8` | no |
| <a name="input_bastion_profile"></a> [bastion\_profile](#input\_bastion\_profile) | Specify the profile needed for Bastion VSI | `string` | `"cx2-2x4"` | no |
| <a name="input_bastion_ssh_key_var_name"></a> [bastion\_ssh\_key\_var\_name](#input\_bastion\_ssh\_key\_var\_name) | This is the name of the ssh key which will be generated dynamically on the bastion server and further will be attached with all the other Web/App/DB servers. It will be used to login to Web/App/DB servers via Bastion server only. | `string` | `"bastion-ssh-key"` | no |
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | The location of the COS bucket | `string` | `""` | no |
| <a name="input_cos_bucket_plan"></a> [cos\_bucket\_plan](#input\_cos\_bucket\_plan) | Please enter plan name for COS bucket. Possible value is <br>1:lite<br>2:standard | `string` | `""` | no |
| <a name="input_cross_region_location"></a> [cross\_region\_location](#input\_cross\_region\_location) | Cross Region service provides higher durability and availability than using a single region, at the cost of slightly higher latency. This service is available today in the U.S., E.U., and A.P. areas. | `string` | `""` | no |
| <a name="input_data_vol_size"></a> [data\_vol\_size](#input\_data\_vol\_size) | Storage size in GB. The value should be between 10 and 2000 | `number` | `10` | no |
| <a name="input_db_image"></a> [db\_image](#input\_db\_image) | Custom image id for the Database VSI | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database will be created with the specified name | `string` | `""` | no |
| <a name="input_db_pg_strategy"></a> [db\_pg\_strategy](#input\_db\_pg\_strategy) | The strategy for Database servers placement group - host\_spread: place on different compute hosts - power\_spread: place on compute hosts that use different power sources. | `string` | n/a | yes |
| <a name="input_db_profile"></a> [db\_profile](#input\_db\_profile) | Hardware configuration profile for the Database VSI. | `string` | `"cx2-2x4"` | no |
| <a name="input_db_pwd"></a> [db\_pwd](#input\_db\_pwd) | Database user will be created with the specified password | `string` | `""` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Database user will be created with the specified name | `string` | `""` | no |
| <a name="input_db_vsi_count"></a> [db\_vsi\_count](#input\_db\_vsi\_count) | Total Database instances that will be created in the user specified zone. | `number` | `2` | no |
| <a name="input_dh_group"></a> [dh\_group](#input\_dh\_group) | Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 14,15,16,17,18,19,20,21,22,23,24 or 31 | `number` | `14` | no |
| <a name="input_enable_automation"></a> [enable\_automation](#input\_enable\_automation) | Determines whether to enable Automation or not. Enter true or false. | `bool` | n/a | yes |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Determines whether to enable autoscaling or not. Enter true or false. | `bool` | n/a | yes |
| <a name="input_enable_cos"></a> [enable\_cos](#input\_enable\_cos) | Determines whether to create Cloud Object Storage [COS]. Enter true or false. | `bool` | n/a | yes |
| <a name="input_enable_floating_ip"></a> [enable\_floating\_ip](#input\_enable\_floating\_ip) | Determines whether to enable floating IP for Bastion server or not. Enter true or false. | `bool` | `true` | no |
| <a name="input_enable_public_gateway"></a> [enable\_public\_gateway](#input\_enable\_public\_gateway) | Determines whether to create Public Gateway or not. Enter true or false. | `bool` | n/a | yes |
| <a name="input_enable_vpn"></a> [enable\_vpn](#input\_enable\_vpn) | Determines whether to create vpn or not. Enter true or false. | `bool` | n/a | yes |
| <a name="input_encryption_algorithm"></a> [encryption\_algorithm](#input\_encryption\_algorithm) | Enter the algorithm that you want to use to encrypt data. Available options are: aes128, aes192 or aes256. | `string` | `"aes256"` | no |
| <a name="input_ike_version"></a> [ike\_version](#input\_ike\_version) | Enter the IKE protocol version that you want to use. Available options are 1, or 2 | `number` | `2` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | Dead peer detection interval in seconds. How often to test that the peer gateway is responsive. | `number` | `30` | no |
| <a name="input_iops_tier"></a> [iops\_tier](#input\_iops\_tier) | Enter the IOPs (IOPS per GB) tier for db data volume. Valid values are 3, 5, and 10. | `number` | `5` | no |
| <a name="input_key_lifetime"></a> [key\_lifetime](#input\_key\_lifetime) | The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated. | `map(number)` | <pre>{<br>  "ike": 28800,<br>  "ipsec": 3600<br>}</pre> | no |
| <a name="input_lb_port_number"></a> [lb\_port\_number](#input\_lb\_port\_number) | declare LBaaS pool member port number | `map(any)` | <pre>{<br>  "custom": "xxx",<br>  "http": "80",<br>  "https": "443"<br>}</pre> | no |
| <a name="input_local_machine_os_type"></a> [local\_machine\_os\_type](#input\_local\_machine\_os\_type) | Operating System to be used [windows \| mac \| linux] for your local machine which is running terraform apply | `string` | n/a | yes |
| <a name="input_obj_content"></a> [obj\_content](#input\_obj\_content) | Literal string value to use as an object content, which will be uploaded as UTF-8 encoded text. Conflicts with content\_base64 and content\_file | `string` | `""` | no |
| <a name="input_obj_key"></a> [obj\_key](#input\_obj\_key) | The name of an object in the COS bucket. This is used to identify our object. | `string` | `""` | no |
| <a name="input_peer_cidrs"></a> [peer\_cidrs](#input\_peer\_cidrs) | List of peer CIDRs for the creation of VPN connection. | `list(string)` | n/a | yes |
| <a name="input_peer_gateway_ip"></a> [peer\_gateway\_ip](#input\_peer\_gateway\_ip) | The IP address of the peer VPN gateway. | `string` | n/a | yes |
| <a name="input_perfect_forward_secrecy"></a> [perfect\_forward\_secrecy](#input\_perfect\_forward\_secrecy) | Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group\_2, group\_5, and group\_14 | `string` | `"disabled"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this script. | `string` | n/a | yes |
| <a name="input_preshared_key"></a> [preshared\_key](#input\_preshared\_key) | The Key configured on the peer gateway. The key is usually a complex string similar to a password. | `string` | n/a | yes |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | Provide the list of User's Public IP addresses in the format "X.X.X.X" which will be used to login to Bastion VSI.<br>For example: "123.201.8.30,219.91.139.49". <br>Also Please provide the updated list of public IP addresses every time before executing. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Please enter a region from the following available region and zones mapping: <br>us-south<br>us-east<br>eu-gb<br>eu-de<br>jp-tok<br>au-syd | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID | `string` | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Storage class helps in choosing a right storage plan and location and helps in reducing the cost. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags that will be attached to resources created by the script. | `list(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1. | `number` | `120` | no |
| <a name="input_user_ssh_keys"></a> [user\_ssh\_keys](#input\_user\_ssh\_keys) | This is the list of existing ssh key/keys on the User's machine and will be attached with the bastion server only.<br>For example: "first-ssh-key,second-ssh-key".<br>This will ensure the incoming connection on Bastion Server only from the users provided ssh\_keys. You can check your key name in IBM cloud. | `string` | n/a | yes |
| <a name="input_vpn_mode"></a> [vpn\_mode](#input\_vpn\_mode) | Mode in VPN gateway. Supported values are route or policy. | `string` | n/a | yes |
| <a name="input_web_aggregation_window"></a> [web\_aggregation\_window](#input\_web\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | `90` | no |
| <a name="input_web_config"></a> [web\_config](#input\_web\_config) | Web Configurations to be passed for Web Instance Group creation | `map(any)` | <pre>{<br>  "application_port": "80",<br>  "instance_profile": "cx2-2x4",<br>  "memory_percent": "70",<br>  "network_in": "4000",<br>  "network_out": "4000"<br>}</pre> | no |
| <a name="input_web_cooldown_time"></a> [web\_cooldown\_time](#input\_web\_cooldown\_time) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | `120` | no |
| <a name="input_web_cpu_threshold"></a> [web\_cpu\_threshold](#input\_web\_cpu\_threshold) | Average target CPU Percent for CPU policy of Web Instance Group | `number` | `70` | no |
| <a name="input_web_image"></a> [web\_image](#input\_web\_image) | Custom image id for the web VSI | `string` | n/a | yes |
| <a name="input_web_lb_type"></a> [web\_lb\_type](#input\_web\_lb\_type) | This variable will decide the type of Web Load Balancer. Allowed values are public or private. | `string` | n/a | yes |
| <a name="input_web_max_servers_count"></a> [web\_max\_servers\_count](#input\_web\_max\_servers\_count) | Maximum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_web_min_servers_count"></a> [web\_min\_servers\_count](#input\_web\_min\_servers\_count) | Minimum Web servers count for the Web Instance group | `number` | `1` | no |
| <a name="input_web_pg_strategy"></a> [web\_pg\_strategy](#input\_web\_pg\_strategy) | The strategy for Web servers placement group - host\_spread: place on different compute hosts - power\_spread: place on compute hosts that use different power sources. | `string` | n/a | yes |
| <a name="input_wp_admin_email"></a> [wp\_admin\_email](#input\_wp\_admin\_email) | Email of the Admin User of the wordpress website | `string` | `""` | no |
| <a name="input_wp_admin_password"></a> [wp\_admin\_password](#input\_wp\_admin\_password) | Password of the Admin User for the wordpress website | `string` | `""` | no |
| <a name="input_wp_admin_user"></a> [wp\_admin\_user](#input\_wp\_admin\_user) | Name of the Admin User of the wordpress website | `string` | `""` | no |
| <a name="input_wp_blog_title"></a> [wp\_blog\_title](#input\_wp\_blog\_title) | Title of the website or blog | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Region and zones mapping | `map(any)` | <pre>{<br>  "au-syd": [<br>    "au-syd-1",<br>    "au-syd-2",<br>    "au-syd-3"<br>  ],<br>  "br-sao": [<br>    "br-sao-1",<br>    "br-sao-2",<br>    "br-sao-3"<br>  ],<br>  "ca-tor": [<br>    "ca-tor-1",<br>    "ca-tor-2",<br>    "ca-tor-3"<br>  ],<br>  "eu-de": [<br>    "eu-de-1",<br>    "eu-de-2",<br>    "eu-de-3"<br>  ],<br>  "eu-gb": [<br>    "eu-gb-1",<br>    "eu-gb-2",<br>    "eu-gb-3"<br>  ],<br>  "jp-osa": [<br>    "jp-osa-1",<br>    "jp-osa-2",<br>    "jp-osa-3"<br>  ],<br>  "jp-tok": [<br>    "jp-tok-1",<br>    "jp-tok-2",<br>    "jp-tok-3"<br>  ],<br>  "us-east": [<br>    "us-east-1",<br>    "us-east-2",<br>    "us-east-3"<br>  ],<br>  "us-south": [<br>    "us-south-1",<br>    "us-south-2",<br>    "us-south-3"<br>  ]<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_BASTION_PUBLIC_IP"></a> [BASTION\_PUBLIC\_IP](#output\_BASTION\_PUBLIC\_IP) | This variable will display the public IP address of Bastion Server |
| <a name="output_LOAD_BALANCER"></a> [LOAD\_BALANCER](#output\_LOAD\_BALANCER) | This variable will display the private and public IP addresses and DNS of load balancers |
| <a name="output_VSI"></a> [VSI](#output\_VSI) | This variable will display the private IP addresses of App/Web/DB servers |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
