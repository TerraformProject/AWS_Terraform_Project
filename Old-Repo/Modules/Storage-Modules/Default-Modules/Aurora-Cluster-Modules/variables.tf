#####################################   
## Aurora Global Cluster Variables ##
#####################################

variable "create_aurora_global_cluster" {
  description = "Whether to create an Aurora Global Cluster"
  type = bool
  default = false
}

variable "global_cluster_identifier" {
  description = "Identifier for the Global Cluster"
  type = string
  default = null
}

variable "global_database_name" {
  description = "Name for automatically created database upon cluster creation"
  type = string
  default = null
}

variable "global_engine" {
  description = "The engine to use for the Global Cluster"
  type = string
  default = null
}

variable "global_engine_version" {
  description = "The engine version for the global cluster"
  type = string
  default = null
}

variable "global_storage_encrypted" {
  description = "Whether the DB cluster encrypted"
  type = bool
  default = false
}

variable "source_db_cluster_identifier" {
  description = " The identifier for the designated Read/Write Cluster"
  type = string
  default = null
}

variable "global_deletion_protection" {
  description = "Whether the Global Cluster has protection from being deleted"
  type = bool
  default = true
}

variable "global_force_destroy" {
  description = "Whether cluster memebers should be removed upon global cluster termination"
  type = bool
  default = false
}

##############################   
## Aurora Cluster Variables ##
##############################

variable "create_aurora_clusters" {
  description = "Whether to create Aurora Clusters"
  type = bool
  default = false
}

variable "aurora_clusters" {
  description = "Settings for creating the Aurora Clusters"
  type = map(object({
    global_cluster_member = bool
    cluster_identifier = string
    use_cluster_identifier_prefix = bool
    replication_source_identifier = string
    source_region = string
    apply_immediately = bool
    availability_zones = list(string)
    db_subnet_group_name = string
    create_new_db_subnet_group = bool
    new_db_subnet_group = object({
      name = string
      subnet_ids = list(string)
      db_subnet_tags = map(string)
    })
    database_name = string
    master_username = string
    master_password = string
    engine_mode = string
    engine = string
    engine_version = string
    allow_major_version_upgrade = bool
    db_cluster_parameter_group_name = string
    deletion_protection = bool
    enabled_cloudwatch_logs_exports = set(string)
    port = number
    enable_http_endpoint = bool
    create_cluster_endpoints = bool
    cluster_endpoints = map(object({
      cluster_key = string
      cluster_endpoint_identifier = string
      custom_endpoint_type = string
      static_members = list(string)
      excluded_members = list(string)
      endpoint_tags = map(string)
    }))
    vpc_security_group_ids = list(string)
    create_new_vpc_security_group = bool
    new_vpc_security_group = object({
      name = string
      description = string
      vpc_id = string
      ingress_protocols_ports = list(string)
      ingress_security_groups = list(string)
      ingress_ipv4_cidr_blocks = list(string)
      ingress_ipv6_cidr_blocks = list(string)
      egress_protocols_ports = list(string) 
      egress_security_groups = list(string)
      egress_ipv4_cidr_blocks = list(string)
      egress_ipv6_cidr_blocks = list(string)
      security_group_tags = map(string)
    })
    iam_database_authentication_enabled = bool
    iam_roles = list(string)
    storage_encrypted = bool
    kms_key_id = string
    create_new_kms_key = bool
    new_kms_key = object({
      description = string
      deletion_window_in_days = number
      policy = string
      enable_key_rotation = bool
      key_tags = map(string)
    })
    preferred_backup_window = string
    backup_retention_period = number
    backtrack_window = number
    skip_final_snapshot = bool
    final_snapshot_identifier = string
    preferred_maintenance_window = string
    create_restore_to_point_in_time = bool
    restore_to_point_in_time = map(any)
    scaling_configuration = map(object({
      auto_pause = bool
      max_capacity = number
      min_capacity = number
      seconds_until_auto_pause = number
      timeout_action = string
    }))
    copy_tags_to_snapshot = bool
    tags = map(string)
  }))
  default = null
}

