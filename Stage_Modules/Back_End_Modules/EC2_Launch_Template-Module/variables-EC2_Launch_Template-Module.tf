##############################################
## Launch Tempalte Identification Variables ##
##############################################

variable "launch_template_name" {
    description = "Name for the launch template"
    type = string
    default = ""
}

variable "launch_template_name_prefix" {
    description  = "Naming prefix for the launch template name"
    type = bool
    default = false
}

variable "description" {
    description = "A description for the launch template"
    type = string
    default = ""
}

variable "default_version" {
    description = "The default version for the launch template"
    type = number
    default = null
}

variable "update_default_version" {
    description = "Whether or not to update the default version of the launch template upon making changes"
    type = bool
    default = false
}

variable "tag_specifications" {
  description = "Tags to associate with the resources created from the launch template"
  type = map(map(string))
  default = {}
}

####################################################
## Launch Template: Instance Boot Config Variable ##
####################################################

variable "instance_boot_enabled_config_index_key" {
    description = "Index key of the instance_boot_configuation specified to be enabled"
    type = string
    default = ""
}

variable "instance_boot_configurations" {
    description = "Values to specify that are applied when the instances from this launch tempalte are booted up"
    type = map(object({
            get_ami_type = string
            get_ami_values = any
            license_configuration_arn = string
            user_data = object({
                file = string
                vars = map(string)
            })
            metadata_options = object({
                http_endpoint = string
                http_tokens = string
                http_put_response_hop_limit = number
                htttp_protocol_ipv6 = string
                instance_metadata_tags = string
            })
            iam_instance_profile = map(string)
            ssh_key_pair = map(string)
            enable_detailed_instance_monitoring = bool
    }) )
    default = null
}

#####################################################
## Launch Template: Instance Types Config Variable ##
#####################################################

variable "instance_types_enabled_config_index_key" {
  description = "Index key of the instance_types_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_types_configurations" {
    description = "Values to specify what EC2 instance type will be used in this launch template"
    type = map(object({
            instance_type = string
            enable_spot_options = bool
            spot_options = object({
                block_duration_minutes = number
                instance_interruption_behavior = string
                max_price = string
                spot_instance_type = string
                valid_until = string
            })
            capacity_reservation = object({
                enabled_capacity_reservation_type = string
                existing = object({
                    preference = string
                    capacity_reservation_id = string
                    capacity_reservation_resource_group_arn = string
                })
                create = object({
                    preference = string
                    end_date = string
                    end_date_type = string
                    instance_count = number
                    availability_zone = string
                    outpost_arn = string
                    #- Required Criteria to Activate -#
                    instance_platform = string
                    instance_type = string
                    #- Optional Criteria to Activate -#
                    instance_match_criteria = string
                    tenancy = string
                    ebs_optimized = bool
                    ephemeral_storage = bool
                    tags = map(string)
                })
            })
            enable_placement = bool
            placement = object({
                affinity = string
                availability_zone = string
                group_name = string
                host_id = string
                host_resource_group_arn = string
                spread_domain = string
                tenancy = string
                partition_number = number
            })
            requirements = object({
                instance_generations = list(string)
                excluded_instance_types = list(string)
                bare_metal_instances = string
            })
    }))
    default = null
}

#####################################################
## Launch Template: Instance Types Config Variable ##
#####################################################

variable "instance_cpu_enabled_config_index_key" {
  description = "Index key of the instance_cpu_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_cpu_configurations" {
  description = "Values to specify what CPU configurations to use for booted up intances"
  type = map(object({
        core_count = number
        threads_per_core = number
        cpu_credits = string
        elastic_inference_accelerator_type = string
        requirements = object({
            cpu_manufacturers = list(string)
            vcpu_count = map(number)
            burstable_performance = string
        })
        enable_nitro_enclaves = bool
  }))
  default = null
}

######################################################
## Launch Template: Instance Memory Config Variable ##
######################################################

variable "instance_memory_enabled_config_index_key" {
  description = "Index key of the instance_memory_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_memory_configurations" {
  description = "Values to specify what Memory configurations to use for booted up instances"
  type = map(object({
        kernal_id = string
        ram_disk_id = string
        requirements = map(map(number))
  }))
  default = null
}

###################################################
## Launch Template: Instance GPU Config Variable ##
###################################################

variable "instance_gpu_enabled_config_index_key" {
  description = "Index key of the instance_gpu_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_gpu_configurations" {
    description = "Values to specify what GPU configurations to use for booted up instances"
    type = map(map(string))
    default = null
}

###################################################
## Launch Template: Instance GPU Config Variable ##
###################################################

variable "instance_accelerators_enabled_config_index_key" {
  description = "Index key of the instance_accelerators_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_accelerators_configurations" {
    description = "Values to specify what accelerator configuratiosn to use for booted up instances"
    type = map(object({
            requirements = object({
                accelerator_manufacturers = list(string)
                accelerator_names = list(string)
                accelerator_types = list(string)
                accelerator_count = map(number)
                accelerator_total_memory_mib = map(number)
            })
    }))
    default = null
}

#######################################################
## Launch Template: Instance Storage Config Variable ##
#######################################################

variable "instance_storage_enabled_config_index_key" {
  description = "Index key of the instance_storage_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_storage_configurations" {
    description = "Values to specify what storage configurations to use for boot up instances."
    type = map(object({
            ebs_optimized = bool
            block_device_mappings = any
            create_kms_keys = map(object({
                kms_key_name = string
                key_usage = string
                cstmr_mstr_key_spec = string
                is_enabled = bool
                key_rotation_enabled = bool
                policy_file = string
                bypass_policy_lockout_safety_check = bool
            }))
            requirements = object({
                local_storage = string
                local_storage_types = list(string)
                total_local_storage_gb = map(number)
                baseline_ebs_bandwidth_mbps = map(number)
            })
    }))
    default = null
}

##########################################################
## Launch Template: Instance Networking Config Variable ##
##########################################################

variable "instance_networking_enabled_config_index_key" {
  description = "Index key of the instance_networking_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_networking_configurations" {
  description = "Values to specify for network interface configurations for booted up instances"
  type = map(object({
        network_interfaces = map(object({
            delete_on_termination = bool
            get_eni_by_id = string
            name = string
            description = string
            interface_type = string
            device_index = number
            network_card_index = number
            associate_carrier_ip_address = bool
            associate_public_ip_address = bool
            ipv4 = object({
                ipv4_address_type = string
                ipv4_address_value = list(string)
                ipv4_prefix_type = string
                ipv4_prefix_value = list(string)
            })
            ipv6 = object({
                ipv6_address_type = string
                ipv6_address_value = list(string)
                ipv6_prefix_type = string
                ipv6_prefix_value = list(string)
            })
            subnet_id = string
            security_group_index_keys = list(string)
            }))
        get_create_security_groups = any
        private_dns_name_options = object({
            enable_resource_name_dns_aaaa_record = bool
            enable_resource_name_dns_a_record = bool
            hostname_type = string
        })
        requirements = map(map(number))
  }))
  default = null
}



#######################################################
## Launch Template: Instance Offline Config Variable ##
#######################################################

variable "instance_offline_enabled_config_index_key" {
  description = "Index key of the instance_offline_configuation specified to be enabled"
  type = string
  default = ""
}

variable "instance_offline_configurations" {
    description = "Values to specify for when instance goes offline"
    type = map(object({
        auto_recovery_enabled = string
        disable_api_termination = bool
        instance_initiated_shutdown_behavior = string
        requirements = map(bool)
    } ) )
}
