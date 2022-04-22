# AMI/Launch Template Module Overview

This module allows you to do the following:
    1 - AMI Section:
        1a - Create a new AMI.
        1b - Specify virtualization settings.
        1c - Specify EBS Block Devices to map to the AMI.
            1ca - Use an existing Snapshot ID for mapping.
            1cb - Able to create a new Snapshot ID by auto creating an empty EBS Volume.
            1cc - Able to create as many EBS Block Device Mappings as desired. 
        1d - Specify ephemeral block devices.
        1e - Able to create launch permission for the new AMI
        1f - Able to create tags


    2 - Launch Template Section:
        2a - Create a new Launch Template.
        2b - Specify the version of the launch template.
        2c - Specify AMI settings for the launch template.
            2ca - Use the newly created AMI from the AMI section.
            2cb - Use an existing AMI.
            2cc - Copy AMI from an instance
            2cd - Copy an AMI.
                2cda - Specify settings to overwrite the AMI copy.
                2cdb - Specify the source_id and region of the AMI to copy.
                2cdc - Use an existing KMS key for encryption
                2cdd - Create a new KMS key for the copied AMI
        2d - Specify Price Management settings for the launch template.
        2e - Specify instance settings for the Launch Template
        2f - Specify CPU settings for launch template
        2g - Specify GPU settings for the Launch Template
        2h - Specify EBS settings.
            2ha - EBS Optimized.
            2hb - EBS Block Device Mappings for the Launch Template.
                2hba - Able to specify as many block device mappings as desired.
                2hbb - Specify a snapshot_id for the device mapping
                2hbc - Specify an existing KMS key for encryption.
                2hbd - Create a new KMS key for encryption
        2i - Specify Network Settings.
            2ia - Disable API termination
            2ib - Create as many network interface as desired.
                2iba - Specify an existing network interface.
                2ibb - Create a new network interface.
                2ibc - Associate Existing security groups to the interface.
                2ibd - Associate newly created security groups.
        2j - Specify SECURITY/MONITORING settings.
            2ja - Associate existing security groups to the launch template.
            2jb - Associate newly created security groups to the launch template.
            2jc - Specify a key name for the launch template.
            2jd - Specify enclave options.
            2je - Specify monitoring options.
        2k - Specify tag specifications
        2l - Specify launch template tags


    3 - Create security groups for the launch template or launch teplate network interfaces. 
        3a - Able to create mulitple security groups
        

## Module Examples

# AMI Example:

[AMI Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami)
[EBS Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume)
[EBS_Snapshot Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_snapshot)

```terraform

####################
## Create New AMI ##
####################

create_new_ami = bool # Wheather to create a new AMI
ami_name = string # Name for the AMI
ami_description = string # Description for the AMI
root_device_name = string # Name for the root device. Reference AWS docs for correct name
architecture = string # Architecture for the AMI
enhanced_networking_support = bool # Whether enhance networking for this AMI is enabled

virtualization_type = string # Type of virtualization. "hvm" || "paravirtual"
virtualization_settings = {
    # hvm virtualization type
    sriov_net_support = string # Enabled advanced networking support for created instances
    # paravirtual virtualization type 
    image_location = string # Required, S3 Bucket location for where the AMI is stored
    kernal_id = string # Required, ID of the Amazon Kernel Image (AKI) to be used for the paravirtual kernel in created instance
    ramdisk_id = string # ID of the initrd image (ARI) that will be used for booted instances 
}

ebs_block_devices = { # Able to create multiple ebs block device mappings. Each key must be unique. Terraform does not process duplicates
    ebs_1 = { 
      # Existing EBS Device Settings
        existing_snapshot_id = "" # ID of an existing Snapshot ID to be used for the mapping

      # New EBS Block Device Settings
        use_new_snapshot = bool # Creates empty EBS for snapshot id
        ebs_key = string # Key identifier for this EBS instance. Must be unique
        availability_zone = string # Availability zone for where the EBS block will be located in
        ebs_tags = {"key" = "value"} # Tags to associate with the new EBS block
        snapshot_tags = { "key" = "value" } # Tags to associate with the snapshot_id

      # EBS Block Device Settings
        device_name = string # Name for the EBS block device
        volume_type = string # Volume type for the EBS
        volume_size = number # Size in GB for the EBS storage
        iops = number # Input/Output per second for the EBS device If volume_type != io1 || io2 then null
        throughput = number # Throughput for the EBS device. If volume_type != "gp3" then null
        delete_on_termination = bool # Whether the device is terminated when instance is terminated
    }
  }

ephemeral_block_devices = { # Able to create multiple ephemeral devices. Each key must be unique. Terraform does not process duplicates.
     eph_1 = { 
         device_name = string # Name for the ephemeral block device. Reference AWS docs for the correct name.
         virtual_name = string # Virtual name for the ephemeral block device. ephemeralN where N is the index number amongst other eph devices.
     }
}

timeouts = {} # Timeouts for the AMI

create_ami_launch_permissions = false # Whether to create launch permissions for the AMI
ami_launch_permissions = { # Able to create multiple AMI launch permissions. Each key must be unique. Terraform does not process duplicates.
  perm1 = {
    account_id = string # Account ID to allow permission to launch the AMI
  }
}

ami_tags = {
    "Key" = "Value" # Tags to associate with the launch template
}


```


