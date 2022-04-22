###################################
## Elastic File System Variables ##
###################################

variable "create_efs_file_systems" {
    description = "Whether to create EFS file systems"
    type = bool
    default = false
}

variable "efs_file_systems" {
  description = "Settings for creating EFS file systems"
  type = map(object({
      creation_token = string
      availability_zone_name = string
      mount_targets = map(object({
          module_key = string
          ip_address = string
          subnet_id = string
          new_subnet = object({
              enabled = bool
              vpc_id = string
              cidr_block = string
              availability_zone = string
              subnet_tags = map(string)
          })
          security_groups = list(string)
          new_security_group = object({
              enabled = bool
              name = string
              description = string
              vpc_id = string
              ingress_protocol_ports = list(string)
              ingress_security_groups = list(string)
              ingress_ipv4_cidr_blocks = list(string)
              ingress_ipv6_cidr_blocks = list(string)
              security_group_tags = map(string)
          })
      }))
        access_point = object({
            enabled = bool
            module_key = string
            root_directory = object({
                enabled = bool
                path = string
                creation_info = map(number)
            })
            posix_user = object({
                enabled = bool
                gid = number
                secondary_gids = list(number)
                uid = number
            })
        })
        performance_mode = string
        throughput_mode = string
        provisioned_throughput_in_mibps = number
        efs_policy = object({
            enabled = bool
            module_key = string
            efs_policy_local_path = string
        })
        encrypted = bool
        kms_key_id = string
        new_kms_key = object({
            enabled = bool
            description = string
            enable_key_rotation = bool
            deletion_window_in_days = number
            policy = string
            kms_tags = map(string)
        })
        enable_lifecycle_policy = string
        lifecycle_policy = map(string)
        tags = map(string)
  }))
}