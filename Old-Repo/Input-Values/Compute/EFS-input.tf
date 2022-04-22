module "EFS" {
    source = "../../Modules/Storage-Modules/Default-Modules/EFS-Modules"

#########################
## Elasitc File System ##
#########################
create_efs_file_systems = true

efs_file_systems = {

    efs_1 = {
        ## General ##
        creation_token = "Wordpress_EFS_001"
        ## Mount Targets ##
        availability_zone_name = "" # Specify AZ for One-Zone EFS
        mount_targets = {
            target_1 = {
                module_key = "mount_target_001"
                ip_address = ""
                subnet_id = module.VPC_VPC1.private_subnet_1.id
                new_subnet = {
                    enabled = false
                    vpc_id = ""
                    cidr_block = ""
                    availability_zone = ""
                    subnet_tags = { "key" = "value" }
                }
                security_groups = []
                new_security_group = {
                    enabled = true
                    name = "Wordpress_EFS_001_Security_Group_001" # Required Must Be Unique
                    description = "Security Group for Wordpress EFS 001"
                    vpc_id = module.VPC_VPC1.vpc.id
                    ingress_protocol_ports = ["tcp.2049.2049"] # "protocol.fromport.toport"
                    ingress_security_groups = [module.AMI_LT.launch_template_security_group]
                    ingress_ipv4_cidr_blocks = []
                    ingress_ipv6_cidr_blocks = []
                    security_group_tags = { "mount_target_security_group" = "mount_target_001"}
            }}
            target_2 = {
                module_key = "mount_target_002"
                ip_address = ""
                subnet_id = module.VPC_VPC1.private_subnet_2.id
                new_subnet = {
                    enabled = false
                    vpc_id = ""
                    cidr_block = ""
                    availability_zone = ""
                    subnet_tags = { "key" = "value" }
                }
                security_groups = []
                new_security_group = {
                    enabled = true
                    name = "Wordpress_EFS_001_Security_Group_002" # Required Must Be Unique
                    description = "Security Group for Wordpress EFS 001"
                    vpc_id = module.VPC_VPC1.vpc.id
                    ingress_protocol_ports = ["tcp.2049.2049"] # "protocol.fromport.toport"
                    ingress_security_groups = [module.AMI_LT.launch_template_security_group]
                    ingress_ipv4_cidr_blocks = []
                    ingress_ipv6_cidr_blocks = []
                    security_group_tags = { "mount_point_security_group" = "mount_target_002"}
            }}
        }
        ## Access Point ##
        access_point = {
            enabled = true
            module_key = "EFS_1_Access_Point" # Reqired, must be unique
            root_directory = {
                enabled = true
                path = "/"
                creation_info = {
                    owner_gid = 0
                    owner_uid = 0
                    permissions = 444
            }}
            posix_user = {
                enabled = false
                gid = 789
                secondary_gids = [91011]
                uid = 121314
            }
        }
        ## Performance ##
        performance_mode = "maxIO"
        throughput_mode = "bursting"
        provisioned_throughput_in_mibps = 0
        ## Security ##
        efs_policy = {
            enabled = true
            module_key = "Wordress_EFS_Policy_001" # Required, must be unique
            efs_policy_local_path = "Input-Values\\Compute\\Scripts\\EFS-Policy.json"
        }
        encrypted = false
        kms_key_id = ""
        new_kms_key = {
            enabled = false
            description = "Wordpress_EFS_001_KMS_001" # Required, must be unqiue
            enable_key_rotation = false
            deletion_window_in_days = 7
            policy = ""
            kms_tags = { "Key" = "Value" }
        }
        ## Lifecycle ##
        enable_lifecycle_policy = false
        lifecycle_policy = { transition_to_ia = "" }
        ## Tags ##
        tags = {
            "Wordpress_EFS" = "Wordpress_EFS_001"
        }
    }

}





    
}