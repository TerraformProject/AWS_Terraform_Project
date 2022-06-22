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
    type = string
    default = ""
}

variable "description" {
    description = "A description for the launch template"
    type = string
    default = ""
}

variable "default_version" {
    description = "The default version for the launch template"
    type = string
    default = ""
}

variable "update_default_version" {
    description = "Whether or not to update the default version of the launch template upon making changes"
    type = bool
    default = false
}

####################################################
## Launch Template: Instance Boot Config Variable ##
####################################################

variable "Instance_Boot" {
    description = "Values to specify that are applied when the instances from this launch tempalte are booted up"
    type = object({
        enabled_config_index_key = string
        configurations = map(object({
            ami_id = string
            get_ami_values = any
            license_configuration_arn = ""
            user_date = object({
                file = string
                env_vars = map(string)
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
            enable_detailed_instance_monitoring = false
        }))
    })
    default = {}
}

#####################################################
## Launch Template: Instance Types Config Variable ##
#####################################################

variable "Instance_Types" {
    description = "Values to specify what EC2 instance type will be used in this launch template"
    type = object({
        enabled_config_index_key = string
        configurations = map(object({
            instance_type = string
            instance_type_requirements = object({
                instance_generations = list(string)
                excluded_instance_types = list(string)
                bare_metal_instances = string
            })
        }))
    })
    default = {}
}

#####################################################
## Launch Template: Instance Types Config Variable ##
#####################################################

variable "Instance_CPU" {
  description = "Values to specify what CPU configurations to use for booted up intances"
  type = object({
    enabled_config_index_key = string
    configurations = map(object({
        core_count = number
        threads_per_core = number
        cpu_credits = string
        elastic_inference_accelerator_type = string
        instance_cpu_requirements = object({
            cpu_manufacturers = list
            vcpu_count = map(number)
            burstable_performance = string
        })
        enabled_nitro_enclaves = bool
    }))
  })
  default = {}
}

######################################################
## Launch Template: Instance Memory Config Variable ##
######################################################

variable "Instance_Memory" {
  description = "Values to specify what Memory configurations to use for booted up instances"
  type = object({
    enabled_config_index = string
    configurations = map(object({
        kernal_id = string
        ram_disk_id = string
        instance_memory_requirements = map(map(number))
    }))
  })
  default = {}
}

###################################################
## Launch Template: Instance GPU Config Variable ##
###################################################

variable "Instance_CPU" {
    description = "Values to specify what GPU configurations to use for booted up instances"
    type = object({
        enabled_config_index_key = string
        configurations = map(map(string))
    })
    default = {}
}

###################################################
## Launch Template: Instance GPU Config Variable ##
###################################################

variable "Instance_Accelerators" {
    description = "Values to specify what accelerator configuratiosn to use for booted up instances"
    type = object({
        enabled_config_index_key = string
        configurations = map(object({
            instance_accelerator_requirements = object({
                accelerator_manufacturers = list(string)
                accelerator_names = list(string)
                accelerator_types = list(string)
                accelerator_count = map(number)
                accelerator_total_memory_mib = map(number)
            })
        }))
    })
    default = {}
}

#######################################################
## Launch Template: Instance Storage Config Variable ##
#######################################################

variable "Instance_Storage" {
    description = "Values to specify what storage configurations to use for boot up instances."
    type = object({
        enabled_config_index_key = string
        configurations = map(object({
            ebs_optimized = bool
            ebs_blocks = map(object({
                device_name = string
                no_device = string
                virtual_name = string
                ebs = object({
                    delete_on_termination = bool
                    encrypted = bool
                    kms_key_id = string
                    create_kms_keys_key_name = string
                    volume_type = string
                    iops = number
                    throughput = number
                    volume_size = number
                    snapshot_id = string
                })
            }))
            instance_storage_requirements = object({
                local_storage = string
                local_storage_types = list(string)
                total_local_storage_gb = map(number)
                baseline_ebs_bandwidth_mbps = map(number)
            })
            create_kms_keys = map(object({
                kms_key_name = string
                key_usage = string
                cstmr_mstr_key_spec = string
                is_enabled = bool
                key_rotation_enabled = bool
                policy_file = string
                bypass_policy_lockout_safety_check = bool
            }))
        }))
    })
    default = {}
}

#######################################################
## Launch Template: Instance Storage Config Variable ##
#######################################################

variable "Instance_Networking" {
  description = "Values to specify for network interface configurations for booted up instances"
  type = object({
    enabled_config_index_key = string
    configurations = map(object({
        network_interfaces = map(object({
            delete_on_termination = bool
            get_eni_by_id = string
            get_eni_by_tag = map(string)
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
        instance_networking_requirements = map(map(number))
        vpc_id = string
        all_eni_security_group_index_keys = list(string)
        get_create_security_groups = any
        private_dns_name_options = object({
            enable_resource_name_dns_aaaa_record = bool
            enable_resource_name_dns_a_record = bool
            hostname_type = string
        })
    }))
  })
  default = {}
}

#######################################################
## Launch Template: Instance Offline Config Variable ##
#######################################################

variable "Instance_Offline" {
    description = "Values to specify for when instance goes offline"
    type = object({
        enabled_config_index_key = string
        configurations = map(object({
            auto_recovery_enabled = bool
            disable_api_termination = bool
            instance_initiated_shutdown_behavior = string
            instance_offline_requirement = map(bool)
        }))
    })
}
