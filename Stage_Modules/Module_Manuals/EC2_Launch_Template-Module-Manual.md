# EC2 Launch Template Module

This module allows you to create an EC2 launch template for launching instance in AWS. You will notice that there are sections divided up where the specified index key will enable that configurations for the launch template. To add on to the versioning feature for launch templates provided in AWS, this index key configuration enablement was an attempt to bring more agility.   
   
**Supporting Documentation**    
    
[AWS Documentation: Launch Template Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html)    
   
[AWS Documentation: Launch Template API Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html)    
     
[HashiCorp Documentation: Launch Template Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template#placement)    

### Version History Notes     
    
You will notice at the top of the module there is a section where you are able to create a version history of the launch template within the module.    

```Terraform
###########################
## Version History Notes ##
###############################################################

         # Launch Template version comments go here #

###############################################################
```    
    
### Launch Template General Settings     
    
Use this section below to declare the identifying characteristices of the launch template.   
     
```Terraform
###########################################################
#- Launch Template ---------------------------------------#
###########################################################
    launch_template_name = "" # Specify the name of the launch template
    launch_template_name_prefix = false # Whether or not the launch template name should be the prefix
    description = "" # Description of the launch template
    default_version = 1 # Default version of the launch template. Every change made increase the default version by 1
    update_default_version = false # Whether or not to update to the default version of the launch template. Conflict of default_version is > 1
    tag_specifications = { # Mapping of string to assign tags to specified resources created by the launch template
    #  tag_000 = {
    #       resource_type = "", tag_key = "", tag_value = ""
    #    }
    }
```    

### Instance Boot Settings

Use these configurations belwo to specify the boot options for the EC2 instances created from this launch template.

**Supportive Documentation**   

[AWS Documentation: EC2 AMI(s) Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)     

[AWS Documentation: EC2 Instance Profile Resource Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html)

```Terraform
###########################################################
#- Instance Boot -----------------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_boot_enabled_config_index_key = "config_000"
instance_boot_configurations = {
# ABLE TO CREATE MORE THAN ONE CONFIG
    #-----------------------------------------------------#
    config_000 = {
            #- AMI -#
            get_ami_type = "" # ami_id | copy_ami | copy_ami_instance
            get_ami_values = {

            #- Please use either of the three ways provided in the codeblock below to specify the AMI that will be used for the launch template. -#

            #- **Only able to use one of the three** -#
            #- ami_id -# | #- copy_ami -# | #- copy_ami_instance

                #- ami_id -#
                ami_id = "" # The specific AMI ID to use for the launch template

                #- copy_ami -#
                new_ami_name      = "" # Once the AMI is copied, this will be the new ami name 
                description       = "" # A description for the newly copied AMI
                source_ami_id     = "" # An AMI ID that is the source to copy from
                source_ami_region = "" # If the AMI is located in a seperate region, specify the this here
                destination_outpost_arn = "" # The outpost arn in case the AMI is located there.
                encrypted = false # Whether or not to encrypt this AMI. Conflict if the AMI is encrypted and this value is set to false
                kms_key_id = "" # The kms key id to encrypt the ami or the one used to encrypt the previous AMI
                copy_ami_tags = {} # Tags to associate with the copied AMI

                #- copy_ami_instance -#
                new_ami_name               = "" # Once the AMI is copied, this will be the new ami name
                source_instance_id = "" # The instance ID that will be used as the source for copying the AMI
                snapshot_without_reboot = false # Whether or not to copy the ami from an instance when it is still running. Risky of set to true
                copy_ami_instance_tags = {} # The tags to associate with the copied AMI
            
                }

            #- Licensing -#
            license_configuration_arn = "" # The arn of the licensing configuration to use

            #- User Data -#
            user_data = {
                file = "" # Local path to Shell script | cloud-init script
                vars = {

                key = "value"

                # Able to specify environment variables that can be interpolated into a user data file
                # This will be useful if there are module values that can be passed into a user data script
                # To interpolate into user data script, please specify within file ${key}
            } }

            metadata_options = {
                http_endpoint = "" # enabled | disabled # Whether the metadata service is available # Default == "enabled"
                http_tokens = "" # optional | required # Whether metadata service requires session tokens
                http_put_response_hop_limit = 1 # Desired HTTP PUT response hop limit for instance metadate requests. 
                htttp_protocol_ipv6 = "" # enabled | disabled # Whether the IPv6 endpoint service should be enabled
                instance_metadata_tags = "" # enabled | disabled # Whether access to instance tags from instance metadata service is allowed
            }

            #- Access -#
            iam_instance_profile = {
                #- Existing -#
                arn = "" # An existing arn of an IAM Instance Profile to associate
                #- New -#
                instance_profile_name = "" # The new name of the IAM Instance Profile
                path = "" # AWS path to assign to the IAM Instance Profile
                policy_file = "" # Local path to JSON file with valid IAM  syntax
            }

            ssh_key_pair = {
                #- Existing -#
                existing_key_pair_name = "" # Name of an existing AWS Key pair to associate with the launch tempalate
                #- New Key Pair -#
                new_key_pair_name = "" # The new key pair name to create in AWS
                public_key_file = "" # Local path to public key file # Private key will be used when authenticating in SSH
            }

            #- Monitoring -#
            enable_detailed_instance_monitoring = false # Whether to enable EC3 instance detailed monitoring
    } 
    #-----------------------------------------------------#
} 
```     
    
### Instance Type Settings   
  
Please use the configuration below to specify the instance types to associate with the launch template.     

**Supportive Documentation**  

[AWS Documentation: EC2 Instance Types Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html)      

[AWS Documentation: EC2 Spot Instances Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html)       
     
[AWS Documentation: EC2 Capacity Reservations Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-capacity-reservations.html)     
    
```Terraform  
###########################################################
#- Instance Types ----------------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_types_enabled_config_index_key = "config_000"
instance_types_configurations = {
# ABLE TO CREATE MORE THAN ONE CONFIG
    #-----------------------------------------------------#
    config_000 = {
            #- Instance Type -#
            instance_type = "" # Specific instance type for the launch template # Note: Overrides all requirements sections if specified

            #- Spot Instances -#
            enable_spot_options = false # Whether or not enable Spot instance configurations for the launch template
            spot_options = {
                block_duration_minutes = 60 # Durration in increments of 60 min
                instance_interruption_behavior = "" # hibernate | stop | terminate # The behavior when a Spot Instance is interrupted
                max_price = "" # Maximum hourly price willing to be paid for the spot instances 
                spot_instance_type = "" # one-time | persistent # Spot instance request type
                valid_until = "" # Default is 7 days from creation # The end date of the request # Timestamp format
            }

            #- Capacity Reservation -#
            capacity_reservation = {
            enabled_capacity_reservation_type = "none" # existing | create | none # Whether an existing, new, or no capacity reservation should be associated with the launch template
                #-----------------------------------------#
                existing = {
                        preference = "" # open | none | null # Capacity reservation preferences
                        capacity_reservation_id = "" # The ID of an existing capacity reservation to associate with the launch template
                        capacity_reservation_resource_group_arn = "" # The ARN of a capacity reservation resource group
                }
                #-----------------------------------------#
                create = {
                        preference = "" # open | none | null # Capacity reservation preferences
                        end_date = "" # YYYY-MM-DDTHH:MM:SSZ # The date and time for when the capacity reservation expires
                        end_date_type = "" # unlimited | limited # The way in which the capacity reservation ends
                        instance_count = 1 # Required, number of instances for which to reserve capacity
                        availability_zone = "" # The availability zone for which to reserve the capacity
                        outpost_arn = "" # The ARN of an outpost for which to create a Capacity reservation
                        #- Required Criteria to Activate -#
                        instance_platform = "" # Required, the type of operating system for which to reserve the capacity
                        instance_type = "" # Required, the instance type for which to reserve the capacity
                        #- Optional Criteria to Activate -#
                        instance_match_criteria = "" # open | targeted # Types of instance launches that a capacity reservation will accept
                        tenancy = "" # default | dedicated # Indicates the tenancy for the capacity reservation
                        ebs_optimized = false # Whether or not the capacity reservation will accept instances that are EBS optimized
                        ephemeral_storage = false # Whether or not the capacity reservation will accept instances with ephemeral storage
                        tags = {} # Tags to associate with the capacity reservation
                }
                #-----------------------------------------#
            }

            #- Instance Placement -#
            enable_placement = false
            placement = {
                group_name = "" # The name of the placement group for the instance
                host_resource_group_arn = "" # The ARN of the host group in which to launch the instances
                affinity = "" # The affinity setting for an instance on a dedicated host
                availability_zone = "" # The availability zone for the instance(s)
                host_id = "" # The ID of the dedicated host for the instance
                spread_domain = "" # Reserved for future use
                tenancy = "" # default | dedicated | host # The tenancy of the instance, if the instances will run in a VPC
                partition_number = 0 # The number of the partition the instance should launch in. Valid only of the placement group strategy is set to partition
            }

            #- Instance Type Requirements -#
            requirements = {
                instance_generations = [] # List of EC2 generation names that the launch template will accept. 
                excluded_instance_types = [] # List if instance types to exclude # To exclude entire families, use * # Ex: c5*
                bare_metal_instances = "" # included | excluded | required # Whether bare metal instance types should be included, excluded, or required
            }
    }
    #-----------------------------------------------------#
} 
```      

### Instance CPU Settings

Please use the section below to specify how CPUs will be configured in the launch template.    

**Supporive Documentation**    

[AWS Documentation: EC2 CPU Options Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html)     
  
[AWS Documentation: EC2 Nitro Enclaves Resource Reference](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html)     

```Terraform
###########################################################
#- CPU Per Instance --------------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_cpu_enabled_config_index_key = "config_000"
instance_cpu_configurations = {
# ABLE TO CREATE MORE THAN ONE CONFIG
    #-----------------------------------------------------#
    config_000 = {
            #- Instance CPU -#
            core_count = 0 # Unable to exceed default CPU core count. ( Default vCPU number / 2 = Default core count)
            threads_per_core = 0 # 2 enables multithreading | 1 Disables Multithreading. Required if core_count > 0
            cpu_credits = "standard" # standard | unlimited # # The mode that cpu credits will be used for burstabled performance
            elastic_inference_accelerator_type = "" # The type of Elastic Inference (EI) to attach to the instance

            #- Nitro Enclaves -#
            enable_nitro_enclaves = false # Whether or not assign nitro enclaves when launching instances

            #- Instance CPU Requirements -#
            requirements = {
                cpu_manufacturers = [] # List of CPU manufacturers that can be assigned when launching an instance
                vcpu_count = { min = 0, max = 0 } # The min and max number of vcpu to assign to a launched instance
                burstable_performance = "" # included | excluded | required # Level of burstable CPU performance to be included when launch instances
            }
    }
    #-----------------------------------------------------#
} 
```

### Instance Memory Settings    
   
Please use the section below to specify how memory will be configured in the launch template   

**Supporive Documentation**    

[AWS Documentation: EC2 Memory Options Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/memory-optimized-instances.html)     
    
```Terraform
###########################################################
#- Memory Per Instance -----------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_memory_enabled_config_index_key = "config_000"
instance_memory_configurations = {
# ABLE TO CREATE MORE THAN ONE CONFIG
    #-----------------------------------------------------#
    config_000 = {
            #- Instance Memory -#
            kernel_id = "" # The kernal ID to use to when launching instance
            ram_disk_id = "" # The ram disk ID to use when launching instances

            #- Instance Memory Requirements -#
            requirements = {
                memory_mib = { min = 0, max = 0 } # The min max of memory (mib) that is required when launching instances
                memory_gib_per_vcpu = { min = 0, max = 0 } # The min max memory per vcpu that is required when launching instances
            }
    }
    #-----------------------------------------------------#
    }
```     
   
### Instance GPU Settings      

Please use the section to below to specify how the GPU will be configured for the launch template.  

**Supporive Documentation**     

[AWS Documentation: EC2 GPU Options Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/accelerated-computing-instances.html)       

```Terraform
###########################################################
#- GPU Per Instance --------------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_gpu_enabled_config_index_key = "config_000"
instance_gpu_configurations = {
# ABLE TO CREATE MORE THAN ONE CONFIG
    #-----------------------------------------------------#
    config_000 = { 
            #- Instance GPU -#
            gpu_type = "" # The type of elastic GPU to associate with the launch template
    }
    #-----------------------------------------------------#   
} 
```       

### Instance Accelerator Settings      

Please use the section below to specify how instance accelerators will be configured with the launch template      

**Supportive Documentation**     

[AWS Documentation: Inference Accelerator Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-inference.html)      

```Terraform
 ###########################################################
#- Instance Accelerators Per Instance --------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_accelerators_enabled_config_index_key = "config_000"
instance_accelerators_configurations = {
# ABLE TO CREATE MORE THAN ONE CONFIG
    #-----------------------------------------------------#
    config_000 = {
        #- Instance Accelerator Requirements -#
        requirements = {
            accelerator_manufacturers = [] # Manufacterers serving instance accelerators to apply to the launch template
            accelerator_names = [] # Names of instance accelerators to apply to the launch template
            accelerator_types = [] # Types of instances accelerators to apply to the launch template
            accelerator_count = { min = 0, max = 0 } # Min and Max number of accelerators to apply to an instance
            accelerator_total_memory_mib = { min = 0, max = 0 } # Total amount amount of memory the launch template will accept when launching an instance accelerator 
        } } 
    #-----------------------------------------------------#
} 
```      

### Instance Storage Settings       

Please use the section below to specify how Instance storage should be configured with the launch tempatate.      

**Supportive Documentation**   

[AWS Documentation: EC2 Block Device Mappings Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html)      

[AWS Documentation: KMS Key Resource Reference](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html)       

```Terraform 
###########################################################
#- Storage Per Instance ----------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_storage_enabled_config_index_key = "config_000"
instance_storage_configurations = {
# ABLE TO CREATE MORE THAN ONE CONFIG
    #-----------------------------------------------------#
    config_000 = {
            #- Instance Block Devices -#
            ebs_optimized = false # Whether or not EBS launched will be optimized
            block_device_mappings = {
            # Must include "ebs_" | "eph_" as prefix of the index key to specify Elastic Block Storage or Instance Storage
            # ebs == Elastic Block Storage, eph = Instance Storage
            # ABLE TO CREATE MORE THAN ONE Block Device Mapping
                        #-------------------------------------#
                        eph_000 = {
                            virtual_name = "" # Name for the instance storage # ephemeralN, N == 1 - 22
                            device_name = "" # Path on instance to map the instance storage to
                            no_device = "" # The mount path of a storage mapping in the AMI to supress 
                            encrypted = false # if snapshot_id != "" then conflict
                            kms_key_id = "" # Key ID of an existing KMS key to use in encrypting the EBS device
                            create_kms_key_index_key = "" # The index key of one of the created KMS keys below to use for encryption
                            iops = 0 # Amount of provisions IOPS # Only valid if volume_type == io1 | io2
                            throughput = 0 # Throughput to provision for a gp3 volume type # In MiBs
                            volume_size = 8 # Size of the volume in GBs
                            snapshot_id = "" # Id of am EBS snapshot to associate with this device mapping
                        }
                        #-------------------------------------#
                        #-------------------------------------#
                        ebs_000 = {
                            device_name = "" # Path on instance to map the instance storage to
                            no_device = "" # The mount path of a storage mapping in the AMI to supress
                            delete_on_termination = false 
                            encrypted = false # if snapshot_id != "" then conflict
                            kms_key_id = "" # Whether or not delete the EBS device when the instance is terminated
                            create_kms_key_index_key = "" # The index key of one of the created KMS keys below to use for encryption
                            volume_type = "" # Volume type to specify # standard | gp2 | gp3 | io1 | io2 | sc1 | st1 
                            iops = 0 # Amount of provisions IOPS # Only valid if volume_type == io1 | io2
                            throughput = 0 # Throughput to provision for a gp3 volume type # In MiBs
                            volume_size = 8 # Size of the volume in GBs
                            snapshot_id = "" # Id of am EBS snapshot to associate with this device mapping
                        }
                        #-------------------------------------#
            }

            #- KMS Encryption -#
            create_kms_keys = {
            # ABLE TO CREATE MORE THAN ONE KMS KEY   

                    #-------------------------------------#
                    create_kms_key_000 = {
                        kms_key_name = "" # A name for the KMS key that will be listed as a tag 
                        key_usage = "" # The intended use of the key # ENCRYPT_DECRYPT | SIGN_VERIFY  
                        cstmr_mstr_key_spec = "" # Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms the key supports 
                        is_enabled = true # Whether or not the key is enabled
                        key_rotation_enabled = false # Whether or not key rotation is enabled
                        policy_file = "" # Local path to JSON file with valid IAM syntax
                        bypass_policy_lockout_safety_check = false # A flag to indicate whether or not to bypass the key policy lockout safety check
                    }
                    #-------------------------------------#
            }

            #- Instance Storage Requirements -#
            requirements = {
                local_storage = "" # included | excluded | required # Indicate whether or not instance types with instance storage volumes are reqired or not
                local_storage_types = [] # List of instance storage type name the launch template will accept
                total_local_storage_gb = { min = 0, max = 0 } # The min and max of the total allocated storage assigned to the instance storage volumes
                baseline_ebs_bandwidth_mbps = { min = 0, max = 0 } # Min and Max baseline for EBS bandwidth
            }
    }
    #-----------------------------------------------------#
} 
```       

### Instance Netorking Settings     

Please use the section below to specify how network interfaces (ENIs) will be configured with the launch template.    
   
**Supportive Documentation**   
    
[AWS Documentation: Network Interfaces (ENIs) Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html)    
  
[AWS Documentation: Security Group Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)    

```Terraform
###########################################################
#- Instance Networking -----------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_networking_enabled_config_index_key = "config_000"
instance_networking_configurations = {
    #-----------------------------------------------------#
    config_000 = {
            #- Instance ENI -#
            network_interfaces = {
            # ABLE TO CREATE MORE THAN ONE NETWORK INTERFACE

                    #-------------------------------------#
                    eni_000 = {
                        delete_on_termination = false # Whether or not delete ENI when instance is terminated
                        #- Existing ENI -#
                        get_eni_by_id = "" # The ID of an existing ENI to associate to the instance
                        #- Create ENI -#
                        name = "" # Name for the eni that will be merged with the tags
                        description = "" # Description for the ENI
                        interface_type = "efa" # The interface type for the ENI
                        device_index = 0 # The ENI mapping index to use when associating with an EC2 instance
                        network_card_index = 0 # The index of the network card
                        associate_carrier_ip_address = false # Whether or not associate a carrier IP address with the ENI
                        associate_public_ip_address = false # Whether or not to associate a public IP address with the ENI
                        ipv4 = {
                            ipv4_address_type = "" # "[count]" | "[list]" # Specifies if IP addresses will be allocated based on number of or list of IP addresses
                            ipv4_address_value = [] # If count is specified [number] | If count is specified [IP address list]
                            ipv4_prefix_type = "" # "[count]" | "[list]" # Specifies if IP prefixes will be allocated based on number of or list of IP prefixes
                            ipv4_prefix_value = [] # If count is specified [number] | If count is specified [IP prefix list]
                        }
                        ipv6 = {
                            ipv6_address_type = "" # "[count]" | "[list]" # Specifies if IP addresses will be allocated based on number of or list of IP addresses
                            ipv6_address_value = [] # If count is specified [number] | If count is specified [IP address list]
                            ipv6_prefix_type = "" # "[count]" | "[list]" # Specifies if IP prefixes will be allocated based on number of or list of IP prefixes
                            ipv6_prefix_value = [] # If count is specified [number] | If count is specified [IP prefix list]
                        }
                        #- Placement -#
                        subnet_id = "" # The subnet ID of which to deploy the ENI into
                        #- Firewall -#
                        security_group_index_keys = ["create_secgrp_000"] # The index keys taken from the security groups listed below to associate with the ENI
                        
                        }
                    #-------------------------------------#
            }

            #- Instance Security Groups -#
            get_create_security_groups = {
            # If getting security group id, index key must start with "get_"
            # If creating a new security group, index key must start with "create_"
            # ABLE TO CREATE MORE THAN ONE SECURTIY GROUP SPECIFICATION
                    #-------------------------------------#
                    # get_secgrp_000 = {}
                    #-------------------------------------#
                    create_secgrp_000 = [
                        # Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
                        "Ingress|IPv4|0.0.0.0/0|-1|0|0|allTraffic",
                    ]
                    #-------------------------------------#
            }

            #- Private DNS Options -#
            private_dns_name_options = {
                enable_resource_name_dns_aaaa_record = false # Whether to respond to DNS queries for instance hostnames with DNS AAAA records
                enable_resource_name_dns_a_record = false # Whether to respond to to DNS queries for instance hostnames wi the DNS A records
                hostname_type = "ip-name" # ip-name | resource-name # The type of hostname for EC2 instances. 
            }

            #- Instance Networking Requirements -#
            requirements = {
                network_interface_count = { min = 0, max = 0 } # The min and max number of ENI(s) to configure with instances launched by Launch Template
            } 
    }
    #-----------------------------------------------------#
} 
```      

### Instance Offline Settings    

Please use the section below to specify how the instances going offline will be configured with the launch template.       
   
```Terraform 
###########################################################
#- Instance Offline --------------------------------------#
###########################################################
#- Configuration Notes -----------------------------------#


#---------------------------------------------------------#
instance_offline_enabled_config_index_key = "config_000"
instance_offline_configurations = {
    #-----------------------------------------------------#
    config_000 = {
            #- Instance Offline -#
            auto_recovery_enabled = "default" # default | disabled # Whether or not to have auto recovery behavior for instances enabled
            disable_api_termination = false # If true, enables EC2 Instance termination protection
            instance_initiated_shutdown_behavior = "stop" # stop | terminate # Shutodown behavior for the instance

            #- Instance Offline Requirements -#
            requirements = {
                hibernation_option_enabled = false # Whether or not hibernation should be enabled for the instance
            }}
    #-----------------------------------------------------#
}
###########################################################
```    
    
## Output Samples     

Please reference the below output samples to output values created from the module.    

```Terraform
#######################################
## Launch Template Outputs ##
#######################################
#--Sample ----------------------------------#
# output "Launch_Template_Export_Attribute" {
#   value = aws_launch_template.new_ec2_launch_template["lt_values"].export_attribute
# }
#-------------------------------------------#


################################
## ENI Security Group Outputs ##
################################
#--Sample ----------------------------------#
# output "Launch_Template_Security_Group_Index_Key_Export_Attribute" {
#   value = aws_security_group.lt_create_security_group["Security_Group_Index_Key"].export_attribute
# }
#-------------------------------------------#

```
