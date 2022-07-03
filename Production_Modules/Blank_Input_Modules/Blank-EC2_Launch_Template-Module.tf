module "BLANK_EC2_LAUNCH_TEMPLATE" {
source = ""
 
###########################
## Version History Notes ##
###############################################################
# v1.0.0 - Created the first iteration of the launch template.



###############################################################

    ###########################################################
    #- Launch Template ---------------------------------------#
    ###########################################################
    launch_template_name = ""
    launch_template_name_prefix = false # Creates new launch template if set to true after versions of false
    description = ""
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
    #- Configuration Notes -----------------------------------#


    #---------------------------------------------------------#
    instance_boot_enabled_config_index_key = "config_000"
    instance_boot_configurations = {
        #-----------------------------------------------------#    
        config_000 = {
                #- Instance AMI -#
                get_ami_type = "" # ami_id | copy_ami | copy_ami_instance
                get_ami_values = {  
                    /* Please reference the module manual for values to specify */
                 }

                #- Licensing -#
                license_configuration_arn = ""

                #- User Data -#
                user_data = {
                    file = "" # Local path to Shell script | cloud-init script
                    vars = {
                        #"env_key" = "env_value"
                } }

                #- Metadata Options -#
                metadata_options = {
                    http_endpoint = "" # enabled | disabled 
                    http_tokens = "" # optional | required
                    http_put_response_hop_limit = 10
                    htttp_protocol_ipv6 = "" # enabled | disabled
                    instance_metadata_tags = "" # enabled | disabled
                }

                #- Instance Access -#
                iam_instance_profile = {
                    #- Existing -#
                    arn = ""
                    #- New -#
                    instance_profile_name = ""
                    path = "/"
                    policy_file = "" # Local path to JSON file with valid IAM  syntax
                }

                #- Instance SSH -#
                ssh_key_pair = {
                    #- Existing -#
                    existing_key_pair_name = ""
                    #- New Key Pair -#
                    new_key_pair_name = ""
                    public_key_file = "" # Local path to public key file
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


    #---------------------------------------------------------#
    instance_types_enabled_config_index_key = "config_000"
    instance_types_configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- Instance Type -#
                instance_type = "" # Overrides all requirements sections if specified

                #- Spot Instances -#
                enable_spot_options = true
                spot_options = {
                    block_duration_minutes = 0 # In increments of 60 min # null == 0
                    instance_interruption_behavior = "" # hibernate | stop | terminate
                    max_price = ""
                    spot_instance_type = "" # one-time | persistent
                    valid_until = "" # Default is 7 days from creation
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
                            preference = "" # open | none | null
                            end_date = "" # YYYY-MM-DDTHH:MM:SSZ
                            end_date_type = "" # unlimited | limited
                            instance_count = 1 # Required
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

                #- Instance Placement -#
                enable_placement = false
                placement = {
                    group_name = ""
                    host_resource_group_arn = ""
                    affinity = ""
                    availability_zone = ""
                    host_id = "" 
                    spread_domain = ""
                    tenancy = "" # default | dedicated | host
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
                cpu_credits = "" # standard | unlimited
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
                            virtual_name = "" # ephemeralN, N == 1 - 22
                            device_name = ""
                            no_device = ""
                            encrypted = true # if snapshot_id != "" then conflict
                            kms_key_id = ""
                            create_kms_key_index_key = ""
                            iops = 0
                            throughput = 0
                            volume_size = 0
                            snapshot_id = "" 
                        }
                        #-------------------------------------#
                        #-------------------------------------#
                        ebs_000 = {
                            device_name = ""
                            no_device = ""
                            delete_on_termination = false
                            encrypted = false # if snapshot_id != "" then conflict
                            kms_key_id = ""
                            create_kms_key_index_key = ""
                            volume_type = ""
                            iops = 0
                            throughput = 0
                            volume_size = 0
                            snapshot_id = "" 
                        }
                        #-------------------------------------#
                }

                #- KMS Encryption -#
                create_kms_keys = {
                        #-------------------------------------#
                        create_kms_key_000 = {
                            kms_key_name = ""
                            key_usage = ""
                            cstmr_mstr_key_spec = ""
                            is_enabled = false
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
                            interface_type = "" # interface | efa
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
                            subnet_id = ""
                            #- Traffic -#
                            security_group_index_keys = []
                            
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
                    enable_resource_name_dns_a_record = false
                    hostname_type = "" # ip-name | resource-name
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
                auto_recovery_enabled = "" # default | disabled
                disable_api_termination = false
                instance_initiated_shutdown_behavior = "" # stop | terminate

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