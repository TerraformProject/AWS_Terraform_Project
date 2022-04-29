locals {

  cluster_instances = flatten( [ for clusters, cluster_instances in var.aurora_cluster_instances: 
                                  [ for cluster_instances, instance_vals in cluster_instances.cluster_instances: instance_vals ] ] )

}
#####################
# Cluster Instances #
#####################

resource "aws_rds_cluster_instance" "cluster_instances" {
  for_each = var.create_aurora_cluster_instances == true ? { for o in local.cluster_instances: o.identifier => o } : {}

    # General Settings #
    cluster_identifier = each.value.cluster_identifier
    identifier = each.value.use_identifier_prefix == true ? null : each.value.identifier
    identifier_prefix = each.value.use_identifier_prefix == true ? "${each.value.identifier}-" : null
    promotion_tier = each.value.promotion_tier
    # Placement Settings #
    availability_zone = each.value.availability_zone
    db_subnet_group_name = each.value.db_subnet_group_name
    # System Settings #
    engine = each.value.engine
    engine_version = each.value.engine_version
    instance_class = each.value.instance_class
    db_parameter_group_name = each.value.db_parameter_group_name
    auto_minor_version_upgrade = each.value.auto_minor_version_upgrade
    # Network Settings #
    publicly_accessible = each.value.publicly_accessible
    ca_cert_identifier = each.value.ca_cert_identifier
    # Backup & Maintennance Settings #
    preferred_backup_window = each.value.preferred_backup_window
    preferred_maintenance_window = each.value.preferred_maintenance_window
    apply_immediately = each.value.apply_immediately
    # Monitoring Settings #
    monitoring_role_arn = each.value.monitoring_role_arn
    monitoring_interval = each.value.monitoring_interval
    performance_insights_enabled = each.value.performance_insights_enabled
    performance_insights_kms_key_id = each.value.performance_insights_kms_key_id
    # Tag Settings #
    copy_tags_to_snapshot = each.value.copy_tags_to_snapshot
    tags = each.value.tags

}