# Launch Template Example 

[Launch Template Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)
[Copy AMI Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_copy)
[Copy AMI from Instance Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_from_instance)
[KMS Key Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)

```terraform

#####################
## Launch Template ##
#####################

  create_lt = bool # Whether to create a launch template
  lt_name = string # Name for the launch template
  lt_use_name_prefix = string # Whether to use a name prefix for the launch template
  lt_description = string # Decsription for the launch template

## VERSION SETTINGS ## 

# update_default_version               = bool # Whether the default version should be updated
  default_version                      = number # The default version for the launch template

## AMI SETTINGS ##

  use_new_ami      = bool # Whether the newly created AMI above should be used for the launch template
  use_existing_ami_id = string # ID of an existing AMI Leave "" for null
  copy_ami = {
    enable = bool # Whether to use a copy of an AMI for the launch template
    name              = string # name for the copied AMI
    description       = string # description for the copied AMI
    source_ami_id     = string # ID of the AMI to copy
    source_ami_region = string # Region where the source AMI is located
    encrypted = bool # Whether the copied AMI should be encrypted
    kms_key_id = string # The arn of an existing KMS key to use for encryption. Null if create_new_kms_key == true
    create_new_kms_key = bool # Whether to create a new KMS key for the copied AMI
    new_kms_key_settings = {
      values = {
          description = string # Description for the KMS key. Also serves as the unique key for module reference
          is_enabled = bool # Whether the KMS key should be enabled 
          policy = string # The policy to associate with the key
          enable_key_rotation = bool # Whether key rotation is enabled
          deletion_window_in_days = number # KMS key retention in days before deletion
          tags = { "Key" = "value" } # Tags to associate with the new KMS key
      }
    }
    tags = {
        "key" = "value" # Tags to associate with the copied AMI
    }
  } 
  copy_instance_ami = { # Instance will experience downtime if running
    enable = bool # Whether to copy the AMI from an instance to be used for the launch template
    name = string # Name for the copied from instance AMI
    source_instance_id = string # Instance ID to make an AMI copy from 
  }

## PRICE MANAGEMENT SETTINGS ##

  create_instance_market_options = false # Whether to create market options for the launch template
  instance_market_options = {
    market_option_values = {
      market_type = string # The market type. Can be "spot
      create_spot_options = false # Whether to specify spot options for the launch template
      spot_options = {
        spot_option_values = {
            block_duration_minutes = number # Spot duration in minutes x60
            instance_interruption_behavior = string # Behavior when a spot instance is interrupted
            max_price = string # Maximum hourly price you are willing to pay
            spot_instance_type = string # Spot instance request type "one-time || "persistent
            valid_until = string # The end date of the request
            }
        }
    }
  }

  create_license_specifications = bool # Whether tp create license configuration
  license_specifications = {
    license_1 = {
        license_configuration_arn = string the ARN of the license configuration
    }
  }

## INSTANCE SETTINGS ##

  instance_type = string # Instance type to use for the launch template
  kernel_id                            = string # Kernel ID to use for the launch template
  ram_disk_id                          = string # RAM disk id for the launch template

  user_data_local_file_path = string # Local file path to the file containing the user data. Leave "" for null

  create_metadata_options = bool # Whether to create metadata options for the launch template
  metadata_options = {
    values = {
      http_endpoint = string # Whether the metadata service is available. "enabled" || "disabled"
      http_tokens = string # Whether or not the metadata service requires session tokens. "enabled" || "disabled"
      http_put_response_hop_limit = number # Desired http put response hop limit
    }
  }

  create_placement = # Whether to create a placement group
  placement = {
    values = {
      affinity          = string # The Affinity settings for an instance on a dedicated host
      availability_zone = string # Availablity zone for the instance
      group_name        = string # The name of the group for the instance
      host_id           = string # The ID of the dedicated host for the instance
      spread_domain     = string # Reserved for future use
      tenancy           = string # Tenancy for the instance. "default" || "dedicated" || "host"
      partition_number  = number # The number for the partion the instance should launch in
    }
  }

  create_capacity_reservation_specification = bool # Whether to create a capacity reservation
  capacity_reservation_specification = {
    values = {
        capacity_reservation_preference = string # Capacity reservation reference. "open" || "none"
        capacity_reservation_target = {
            capacity_reservation_id = string # ID of the cpacity reservation to target
        }
    }
  }

  create_hibernation_options = bool # Whether to create hibernation options 
  hibernation_options = {
    configured = bool # Whether hibnernation options are configured for the instance
  }

  instance_initiated_shutdown_behavior = string # Instance behavior for when the instance shuts down

## CPU SETTINGS ##

  create_cpu_options = bool # Whether to create cpu options for the launched instances
  cpu_options = {
    core_count = number # Number of cores the instance will utilize
    threads_per_core = number # Number of threads per core the instance will utilize
  }

  create_credit_specification = bool Whether to create credit speicification for the launch template
  credit_specification = {
    cpu_credits = string # The credit options for CPU Usage "standard" || "unlimited"
  }

## GPU SETTINGS ##

  create_elastic_gpu_specifications = bool # Wether to create elastic gpu specifications for the launch template
  elastic_gpu_specifications = {
    type = string # The type of Elastic GPU
  }

  create_elastic_inference_accelerator = bool # Whether to create an elastic inference accelerator for the launch template
  elastic_inference_accelerator = {
    type = string # The type of inference accelerator
  }

## EBS SETTINGS ##

  ebs_optimized = bool # Whether the ebs is optimized
  manage_block_device_mappings = bool # Whether to manage block device mappings
  block_device_mappings = { # Able to create multiple block device mapping. Each key must be unique. Terraform does not process duplicates. 
    mapping_1 = {
        device_name  = string # Name of the mapped EBS block. Reference AWS docs for the correct name
        no_device    = string # Name of the AMI EBS block to omit for the launch template
        virtual_name = string # Virtual Name
        ebs = {
          snapshot_id           = string # A snopshot id to use for block device mapping
          delete_on_termination = bool # Whether the EBS block should be terminated on instance termination
          iops                  = number # Input/Output for the EBS device
          throughput            = number # Throughput for the EBS device
          volume_size           = number # Volume size in GB for the EBS device
          volume_type           = string # Volume type for the EBS device
          encrypted             = bool # Whether the EBS device should be encrypted null if snapshot_id != ""
          kms_key_id            = string # An existing ARN for a KMS key null if snapshot_id != ""
          create_new_kms_key = bool # Whether to create a new KMS key for the block device
          new_kms_key_settings = {
            description = string # Description for the KMS key. Also serves as the unique key for module reference
            is_enabled = bool # Whether to KMS key is enabled
            policy = string # The policy to associate with the KMS key
            enable_key_rotation = bool # Whether to enable key rotation
            deletion_window_in_days = number # KMS key retention in days before deletion
            tags = { "key" = "value" } # Tags to assoicate with the KMS key
          }
        }
     }
  }

## NETWORKING SETTINGS ##

  disable_api_termination              = bool # Whether to disable API termination

  create_network_interfaces = bool # Whether to create network interface for the launch template
  network_interfaces = { # Able to created multiple network interfaces. Each key must be unique. Terraform does not process duplciates
    interface_1 = {
      description                  = string # Description for the module reference. Also serves as the unique key for module reference
  
      existing_network_interface_id = string # ID of an existing network interface to use for the launch template
      new_network_interface = bool # Whether to create a new network interface for the launch template.

    # Network Interface Settings
      subnet_id                    = string # The subnet ID for where the network interface will be located in
      associate_carrier_ip_address = bool # Whether to associate carrier IP address with network interfaces
      associate_public_ip_address  = bool # Whether to assocaite public IP address for network interfaces
      ipv4_addresses               = list(sttring) # List of ipv4 addresses to assoicate with the network interface
      primary_private_ip_address   = string # The primary ipv4 address for the network interface
      ipv4_address_count           = number # The number of ipv4 addresses to associate with the network iterface Null if ipv4 addresses != 0
      ipv6_addresses               = list(string) # List of ipv6 addressses to associate with the network interface
      ipv6_address_count           = number # Number of ipv6 addresses to assoicate with the network interfce # Null if ipv6_addresses != 0
      source_dest_check = bool # Whether source destination checking is enabled for the network interface
      interface_type = string # The network interface type. "interface" || "EFA"
      device_index                 = number # The device index to associate the netowrk interface with

    # Network Interface Security Groups
      existing_security_groups              = list(string) # Security group IDs to associate with the network interface
      use_new_security_groups = list(string) # Keys from the launch template security section below

      delete_on_termination        = bool # Whether to delete the network interface on instance termination
    }
  }

## SECURITY/MONITORING SETTINGS ##

  use_new_security_groups = list(string) # Keys from the launch template security section below
  existing_security_group_ids = list(string) # Security group IDs to associate with the network interface

  key_name      = string # The name for the key to use for launched instances

  create_iam_instance_profile = bool # Whether to assign an instance profile for the launched innstances
  iam_instance_profile = {
      name = string # name of the instance profile
      arn = string # The ARN for the instance profile to use
  }

  create_enclave_options = bool # Whether to create enclave option for the launch template
  enclave_options = {
    enabled = bool # Wether to enable enclave options for launched instances
  }

  create_monitoring = bool Whether to create monitoring for the launch template
  monitoring = {
    enabled = bool # Whether to enable monitoring for the launched instances
  }

## LAUNCH TEMPLATE TAG SETTINGS ##

  create_tag_specifications = bool # Whether to create tag specifications for the launch template
  tag_specifications = {
    values = {
      resource_type = string # The type of resource to tag
      tags = {
        "key" = "value" # The tags to associate with the resource
      }
    }
  }

  launch_template_tags = {
    "key" = "value" # Tags to associate with the launch template
  }

```

