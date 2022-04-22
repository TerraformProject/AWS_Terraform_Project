module "AURORA_CLUSTER_INSTANCES" {
    source = "../../Modules/Storage-Modules/Default-Modules/Aurora-Cluster-Instances-Modules"

##############################
## Aurora Cluster Instances ##
##############################
create_aurora_cluster_instances = false
aurora_cluster_instances = {

cluster_1 = {
    cluster_instances = {
        instance_1 = {
            # General Settings #
            cluster_identifier = ""
            identifier = "yuhbluh"
            use_identifier_prefix = false
            promotion_tier = 0
            # Placement Settings #
            availability_zone = ""
            db_subnet_group_name = ""
            # System Settings #
            engine = "aurora"
            engine_version = ""
            instance_class = ""
            db_parameter_group_name = ""
            auto_minor_version_upgrade = false
            # Network Settings #
            publicly_accessible = false
            ca_cert_identifier = ""
            # Backup & Maintennance Settings #
            preferred_backup_window = ""
            preferred_maintenance_window = ""
            apply_immediately = false
            # Monitoring Settings #
            monitoring_role_arn = ""
            monitoring_interval = 0
            performance_insights_enabled = false
            performance_insights_kms_key_id = ""
            # Tag Settings #
            copy_tags_to_snapshot = false
            tags = {
                "key" = "value"
                }
            }
        }
    }
}

}

