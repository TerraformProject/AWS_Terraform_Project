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
    launch_template_name = ""
    launch_template_name_prefix = false
    description = ""
    default_version = ""
    update_default_version = false
    ###########################################################
    #- Instance Boot -----------------------------------------#
    ###########################################################
    Instance_Boot = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#    
        config_000 = {
                #- AMI -#
                get_ami_type = "" # ami_id | copy_ami | copy_ami_instance
                get_ami_values = {  
                    /* Please reference the module manual for values to specify */
                    #Send to Module Manual. Consolidate the module!#
                    #- ami_id -#
                    ami_id = ""
                    #- copy_ami -#
                    new_ami_name              = ""
                    description       = ""
                    source_ami_id     = ""
                    source_ami_region = ""
                    destination_outpost_arn = ""
                    encrypted = false
                    kms_key_id = ""
                    copy_ami_tags = {}
                    #- copy_ami_instance -#
                    new_ami_name               = ""
                    source_instance_id = ""
                    snapshot_without_reboot = false
                    copy_ami_instance_tags = {}

                 }
                #- Licensing -#
                license_configuration_arn = ""
                #- User Data -#
                user_data = {
                    file = "" # Local path to Shell script | cloud-init script
                    env_vars = {
                        "env_key" = "env_value"
                } }
                metadata_options = {
                    http_endpoint = "" # enabled | disabled 
                    http_tokens = "" # optional | required
                    http_put_response_hop_limit = 1
                    htttp_protocol_ipv6 = "" # enabled | disabled
                    instance_metadata_tags = "" # enabled | disabled
                }
                #- Access -#
                iam_instance_profile = {
                    #- Existing -#
                    arn = ""
                    #- New -#
                    instance_profile_name = ""
                    path = ""
                    policy_file = "" # Local path to JSON file with valid IAM  syntax
                }
                ssh_key_pair = {
                    #- Existing -#
                    existing_key_pair_name = ""
                    #- New Key Pair -#
                    new_key_pair_name = ""
                    public_key_file = "" # Local path to public key file
                }
                #- Monitoring -#
                enable_detailed_instance_monitoring = false
        } }
        #-----------------------------------------------------#
    } 
    ###########################################################
    #- Instance Types ----------------------------------------#
    ###########################################################
    Instance_Types = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#
        config_000 = {
                instance_type = ""
                instance_type_requirements = {
                    #- Set as required if specified -#
                    instance_generations = []
                    excluded_instance_types = []
                    bare_metal_instances = "" # included | excluded | required
        } }
        #-----------------------------------------------------#
    } }
    ###########################################################
    #- CPU Per Instance --------------------------------------#
    ###########################################################
    Instance_CPU = {
    enabled_config_index_key = "config_000"
    congifurations = {
        #-----------------------------------------------------#
        config_000 = {
                core_count = 0
                threads_per_core = 0 
                cpu_credits = "" # standard | unlimited
                elastic_inference_accelerator_type = ""
                instance_cpu_requirements = {
                    #- Set as required if specified -#
                    cpu_manufacturers = []
                    vcpu_count = { min = 0, max = 0 }
                    burstable_performance = "" # included | excluded | required
                }
                #- Nitro Enclaves -#
                enable_nitro_enclaves = false
        }
        #-----------------------------------------------------#
    } }
    ###########################################################
    #- Memory Per Instance -----------------------------------#
    ###########################################################
    Instance_Memory = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#
        config_000 = {
                kernel_id = ""
                ram_disk_id = ""
                instance_memory_requirements = {
                    #- Set as required if specified -#
                    memory_mib = { min = 0, max = 0 }
                    memory_gib_per_vcpu = { min = 0, max = 0 }
                }
        }
        #-----------------------------------------------------#
    } }
    ###########################################################
    #- GPU Per Instance --------------------------------------#
    ###########################################################
    Instance_GPU = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#
        config_000 = { gpu_type = "" }
        #-----------------------------------------------------#   
    } }
    ###########################################################
    #- Instance Accelerators Per Instance --------------------#
    ###########################################################
    Instance_Accelerators = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#
        config_000 = {
            instance_accelerator_requirements = {
                #- Set as required if specified -#
                accelerator_manufacturers = []
                accelerator_names = []
                accelerator_types = []
                accelerator_count = { min = 0, max = 0 }
                accelerator_total_memory_mib = { min = 0, max = 0 }
            } } 
        #-----------------------------------------------------#
    } }
    ###########################################################
    #- Storage Per Instance ----------------------------------#
    ###########################################################
    Instance_Storage = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- EBS -#
                ebs_optimized = false
                ebs_blocks = {
                        #-------------------------------------#
                        ebs_000 = {
                            device_name = ""
                            no_device = ""
                            virtual_name = "ephemeralN"
                            ebs = {
                                delete_on_termination = false
                                encrypted = false # if snapshot_id != "" then conflict
                                kms_key_id = ""
                                create_kms_keys_key_name = ""
                                volume_type = ""
                                iops = 0
                                throughput = 0
                                volume_size = 0
                                snapshot_id = "" 
                        } }
                        #-------------------------------------#
                }
                instance_storage_requirements = {
                        #- Set as required if specified -#
                        local_storage = "" # included | excluded | required
                        local_storage_types = []
                        total_local_storage_gb = { min = 0, max = 0 }
                        baseline_ebs_bandwidth_mbps = { min = 0, max = 0 }
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
        } }
        #-----------------------------------------------------#
    } }
    ###########################################################
    #- Instance Networking -----------------------------------#
    ###########################################################
    Instance_Networking = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#
        config_000 = {
                #- ENI -#
                network_interfaces = {
                        #-------------------------------------#
                        eni_000 = {
                            delete_on_termination = false
                            #- Existing ENI -#
                            get_eni_by_id = ""
                            get_eni_by_tag = {}
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
                instance_networking_requirements = {
                    #- Set as required if specified -#
                    network_interface_count = { min = 0, max = 0 }
                }
                #- Security Groups -#
                vpc_id = ""
                all_eni_security_group_index_keys = []
                get_create_security_groups = {
                # If getting security group id, index key must start with "get_"
                # If creating a new security group, index key must start with "create_"
                        #-------------------------------------#
                        get_secgrp_000 = {"key" = "value"}
                        #-------------------------------------#
                        #-------------------------------------#
                        create_secgrp_000 = [
                            # Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
                            "Ingress|IPv4|0.0.0.0/0|-1|0|0|allTraffic",
                        ]
                        #-------------------------------------#
                }
                #- DNS -#
                private_dns_name_options = {
                    enable_resource_name_dns_aaaa_record = false
                    enable_resource_name_dns_a_record = false
                    hostname_type = "" # ip-name | resource-name
        } }
        #-----------------------------------------------------#
    } }
    ###########################################################
    #- Instance Offline --------------------------------------#
    ###########################################################
    Instance_Offline = {
    enabled_config_index_key = "config_000"
    configurations = {
        #-----------------------------------------------------#
        config_000 = {
                auto_recovery_enabled = false
                disable_api_termination = false
                instance_initiated_shutdown_behavior = "" # stop | terminate
                instance_offline_requirement = {
                    hibernation_option_enabled = false
                }
        }
        #-----------------------------------------------------#
    } }
    ###########################################################


###################
## END OF MODULE ##
###################
}