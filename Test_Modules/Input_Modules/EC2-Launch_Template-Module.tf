module "LAUNCH_TEMPLATE_ASG_AWS_PROJECT" {
source = "../Back_End_Modules/Launch_Template_ASG-Module"
 
###########################
## Version History Notes ##
###############################################################
# v1.0.0 - Created the first iteration of the launch template.



###############################################################

    ###########################################################
    #- Launch Template ---------------------------------------#
    ###########################################################
    launch_template_name = "test_lt"
    launch_template_name_prefix = false
    description = "This is a test launch template"
    default_version = 1
    update_default_version = false
    tag_specifications = {
    #   tag_000 = {
    #        resource_type = "", tag_key = "", tag_value = ""
    #     }  
    }
    ###########################################################
    #- Instance Boot -----------------------------------------#
    ###########################################################
    instance_boot_enabled_config_index_key = "config_000"
    instance_boot_configurations = {
        #-----------------------------------------------------#    
        config_000 = {
                #- AMI -#
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
                    file = "Test_Modules/Standby_Folder/Scripts/mariadb-userdata.sh" # Local path to Shell script | cloud-init script
                    env_vars = {
                        #"env_key" = "env_value"
                } }
                metadata_options = {
                    http_endpoint = "disabled" # enabled | disabled 
                    http_tokens = "optional" # optional | required
                    http_put_response_hop_limit = 1
                    htttp_protocol_ipv6 = "disabled" # enabled | disabled
                    instance_metadata_tags = "disabled" # enabled | disabled
                }
                #- Access -#
                iam_instance_profile = {
                    #- Existing -#
                    arn = ""
                    #- New -#
                    instance_profile_name = ""
                    path = "/"
                    policy_file = "" # Local path to JSON file with valid IAM  syntax
                }
                ssh_key_pair = {
                    #- Existing -#
                    existing_key_pair_name = ""
                    #- New Key Pair -#
                    new_key_pair_name = "test_key_pair"
                    public_key_file = "Test_Modules/Standby_Folder/Scripts/mariadb-publickey.ppk" # Local path to public key file
                }
                #- Monitoring -#
                enable_detailed_instance_monitoring = false
        } 
        #-----------------------------------------------------#
}
    ###########################################################
    #- Instance Types ----------------------------------------#
    ###########################################################
    instance_types_enabled_config_index_key = "config_000"
    instance_types_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                instance_type = "t2.micro" # Overrides all requirements sections if specified
                enable_spot_options = false
                spot_options = {
                    block_duration_minutes = 0
                    instance_interruption_behavior = "" # hibernate | stop | terminate
                    max_price = ""
                    spot_instance_type = "" # one-time | persistent
                    valid_until = ""
                }
                capacity_reservation = {
                enabled_capacity_reservation_type = "none" # existing | create | none
                    #-----------------------------------------#
                    existing = {
                            preference = "" # open | none
                            capacity_reservation_id = ""
                            capacity_reservation_resource_group_arn = ""
                    }
                    #-----------------------------------------#
                    create = {
                            preference = "" # open | none
                            end_date = "" # YYYY-MM-DDTHH:MM:SSZ
                            end_date_type = "" # unlimited | limited
                            instance_count = 0 # Required
                            availability_zone = ""
                            outpost_arn = ""
                            #- Required Criteria to Activate -#
                            instance_platform = "" # Required
                            instance_type = "" # Required
                            #- Optional Criteria to Activate -#
                            instance_match_criteria = "" # open | targeted
                            tenancy = "" # default | dedicated
                            ebs_optimized = false
                            ephemeral_storage = false
                            tags = {}
                    }
                    #-----------------------------------------#
                }
                placement = {
                    affinity = ""
                    availability_zone = ""
                    group_name = ""
                    host_id = "" 
                    host_resource_group_arn = ""
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
    instance_cpu_enabled_config_index_key = "config_000"
    instance_cpu_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                core_count = 0
                threads_per_core = 0 
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
    instance_memory_enabled_config_index_key = "config_000"
    instance_memory_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                kernel_id = ""
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
    instance_gpu_enabled_config_index_key = "config_000"
    instance_gpu_configurations = {
        #-----------------------------------------------------#
        config_000 = { gpu_type = "" }
        #-----------------------------------------------------#   
    } 
    ###########################################################
    #- Instance Accelerators Per Instance --------------------#
    ###########################################################
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
    instance_storage_enabled_config_index_key = "config_000"
    instance_storage_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- EBS -#
                ebs_optimized = false
                ebs_blocks = {
                        #-------------------------------------#
                        ebs_000 = {
                            device_name = "test-ebs"
                            no_device = ""
                            virtual_name = "ephemeral10"
                            ebs = {
                                delete_on_termination = true
                                encrypted = true # if snapshot_id != "" then conflict
                                kms_key_id = ""
                                create_kms_key_index_key = "create_kms_key_000"
                                volume_type = "standard"
                                iops = 0
                                throughput = 0
                                volume_size = 8
                                snapshot_id = "" 
                        } }
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
    instance_networking_enabled_config_index_key = "config_000"
    instance_networking_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- ENI -#
                network_interfaces = {
                        #-------------------------------------#
                        eni_000 = {
                            delete_on_termination = false
                            #- Existing ENI -#
                            get_eni_by_id = ""
                            #- Create ENI -#
                            name = ""
                            description = ""
                            interface_type = "efa"
                            device_index = 0
                            network_card_index = 0
                            associate_carrier_ip_address = false
                            associate_public_ip_address = false
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
                            subnet_id = ""
                            #- Traffic -#
                            security_group_index_keys = []
                            
                            }
                        #-------------------------------------#
                }
                #- Security Groups -#
                get_create_security_groups = {
                # If getting security group id, index key must start with "get_"
                # If creating a new security group, index key must start with "create_"
                        # #-------------------------------------#
                        # get_secgrp_000 = {}
                        # #-------------------------------------#
                        #-------------------------------------#
                        create_secgrp_000 = [
                            # Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
                            "Ingress|IPv4|0.0.0.0/0|-1|0|0|allTraffic",
                        ]
                        #-------------------------------------#
                        #- Security Group VPC ID -------------#
                        vpc_id = "vpc-b46da2c9"
                        #-------------------------------------#
                }
                #- DNS -#
                private_dns_name_options = {
                    enable_resource_name_dns_aaaa_record = false
                    enable_resource_name_dns_a_record = false
                    hostname_type = "ip-name" # ip-name | resource-name
                }
                #- Instance Networking Requirements -#
                requirements = {
                    network_interface_count = { min = 1, max = 1 }
                } 
        }
        #-----------------------------------------------------#
    } 
    ###########################################################
    #- Instance Offline --------------------------------------#
    ###########################################################
    instance_offline_enabled_config_index_key = "config_000"
    instance_offline_configurations = {
        #-----------------------------------------------------#
        config_000 = {
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