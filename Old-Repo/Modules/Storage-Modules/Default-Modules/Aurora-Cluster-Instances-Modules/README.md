# Aurora Cluster Instances 

This module allows you to create more than one cluster instance.

Use the example below to as a reference to create more than one cluster instance:

[Cluster Instance Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance)

```terraform

##############################
## Aurora Cluster Instances ##
##############################
create_aurora_cluster_instances = false # Whether or not to create the cluster instances
aurora_cluster_instances = {

cluster_1 = { # Unique key used for organizational purposes. Organize cluster instances by cluster
    cluster_instances = {

        ## Able to create more than one cluster instance. Copy and paste example below

        instance_1 = { # Cluster Instance key. Must be unqiue. Terraform does not process duplicates
            # General Settings #
            cluster_identifier = "" # Cluster identifier this Cluster Instance will be a memeber of
            identifier = "" # Unique identifier for this cluster instance
            use_identifier_prefix = false # Whether to use a cluster instance for the identifier
            promotion_tier = 0 # Level of priority this cluster instance has over other cluster members to become the WRITER for the Cluster. Lower the number, the higher the priority
            # Placement Settings #
            availability_zone = "" # The AZ to place this cluster instance in
            db_subnet_group_name = "" # Name of the DB Subnet Group this Cluster Instance will be located in. Must be the same as the DB Subnet Group Name specified in the Cluster.
            # System Settings #
            engine = "" # The engine for this cluster instance
            engine_version = "" # The engine version for this cluster instance
            instance_class = "" # The instance class for this cluster instance
            db_parameter_group_name = "" # The parameter group name to associate with this cluster instance
            auto_minor_version_upgrade = false # Whether minor version upgrades will be applied during the maintenance window
            # Network Settings #
            publicly_accessible = false # Whether this cluster instance publicly accessable
            ca_cert_identifier = "" # Certificate identifier to apply to this cluster instance
            # Backup & Maintennance Settings #
            preferred_backup_window = "" # Preffered time within the AWS region specific 8-hour time block to do system backups
            preferred_maintenance_window = "" # Preffered time within the AWS region specific 8-hour time block to do system maintenance
            apply_immediately = false # Whether to apply changes to this cluster instance immefiately or within the next maintenance window
            # Monitoring Settings #
            monitoring_role_arn = "" # ARN of the role to use to send enhanced monitoring metrics to CloudWatch
            monitoring_interval = 0 # Interval to send monitoring metrics to CloudWatch
            performance_insights_enabled = false # Whether performance insghts is enabled
            performance_insights_kms_key_id = "" # ID of the KMS key to use for perfomrance insights
            # Tag Settings #
            copy_tags_to_snapshot = false # Whether the tags associated below should be applied to the cluster instance snapshots
            tags = {
                "key" = "value" # Tags to associate with the cluster instance
                }
            }
        }
    }
}

```