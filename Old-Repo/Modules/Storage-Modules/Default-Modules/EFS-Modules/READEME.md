# Elastic File System Module

```

The user is able to create a the following:
    1   -   More than one Elastic File System.
        1a - Create Elastic File System.
        1b - Create more than one EFS Mount target.
            1ba - Specify existing subnet.
            1bb - Create new subnet for EFS Mount Target placement.
            1bc - Specify existing security group IDs for EFS Mount Target.
        1c - Create an EFS Access Point. 
            1ca - Specify Access Point Root Directory
            1cb - Specify Access Point Posix User
        1d - Specify EFS Security Settings.
            1da - Attach a JSON permissions policy to EFS.
            1db - Specify an existing KMS key for EFS encryption.
            1dc - Create a new KMS key to encrypt EFS.
        1e - Attach a lifecycle policy.


```

Use the following example below to create one or more EFS file systems

[EFS Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system)

[EFS Mount Target Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system)

[Subnet Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

[Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

[EFS Access Point Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point)

[KMS Key Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)

```terraform

#########################
## Elasitc File System ##
#########################
create_efs_file_systems = true # Whether to create Elastic File Systems

efs_file_systems = {

    ## Able to create more than one EFS. Copy and paste example below

    efs_1 = { # Module key for the EFS file system. Must be unique. Terraform does not process duplicates
        ## General ##
        creation_token = "" # Creation token for the EFS file system
        ## Mount Targets ##
        availability_zone_name = "" # Specify AZ for One-Zone EFS
        mount_targets = {

            ## Able to create more than one mount target. Copy and paste example below

            target_1 = { 
                module_key = "" # Module key for the mount target. Must be unique. Terraform does not process duplicates
                ip_address = "" # IP Address within the specified subnet that EFS mount target will reserve
                subnet_id = "" # Existing subnet ID the EFS mount target will be located in
                new_subnet = {
                    enabled = false # Whether to create a new subnet for the EFS mount target
                    vpc_id = "" # VPC ID the new subnet will be located in
                    cidr_block = "" # CIDR block the subnet will reserve
                    availability_zone = "" # AWS availability zone the subnet will be located in 
                    subnet_tags = { "key" = "value" } # Tags to associate with the new subnet
                }
                security_groups = [] # Existing security group IDs to associate with the mount target
                new_security_group = {
                    enabled = false # Whether to create a new security group for the mount target 
                    name = "" # Required Must Be Unique. Used for module reference
                    description = "" # Description for the security group
                    vpc_id = "" # VPC ID the new security group will take place in
                    ingress_protocol_ports = [] # Ex: "protocol.fromport.toport"
                    ingress_security_groups = [] # Security group IDs to be use as source for traffic
                    ingress_ipv4_cidr_blocks = [] # IPv4 CIDR Blocks to be used as a source fpr traffic
                    ingress_ipv6_cidr_blocks = [] # IPv6 CIDR Blocks to be used as a source fpr traffic
                    security_group_tags = { "key" = "value"} # Tags to associate with the mount target
            }}
            
        }
        ## Access Point ##
        access_point = {
            enabled = "" # Whether to create an Access Point for this EFS File System
            module_key = "" # Required, module key. Must be unique
            root_directory = {
                enabled = true # Whether to secify a root directory for the access point
                path = "/" # Path on the EFS file system to designate as access point. Maximum four subdirectories
                creation_info = {
                    owner_gid = 0 # Group owner ID that has allowed access to EFS file system
                    owner_uid = 0 # User Owner ID that has allowed acces to EFS file system
                    permissions = 444 # Permissions allowed specified with numbers. 4-read,2-write,1-execute. (Owner)(Group)(Any)
            }}
            posix_user = {
                enabled = false # Whether to create Posix user(s) for the EFS file system
                gid = 0 # POSIX Group that is allowed access to the file system
                secondary_gids = [0] # Secondary POSIX groups allowed access to the EFS file system 
                uid = 0 # Owner ID allowed access to the file system
            }
        }
        ## Performance ##
        performance_mode = "" # Performance mode: "generalPurpose" || "maxIO" 
        throughput_mode = "bursting" # Throughput mode: "bursting" || "provisioned"
        provisioned_throughput_in_mibps = 0 # WARNING, Very Expensive! Allocated throughput for EFS file systems with provisioned throughput mode
        ## Security ##
        efs_policy = {
            enabled = true # Whether to create a policy for EFS access
            module_key = "" # Required, must be unique
            efs_policy_local_path = "" # Local path to JSON file containing the EFS policy
        } 
        encrypted = false # Whether to encrypt the EFS file system
        kms_key_id = "" # ID of existing KMS Key to use for encrypting the EFS file system
        new_kms_key = {
            enabled = false # Whether to create a new kms key to encrypt the EFS file system
            description = "" # Required, must be unqiue. Used for module reference
            enable_key_rotation = false # Whether to enable key rotation
            deletion_window_in_days = 7 # Number of day a key is held before deletion
            policy = "" # Policy to attach to the KMS key
            kms_tags = { "Key" = "Value" } # Tags to associate with the new KMS key
        }
        ## Lifecycle ##
        enable_lifecycle_policy = false  # Whether to add a lifecycle rule to the EFS file system 
        lifecycle_policy = { transition_to_ia = "" } # How long it takes for files to transfer to the Infrequently Access (IA) storage class: "AFTER_(7 || 14 || 30 || 60 || 90)_DAYS
        ## Tags ##
        tags = {
            "key" = "value" # Tags to associate with the EFS file system
        }
    }
}

```