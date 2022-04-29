################################
## Cluster Instances Variable ##
################################

variable "create_aurora_cluster_instances" {
    description = "Whether to create Aurora Cluster Instances"
    type = bool
    default = false
}


variable "aurora_cluster_instances" {
    description = "Settings for the creating the cluster instances"
    type = map(map(map(object({
        cluster_identifier = string
        identifier = string
        use_identifier_prefix = bool
        promotion_tier = number
        availability_zone = string
        db_subnet_group_name = string
        engine = string
        engine_version = string
        instance_class = string
        db_parameter_group_name = string
        auto_minor_version_upgrade = bool
        publicly_accessible = bool
        ca_cert_identifier = string
        preferred_backup_window = string
        preferred_maintenance_window = string
        apply_immediately = bool
        monitoring_role_arn = string
        monitoring_interval = number
        performance_insights_enabled = bool
        performance_insights_kms_key_id = string
        copy_tags_to_snapshot = bool
        tags = map(string)
    }))))
}