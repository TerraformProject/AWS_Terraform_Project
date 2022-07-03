module "EC2_LAUNCH_TEMPLATE_AWS_PROJECT" {
source = "../Back_End_Modules/EC2_Launch_Template-Module"
 
###########################
## Version History Notes ##
###############################################################
# v1 - Created the first iteration of the launch emplate. Deployed to stage environment.

###############################################################

    ###########################################################
    #- Launch Template ---------------------------------------#
    ###########################################################
    launch_template_name = "Launch_Template_AWS_PROJECT"
    launch_template_name_prefix = false # Creates new launch template if set to true after versions of false
    description = "This is a launch template to serve as a use case for the AWS Project"
    default_version = 1
    update_default_version = false
    tag_specifications = {
    #   tag_000 =
    #        resource_type = "", tag_key = "", tag_value = ""
    #     }  
    }

    ###########################################################
    #- Instance Boot -----------------------------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#
    # v1 - Base AWS ami is used to boot instance. Userdata install Apache Webserver.
    #      Policy is pulled from local dir to create instance profile. SSH key file is 
    #      pulled from local dir to create ssh key pair (not secure I know)

    #---------------------------------------------------------#
    instance_boot_enabled_config_index_key = "config_000"
    instance_boot_configurations = {
        #-----------------------------------------------------#    
        config_000 = {
                #- Instance AMI -#
                get_ami_type = "ami_id" # ami_id | copy_ami | copy_ami_instance
                get_ami_values = {  
                    /* Please reference the module manual for values to specify */
                    #- ami_id -#
                    ami_id = "ami-0cff7528ff583bf9a"
                 }

                #- Licensing -#
                license_configuration_arn = ""

                #- User Data -#
                user_data = {
                    file = "Stage_Modules/Standby_Folder/Scripts/mariadb-userdata.sh" # Local path to Shell script | cloud-init script
                    vars = {
                        #"env_key" = "env_value"
                } }

                #- Metadata Options -#
                metadata_options = {
                    http_endpoint = "enabled" # enabled | disabled 
                    http_tokens = "optional" # optional | required
                    http_put_response_hop_limit = 10
                    htttp_protocol_ipv6 = "disabled" # enabled | disabled
                    instance_metadata_tags = "enabled" # enabled | disabled
                }

                #- Instance Access -#
                iam_instance_profile = {
                    #- Existing -#
                    arn = ""
                    #- New -#
                    instance_profile_name = "EC2MariaDB"
                    path = "/"
                    policy_file = "Stage_Modules/Standby_Folder/Scripts/mariadb-instanceprofile.json" # Local path to JSON file with valid IAM  syntax
                }

                #- Instance SSH -#
                ssh_key_pair = {
                    #- Existing -#
                    existing_key_pair_name = ""
                    #- New Key Pair -#
                    new_key_pair_name = "test_key_pair"
                    public_key_file = "Stage_Modules/Standby_Folder/Scripts/mariadb-publickey.ppk" # Local path to public key file
                }
                #- Monitoring -#
                enable_detailed_instance_monitoring = false
        } 
        #-----------------------------------------------------#
    }

    ###########################################################
    #- Instance Types ----------------------------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#
    # v1 - t2.micro instance type is used for the instance. Spot options are enabled
    #      and configured. 

    #---------------------------------------------------------#
    instance_types_enabled_config_index_key = "config_000"
    instance_types_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- Instance Type -#
                instance_type = "t2.micro" # Overrides all requirements sections if specified

                #- Spot Instances -#
                enable_spot_options = true
                spot_options = {
                    block_duration_minutes = 0 # In increments of 60 min # null == 0
                    instance_interruption_behavior = "stop" # hibernate | stop | terminate
                    max_price = ""
                    spot_instance_type = "persistent" # one-time | persistent
                    valid_until = "2022-07-05T07:20:50.52Z" # Default is 7 days from creation
                }

                #- Capacity Reservation -#
                capacity_reservation = {
                enabled_capacity_reservation_type = "none" # existing | create | none
                    #-----------------------------------------#
                    existing = {
                            preference = "" # open | none | null
                            capacity_reservation_id = ""
                            capacity_reservation_resource_group_arn = ""
                    }
                    #-----------------------------------------#
                    create = {
                            preference = "null" # open | none | null
                            end_date = "2022-07-27T00:00:00Z" # YYYY-MM-DDTHH:MM:SSZ
                            end_date_type = "limited" # unlimited | limited
                            instance_count = 1 # Required
                            availability_zone = "us-east-1a"
                            outpost_arn = ""
                            #- Required Criteria to Activate -#
                            instance_platform = "Linux/UNIX" # Required
                            instance_type = "t2.micro" # Required
                            #- Optional Criteria to Activate -#
                            instance_match_criteria = "open" # open | targeted
                            tenancy = "default" # default | dedicated
                            ebs_optimized = false
                            ephemeral_storage = false
                            tags = {}
                    }
                    #-----------------------------------------#
                }

                #- Instance Placement -#
                enable_placement = false
                placement = {
                    group_name = ""
                    host_resource_group_arn = ""
                    affinity = ""
                    availability_zone = ""
                    host_id = "" 
                    spread_domain = ""
                    tenancy = "default" # default | dedicated | host
                    partition_number = 0
                }

                #- Instance Type Requirements -#
                requirements = {
                    instance_generations = []
                    excluded_instance_types = []
                    bare_metal_instances = "" # included | excluded | required
                }
        }
        #-----------------------------------------------------#
    } 

    ###########################################################
    #- CPU Per Instance --------------------------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#

    #---------------------------------------------------------#
    instance_cpu_enabled_config_index_key = "config_000"
    instance_cpu_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- Instance CPU -#
                core_count = 0 # Unable to exceed default CPU core count. ( Default vCPU number / 2 = Default core count)
                threads_per_core = 0 # 2 enables multithreading | 1 Disables Multithreading. Required if core_count > 0
                cpu_credits = "standard" # standard | unlimited
                elastic_inference_accelerator_type = ""

                #- Nitro Enclaves -#
                enable_nitro_enclaves = false

                #- Instance CPU Requirements -#
                requirements = {
                    cpu_manufacturers = []
                    vcpu_count = { min = 0, max = 0 }
                    burstable_performance = "" # included | excluded | required
                }
        }
        #-----------------------------------------------------#
    } 

    ###########################################################
    #- Memory Per Instance -----------------------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#

    #---------------------------------------------------------#
    instance_memory_enabled_config_index_key = "config_000"
    instance_memory_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- Instance Memory -#
                kernal_id = "" 
                ram_disk_id = ""

                #- Instance Memory Requirements -#
                requirements = {
                    memory_mib = { min = 0, max = 0 }
                    memory_gib_per_vcpu = { min = 0, max = 0 }
                }
        }
        #-----------------------------------------------------#
    }

    ###########################################################
    #- GPU Per Instance --------------------------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#

    #---------------------------------------------------------#
    instance_gpu_enabled_config_index_key = "config_000"
    instance_gpu_configurations = {
        #-----------------------------------------------------#
        config_000 = { 
                #- Instance GPU -#
                gpu_type = ""
        }
        #-----------------------------------------------------#   
    } 

    ###########################################################
    #- Instance Accelerators Per Instance --------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#

    #---------------------------------------------------------#
    instance_accelerators_enabled_config_index_key = "config_000"
    instance_accelerators_configurations = {
        #-----------------------------------------------------#
        config_000 = {
            #- Instance Accelerator Requirements -#
            requirements = {
                accelerator_manufacturers = []
                accelerator_names = []
                accelerator_types = []
                accelerator_count = { min = 0, max = 0 }
                accelerator_total_memory_mib = { min = 0, max = 0 }
            } } 
        #-----------------------------------------------------#
    } 
    ###########################################################
    #- Storage Per Instance ----------------------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#
    # v1 - Two additional storage devices are attached to the instance. One being 
    #     instance storage device (/dev/sdb), the other is an EBS block device (/dev/sdf). 
    #     Both storage devices are encrypted with a KMS key created by specifying the index key in 
    #     the create KMS key section. 
    #---------------------------------------------------------#
    instance_storage_enabled_config_index_key = "config_000"
    instance_storage_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- Instance EBS -#
                ebs_optimized = false
                block_device_mappings = {
                # Must include "ebs_" | "eph_" as prefix of the index key to specify Elastic Block Storage or Instance Storage
                # ebs == Elastic Block Storage, eph = Instance Storage
                # ABLE TO CREATE MORE THAN ONE Block Device Mapping
                        #-------------------------------------#
                        eph_000 = {
                            virtual_name = "ephemeral5" # ephemeralN, N == 1 - 22
                            device_name = "/dev/sdb"
                            no_device = ""
                            encrypted = true # if snapshot_id != "" then conflict
                            kms_key_id = ""
                            create_kms_key_index_key = "create_kms_key_000"
                            iops = 2000
                            throughput = 0
                            volume_size = 8
                            snapshot_id = "" 
                        }
                        #-------------------------------------#
                        #-------------------------------------#
                        ebs_000 = {
                            device_name = "/dev/sdf"
                            no_device = ""
                            delete_on_termination = true
                            encrypted = true # if snapshot_id != "" then conflict
                            kms_key_id = ""
                            create_kms_key_index_key = "create_kms_key_000"
                            volume_type = "standard"
                            iops = 0
                            throughput = 0
                            volume_size = 8
                            snapshot_id = "" 
                        }
                        #-------------------------------------#
                }

                #- KMS Encryption -#
                create_kms_keys = {
                        #-------------------------------------#
                        create_kms_key_000 = {
                            kms_key_name = "test_key"
                            key_usage = "ENCRYPT_DECRYPT"
                            cstmr_mstr_key_spec = "SYMMETRIC_DEFAULT"
                            is_enabled = true
                            key_rotation_enabled = false
                            policy_file = "" # Local path to JSON file with valid IAM  syntax
                            bypass_policy_lockout_safety_check = false
                        }
                        #-------------------------------------#
                }

                #- Instance Storage Requirements -#
                requirements = {
                    local_storage = "" # included | excluded | required
                    local_storage_types = []
                    total_local_storage_gb = { min = 0, max = 0 }
                    baseline_ebs_bandwidth_mbps = { min = 0, max = 0 }
                }
        }
        #-----------------------------------------------------#
    } 
    ###########################################################
    #- Instance Networking -----------------------------------#
    ###########################################################
    #- Configuration Notes -----------------------------------#
    # v1 - One ENI is created for the instance and is assigned a public ip. Once 
    #     auto scaling groups are involved, a specific ENI will not be associated as one 
    #     ENI is not able to be associated with more than one instance when autoscaling is involved. 
    #     Instead the min/max requirement below will be used to for this autoscaling use case. 
    #---------------------------------------------------------#
    instance_networking_enabled_config_index_key = "config_000"
    instance_networking_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- Instance ENI -#
                network_interfaces = {
                        #-------------------------------------#
                        eni_000 = {
                            delete_on_termination = false
                            #- Existing ENI -#
                            get_eni_by_id = ""
                            #- Create ENI -#
                            name = ""
                            description = ""
                            interface_type = "interface" # interface | efa
                            device_index = 0
                            network_card_index = 0
                            associate_carrier_ip_address = false
                            associate_public_ip_address = true
                            ipv4 = {
                                ipv4_address_type = "" # "[count]" | "[list]"
                                ipv4_address_value = []
                                ipv4_prefix_type = "" # "[count]" | "[list]"
                                ipv4_prefix_value = []
                            }
                            ipv6 = {
                                ipv6_address_type = "" # "[count]" | "[list]"
                                ipv6_address_value = []
                                ipv6_prefix_type = "" # "[count]" | "[list]"
                                ipv6_prefix_value = []
                            }
                            #- Placement -#
                            subnet_id = module.VPC_AWS_PROJECT.PubSub_001_VPC_001_id
                            #- Traffic -#
                            security_group_index_keys = ["create_secgrp_000"]
                            
                            }
                        #-------------------------------------#
                }

                #- Instance Security Groups -#
                get_create_security_groups = {
                # If getting security group id, index key must start with "get_"
                # If creating a new security group, index key must start with "create_"
                        #-------------------------------------#
                        # get_secgrp_000 = {}
                        #-------------------------------------#
                        create_secgrp_000 = [
                            # Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
                            "Ingress|IPv4|0.0.0.0/0|-1|0|0|allTraffic",
                            "Egress|IPv4|0.0.0.0/0|-1|0|0|allTraffic"
                        ]
                        #-------------------------------------#
                }

                #- Private DNS Options -#
                private_dns_name_options = {
                    enable_resource_name_dns_aaaa_record = false
                    enable_resource_name_dns_a_record = true
                    hostname_type = "ip-name" # ip-name | resource-name
                }

                #- Instance Networking Requirements -#
                requirements = {
                    network_interface_count = { min = 0, max = 0 }
                } 
        }
        #-----------------------------------------------------#
    } 
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
                auto_recovery_enabled = "default" # default | disabled
                disable_api_termination = false
                instance_initiated_shutdown_behavior = "stop" # stop | terminate

                #- Instance Offline Requirements -#
                requirements = {
                    hibernation_option_enabled = false
                }}
        #-----------------------------------------------------#
    }
    ###########################################################

###################
## END OF MODULE ##
###################
}