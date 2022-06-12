module "LAUNCH_TEMPLATE_ASG_AWS_PROJECT" {
source = "../Back_End_Modules/Launch_Template_ASG-Module"
    ##########################################
    #- Pricing ------------------------------#
    ##########################################
    #- On-Demand & Reserved Instances -#
    #- On-Demand Capacity Reservations -#
    #- Spot Instances -#
    #- Dedicated Hosts -#
    #- Dedicated Instances -#
    #- Scheduled Instances -#

    ##########################################
    #- Launch Template State ----------------#
    ##########################################

    launch_template_name = ""
    launch_template_name_prefix = ""
    description = ""
    default_version = ""
    update_default_version = false

    ##########################################
    #- Instance State -----------------------#
    ##########################################

    #- Instance Requirements -#
    instance_requirements = {
        /* If instance requirements are specified, then instance_type == "" */
        /* Please reference the module manual for values to specify */
        #- Pricing -#
        on_demand_max_price_percentage_over_lowest_price = 0
        spot_max_price_percentage_over_lowest_price = 0
        #- Instance -#
        instance_generations = []
        excluded_instance_types = []
        bare_metal_instances = "" # included | excluded | required
        #- CPU -#
        cpu_manufacturers = []
        vcpu_count = { min = 0, max = 0 }
        burstable_performance = "" # included | excluded | required
        #- Memory -#
        memory_mib = { min = 0, max = 0 }
        memory_gib_per_vcpu = { min = 0, max = 0 }
        #- Accelerators -#
        accelerator_manufacturers = []
        accelerator_names = []
        accelerator_types = []
        accelerator_count = { min = 0, max = 0 }
        accelerator_total_memory_mib = { min = 0, max = 0 }
        #- Storage -#
        local_storage = "" # included | excluded | required
        local_storage_types = []
        total_local_storage_gb = { min = 0, max = 0 }
        baseline_ebs_bandwidth_mbps = { min = 0, max = 0 }
        #- Network Interface -#
        network_interface_count = { min = 0, max = 0 }
        require_hibernate_support = false
    }

    #- Instance -#
    instance_type = ""
    get_ami = "" # ami_id | copy_ami | copy_ami_instance
    get_ami_values = {  /* Please reference the module manual for values to specify */ }
    iam_instance_profile_arn = ""
    user_data_file = "" # Local path to Shell script | cloud-init script
    metadata_options = {
        http_endpoint = "" # enabled | disabled 
        http_tokens = "" # optional | required
        http_put_response_hop_limit = 1
        htttp_protocol_ipv6 = "" # enabled | disabled
        instance_metadata_tags = "" # enabled | disabled
    }

    #- Virtualization -#
    enable_nitro_enclaves = false

    #- SSH -#
    ssh_key_pair = {
            #--------------------------------#
            create_keypair_000 = {
                name = ""
                public_key_file = ""
            }
            #--------------------------------#
    }

    #- Monitoring -#
    enable_detailed_instance_monitoring = false

    #- Offline -#
    termination_protection_enabled = false
    auto_recovery_enabled = false
    hibernation_option_enabled = false
    instance_initiated_shutdown_behavior = "" # stop | terminate

    ##########################################
    #- System State -------------------------#
    ##########################################

    #- CPU -#
    core_count = 0
    threads_per_core = 0 
    cpu_credits = ""  
    elastic_inference_accelerator_type = ""

    #- EBS -#
    ebs_optimized = false
    ebs_blocks = {
            #--------------------------------#
            ebs_000 = {
                device_name = ""
                no_device = ""
                virtual_name = "ephemeralN"
                ebs = {
                    delete_on_termination = false
                    encrypted = false # if snapshot_id != "" then conflict
                    kms_key_id = ""
                    create_kms_keys_index_keys = ""
                    volume_type = ""
                    iops = 0
                    throughput = 0
                    volume_size = 0
                    snapshot_id = "" 
            } }
            #--------------------------------#
    }

    #- KMS -#
    create_kms_keys = {
            #--------------------------------#
            create_kms_key_000 = {
                kms_key_name = ""
                key_usage = ""
                cstmr_mstr_key_spec = ""
                is_enabled = false
                key_rotation_enabled = false
                policy_file = ""
                bypass_policy_lockout_safety_check = false

            }
            #--------------------------------#
    }

    #- GPU -#
    gpu_type = ""

    ##########################################
    #- Networking State ---------------------#
    ##########################################

    #- Network Interfaces -#
    network_interfaces = {
            #--------------------------------#
            eni_000 = {
                #- Existing ENI -#
                get_eni_by_id = ""
                get_eni_by_tag = {"key" = "value"}
                #- Create ENI -#
                name = ""
                description = ""
                interface_type = "efa"
                device_index = 0
                network_card_index = 0
                associate_carrier_ip_address = false
                associate_public_ip_address = false
                ipv4 = {
                    ipv4_address_type = "" # [count] | [list]
                    ipv4_address_value = []
                    ipv4_prefix_type = "" # [count] | [list]
                    ipv4_prefix_value = []
                }
                ipv6 = {
                    ipv6_address_type = "" # [count] | [list]
                    ipv6_address_value = []
                    ipv6_prefix_type = "" # [count] | [list]
                    ipv6_prefix_value = []
                }
                subnet_id = ""
                security_group_index_keys = []
                delete_on_termination = false
                }
            #--------------------------------#
    }
    all_eni_security_group_index_keys = []

    #- Security Groups -#
    vpc_id = ""
    get_create_security_groups = {
            #--------------------------------#
            get_secgrp_000 = {"key" = "value"}
            #--------------------------------#
            #--------------------------------#
            create_secgrp_000 = [
                # Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
                "Ingress|IPv4|0.0.0.0/0|-1|0|0|allTraffic",
            ]
            #--------------------------------#
    }

    #- Private DNS Routing -#
    private_dns_name_options = {
        enable_resource_name_dns_aaaa_record = false
        enable_resource_name_dns_a_record = false
        hostname_type = "" # ip-name | resource-name
    }

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