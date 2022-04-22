module "NEPTUNE" {
    source = "../../Modules/Storage-Modules/Default-Modules/Neptune-Modules"

#############################
## Create Neptune Clusters ##
#############################

create_neptune_clusters = false

neptune_clusters = {
    
    Neptune_Cluster_1 = {
        ## General ##
        cluster_identifier                  = each.value.cluster_settings.cluster_identifier
        replication_source_identifier       = each.value.replication_source_identifier

        ## System ##
        engine                              = each.value.cluster_settings.engine
        engine_version                      = each.value.engine_version
        neptune_cluster_parameter_group_name = each.value.neptune_cluster_parameter_group_name
        preferred_maintenance_window        = each.value.preferred_maintenance_window
        backup_retention_period             = each.value.cluster_settings.backup_retention_period
        preferred_backup_window             = each.value.cluster_settings.preferred_backup_window
        skip_final_snapshot                 = each.value.cluster_settings.skip_final_snapshot
        final_snapshot_identifier           = each.value.final_snapshot_identifier

        apply_immediately                   = each.value.cluster_settings.apply_immediately
        deletion_protection                 = each.value.deletion_protection

        ## Network ##
        availability_zones                  = each.value.availability_zones
        neptune_subnet_group_name           = each.value.neptune_subnet_group_name
        port                                = each.value.port
        vpc_security_group_ids              = each.value.vpc_security_group_ids

        create_neptune_cluster_endpoints = false
        neptune_cluster_endpoints = {

            neptune_cluster_endpoint_1 = {
                cluster_key = "Neptune"
                cluster_endpoint_identifier = "example"
                endpoint_type               = "READER"
                excluded_members = ""
                static_members = ""
                tags = ""
            }

        }

        ## Security ##
        iam_roles                           = each.value.iam_roles
        iam_database_authentication_enabled = each.value.cluster_settings.iam_database_authentication_enabled
        kms_key_arn                         = each.value.kms_key_arn
        storage_encrypted                   = each.value.storage_encrypted

        ## Monitor ##
        enabled_cloudwatch_logs_exports     = each.value.enabled_cloudwatch_logs_exports

        ## Tags ##
        tags                                = each.value.tags
        copy_tags_to_snapshot               = each.value.copy_tags_to_snapshot
    }
}




}