# Launch Template Security Groups Example

[Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)


```terraform

#####################################
## Launch Template Security Groups ##
#####################################  

create_launch_template_security_groups = true

launch_template_security_groups = {

        Example_Security_Group = { # Able to create more than one security group. Each key must be unique. Terraform does not process dublicate keys
            name        = string # Name of security group. If "", Terraform will assign a random unigue name to the security group
            description = string # Description of the security group. If "", Terraform will auto assign the description "Managed by Terraform
            vpc_id      = string # The VPC ID where the security group will be located in

            ingress_rules = { # Able to create multiple ingress rules. Each key must be unique. Terraform does not process duplicate keys
                rule_1 = {
                    description      = string # Description of the ingress rule
                    from_port        = number # Starting port of the ingress rule
                    to_port          = number # Ending port of the ingress rule
                    protocol         = string # Protocol for the ingress rule. If "-1" (all), from/to ports must == 0
                    cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the ingress rule. If [], then cidr_blocks == null
                    ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the ingress rule. If [], then ipv6_cidr_blocks == null  
                    self = false  # Whether the security group itself will be added as a source to this ingress rule
                }
            }

            egress_rules = {  # Able to create multiple egress rules. Each key must be unique. Terraform does not process duplicate keys
                rule_1 = {
                    description      = string # Description of the egress rule
                    from_port        = number # Starting port of the egress rule
                    to_port          = number # Ending port of the egress rule
                    protocol         = string # Protocol for the egress rule. If "-1" (all), from/to ports must == 0
                    cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the egress rule. If [], then cidr_blocks == null
                    ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the egress rule. If [], then ipv6_cidr_blocks == null  
                    self = false  # Whether the security group itself will be added as a source to this egress rule
                }
            }

            tags = {
                "key" = "value" # Tags to associate with security group
            }
        }
        
    }
```