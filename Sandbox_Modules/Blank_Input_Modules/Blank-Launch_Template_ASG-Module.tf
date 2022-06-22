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
    launch_template_name_prefix = ""
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
            instance_accelerator_requrirements = {
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

########################################################################################################################################################
########################################################################################################################################################

    ###########################################################
    #- Auto Scaling Group ------------------------------------#
    ###########################################################
    asg_name = ""
    asg_name_prefix = ""
    asg_description = ""
    asg_service_linked_role_arn = ""
    ###########################################################
    #- ASG Placement -----------------------------------------#
    ###########################################################
    ASG_Placement = {
    enabled_config_index_keys = ["placement_000", "placement_001", "Placement_002", "Placement_003"] # Each enabled config index key creates a new ASG. Ex: ASG_Name-Placement_Index_Key
    configurations = {
        #-----------------------------------------------------#
        placement_000 = {
                vpc_zone_identifier = ["us-east-1a"]
                target_group_arns = []
                min_elb_capacity = 0
                wait_for_elb_capacity = 0
                placement_group = ""
                #- Classic Placement -#
                availability_zone = []
                load_balancers = []
                #- Scaling Attachment -#
                asg_scaling_config_index_key = "scaling_001"
                #- Tags -#
                asg_tags = [
                    {key = "", value = "", propgate_at_launch = false}
                ]
        }
        placement_001 = {
                #- Placement -#
                vpc_zone_identifier = ["us-east-1b"]
                target_group_arns = []
                min_elb_capacity = 0
                wait_for_elb_capacity = 0
                placement_group = ""
                #- Classic Placement -#
                availability_zone = []
                load_balancers = []
                #- Scaling Attachment -#
                asg_scaling_config_index_key = "scaling_000"
                #- Tags -#
                asg_tags = [
                    {key = "", value = "", propgate_at_launch = false}
                ]
                
        }
        placement_002 = {
                #- Placement -#
                vpc_zone_identifier = ["us-east-1c"]
                target_group_arns = []
                min_elb_capacity = 0
                wait_for_elb_capacity = 0
                placement_group = ""
                #- Classic Placement -#
                availability_zone = []
                load_balancers = []
                #- Scaling Attachment -#
                asg_scaling_config_index_key = "scaling_000"
                #- Tags -#
                asg_tags = [
                    {key = "", value = "", propgate_at_launch = false}
                ]
                
        }
        placement_003 = {
                #- Placement -#
                vpc_zone_identifier = ["us-east-1a", "us-east-1b", "us-east-1c"]
                target_group_arns = []
                min_elb_capacity = 0
                wait_for_elb_capacity = 0
                placement_group = ""
                #- Cassic Placement-#
                availability_zone = []
                load_balancers = []
                #- Scaling Attachment -#
                asg_scaling_config_index_key = "scaling_000"
                #- Tags -#
                asg_tags = [
                    {key = "", value = "", propgate_at_launch = false}
                ]
                
        }
        #-----------------------------------------------------#
    } }
    ###########################################################
    #- ASG Scaling -------------------------------------------#
    ###########################################################
    ASG_Scaling = {
        #-----------------------------------------------------#
        scaling_000 = {
                #- Scaling Base -#
                min_size = 0
                max_size = 0
                desired_capacity = 0
                capacity_rebalance = false
                protect_from_scale_in = false
                enabled_metrics = false
                metrics_granularity = ""
                default_cooldown = 0
                wait_for_capacity_timeout = ""
                health_check_type = ""
                health_check_grace_period = ""
                #- ASG Attachments -#
                asg_scaling_policies_config_index_keys = ["policy_000"] 
                asg_schedule_policies_config_index_keys = ["schedule_000"]
                asg_lifecycle_hook_config_index_keys = ["lifecycle_hook_000"]
                asg_notifications_config_index_keys = ["scaling_000"]
                #- On-Demand Instance Distribution -#
                on_demand_distribution = {
                    on_demand_allocation_strategy = "prioritized"
                    on_demand_base_capacity = 0
                    on_demand_percentage_above_base_capacity = 100
                    on_demand_max_price_percentage_over_lowest_price = 0
                    #- Capacity Reservations -#
                    capacity_reservations = {
                            #---------------------------------#
                            capacity_000 = {

                            }
                            #---------------------------------#
                }
                }
                #- Spot Distribution -#
                spot_distribution = {
                    spot_allocation_strategy = "" 
                    spot_instance_pools = 0
                    spot_max_price = ""
                    spot_max_price_percentage_over_lowest_price = 0
                }
                #- Warm Pool Instances -#
                warm_pool = {
                    pool_state = ""
                    min_size = 0
                    reuse_on_scale_in = false 
                    max_group_prepared_capacity = 0
                }
                #- Launch Template Overrides -#
                launch_template_overrides = {
                # launch_template | instance_type | instance_requirements
                # Please reference module manual to specify launch template override
                        #-------------------------------------#
                        override_000 = {
                            weighted_capacity = 0
                            launch_template = { id = "", name = "", version = "" }
                            instance_type = ""
                            instance_requirements = {
                                #- Instances -#
                                instance_generations = []
                                excluded_instance_types = []
                                on_demand_max_price_percentage_over_lowest_price = 0
                                spot_max_price_percentage_over_lowest_price = 0
                                bare_metal = ""
                                require_hibernate_support = false
                                #- CPU -#
                                cpu_manufacturers = []
                                vcpu_count = { min = 0, max = 0 }
                                burstable_performance = ""
                                #- Accelerators -#
                                accelerator_types = []
                                accelerator_manufacturers = []
                                accelerator_names = []
                                accelerator_count = { min = 0, max = 0 }
                                accelerator_total_memory_mib = { min = 0,  max = 0 }
                                #- Memory -#
                                memory_gib_per_vcpu = { min = 0, max = 0 }
                                memory_mib = { min = 0, max = 0 }
                                #- Storage -#
                                local_storage = ""
                                total_local_storage_gb = { min = 0, max = 0 }
                                baseline_ebs_bandwidth_mbps = {  min = 0, max = 0 }
                                #- Network -#
                                network_interface_count = { min = 0, max = 0 }   
                        } } 
                        #-------------------------------------#
                #- Instance Referesh -#
                instance_refresh = {
                    triggers = []
                    strategy = "Rolling"
                    checkpoint_delay_preference = 0
                    checkpoint_percentages_preference = 100
                    instance_warmup_preference = 0
                    min_health_percentage_preference = 0
                }
                #- Instance Offline -#
                instance_offline = {
                    max_instance_lifetime = 0
                    suspended_processes = []
                    termination_policies = []
                    force_delete = false
                } 
        } }
        #-----------------------------------------------------#
    } 
    ###########################################################
    #- ASG Policies ------------------------------------------#
    ###########################################################
    ASG_Polcies = {
        #-----------------------------------------------------#
        policy_000 = {
                policy_name = ""
                policy_type = ""# SimpleScaling | StepScaling | TargetTrackingScaling | PredictiveScaling
                adjustment_type = "" # ChangeInCapacity | ExactCapacity | PercentChangeInCapacity
                estimated_instance_warmup = 0
                #- Policy Values -#
                # Please reference module manual to specify policy values #
                #Send to Module Manual. Consolidate the module!#
                #--------------------------------------------#
                SimpleScaling = { 
                    values = {
                        scaling_adjustment = 0 # adjustment_type detirmines how this is is interpreted: number | percent
                        min_adjustment_magnitude = 0
                        cooldown = 0
                } }
                #--------------------------------------------#
                StepScaling = {
                    values = {
                        min_adjustment_magnitude = 0
                        metric_aggregation_type = "" # Minimum | Maximum | Average
                        step_adjustment = {
                            scaling_adjustment = 0
                            metric_interval_lower_inbound = 0
                            metric_interval_upper_bound = 0
                } } }
                #--------------------------------------------#
                TargetTrackingScaling = {
                    values = {
                        target_value = 0
                        disable_scale_in = false
                        target_tracking_type = "" # predifined | custom
                        target_tracking_values = {
                            predifined = {
                                predifined_metric_type = ""
                                resource_label = ""
                            }
                            custom = {
                                metric_name = ""
                                metric_dimension = { name = "", value = "" }
                                statistic = ""
                                unit = 0
                                namespace = ""
                            }
                } } }
                #--------------------------------------------#
                PredictiveScaling = {
                    values = {
                        mode = ""
                        max_capacity_breach_behavior = ""
                        max_capacity_buffer = 0
                        scheduling_buffer_time = ""
                        #- Metric Specifications -#
                        #------------------------------------#
                        load_metrics = {
                        type = "" # predifined | custom
                        values = {
                            predifined = {
                                predefined_metric_type = "" # ASGTotalCPUUtilization | ASGTotalNetworkIn | ASGTotalNetworkOut
                                resource_label = ""
                            }
                            custom = {
                                #- Metric Data Queries ------#
                                query_000 = {
                                    id = ""
                                    label = ""
                                    return_data = false
                                    expression = ""
                                }
                                query_001 = {
                                    id = ""
                                    label = ""
                                    return_data = false
                                    metric_stat = {
                                        metric_name = ""
                                        namespace = ""
                                        stat = ""
                                        unit = 0
                                        dimensions = { name = "", value = ""}
                                } }
                                #----------------------------#
                        } } }
                        #------------------------------------#
                        capacity_metrics = {
                        type = "" # predifined | custom
                        values = {
                            predifined = {
                                predifined_metric_type = "" # ASGCPUUtilization | ASGNetworkIn | ASDNetworkOut | ALBRequestCount
                                resource_label = ""
                            }
                            custome = {
                                #- Metric Data Queries ------#
                                query_000 = {
                                    id = ""
                                    label = ""
                                    return_data = false
                                    expression = ""
                                    metric_stat = {
                                        metric_name = ""
                                        namespace = ""
                                        stat = ""
                                        unit = 0
                                        dimensions = [
                                            { name = "", value = ""},
                                            { name = "", value = ""}
                                        ]
                                } }
                                #----------------------------#
                        } } }
                        #------------------------------------#
                        scaling_metrics = {
                        type = "" # predifined | custom
                        values = {
                            predifined = {
                                predifined_metric_type = ""# ASGAverageCPUUtilization | ASGAverageNetworkIN | ASGAverageNetworkOut | ALBRequestCountPerTarget
                                resource_label = ""
                            }
                            custome = {
                                #- Metric Data Queries ------#
                                query_000 = {
                                    id = ""
                                    label = ""
                                    return_data = false
                                    expression = ""
                                    metric_stat = {
                                        metric_name = ""
                                        namespace = ""
                                        stat = ""
                                        unit = 0
                                        dimensions = [
                                            { name = "", value = ""},
                                            { name = "", value = ""}
                                        ]
                                } }
                                #----------------------------#
                        } } }
                        #------------------------------------#
                } }
                #--------------------------------------------#
        }
        #-----------------------------------------------------#
    }
    ###########################################################
    #- ASG Schedules -----------------------------------------#
    ###########################################################
    ASG_Schedules = {
        #-----------------------------------------------------#
        schedule_000 = {
                scheduled_action_name = ""
                start_time = "" # Format: YYYY-MM-DDThh:mm:ssZ
                end_time = "" # Format: YYYY-MM-DDThh:mm:ssZ
                recurrence = "" # Time when recurring future actions will start. Unix cron syntax format only
                time_zone = "" # Tzone for cron express. C-names from IANA Tzones only
                min_size = 0
                max_size = 0
                desired_capacity = 0
        }
        #-----------------------------------------------------#
    }
    ###########################################################
    #- ASG Lifecycle Hooks -----------------------------------#
    ###########################################################
    ASG_Lifecycle_Hooks = {
        #-----------------------------------------------------#
        lifecycle_hook_000 = {
                lifecycle_hook_name = ""
                default_result         = ""
                heartbeat_timeout      = 0
                lifecycle_transition   = ""
                notification_target_arn = ""
                role_arn                = ""
                notification_metadata = <<EOF
{
  "foo": "bar"
}
EOF
        }
        #-----------------------------------------------------#
    }
    ###########################################################
    #- ASG Notifications -------------------------------------#
    ###########################################################
    ASG_Notifications = {
        #-----------------------------------------------------#
        notify_000 = {
                notifications = []
                sns_topic_name = ""
        }
        #-----------------------------------------------------#
     }
   
    ###########################################################
    #- Tags --------------------------------------------------#
    ###########################################################
    

































    
    instance_requirements = {
        /* If instance requirements are specified, then instance_type == "" */
        /* Please reference the module manual for values to specify */
        #- Pricing -#
        on_demand_max_price_percentage_over_lowest_price = 0
        spot_max_price_percentage_over_lowest_price = 0
        #- Instance -#
        
        #- CPU -#
        
        
        #- Accelerators -#
        
        #- Storage -#
        
        
        #- Network Interface -#
        
        
    }

    
    
    
    
    

    #- Virtualization -#
    

    

    #- Monitoring -#
    

    #- Offline -#
    

    ##########################################
    #- System State -------------------------#
    ##########################################
    

    #- EBS -#
    

    #- KMS -#
    

    

    ##########################################
    #- Networking State ---------------------#
    ##########################################

    #- Network Interfaces -#
    
    

    #- Security Groups -#
    

    #- Private DNS Routing -#
    

    ##########################################
    #- Security State -----------------------#
    ##########################################  

    

      

    










































    #- Instance_Maintenance -----------------#
    instance_maintenance = {
        user_data_options = {
            user_data_file = ""
            user_data_base64_file = ""
            user_data_on_change = false
        }
        metadata_options = {
            http_endpoint = disabled
            http_put_response_hop_limit = 1
            http_tokens = optional
            instance_metadata_tags = "disabled"
        }
        troubleshooting_options ={
            auto_recovery = "disabled"
        }
    }
    #- CPU State ------------------------#
    cpu_options = {
        cpu_core_count = 0
        cpu_threads_per_core = 0
        cpu_credits = "unlimited"
    }
    #- Block State ----------------------#
    root_block_options = {
        iops = ""
        throughput = 0
        volume_size = 0
        kms_key_index_key = ""
        delete_on_termination = false
        tags = {}
    }
    attached_ebs_blocks = {
            #----------------------------#
            ebs_000 = {
                device_name = ""
                existing_snapshot_id = ""
                iops = ""
                throughput = 0
                volume_size = 0
                volume_type = ""
                kms_key_index_key = ""
                delete_on_termination = false
            }
            #----------------------------#
    }
    attached_eph_blocks = {
            #----------------------------#
            eph_000 = {
                device_name = ""
                no_device = ""
                virtual_name = "ephemeralN"
            }
            #----------------------------#
    }
    #- Networking State -----------------#
    subnet_id = ""
    source_destination_check = true
    attached_network_interfaces = {
            #----------------------------#
            eni_000 = {
                
            }
            #----------------------------#
    }
    
}