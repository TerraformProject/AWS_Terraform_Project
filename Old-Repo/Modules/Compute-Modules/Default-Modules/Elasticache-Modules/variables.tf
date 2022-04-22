########################################
## Global Replication Group Variables ##
########################################

variable "create_global_replication_group" {
    description = "Whether to create a global replication group"
    type = bool
    default = false
}

variable "global_replication_group_id_suffix" {
    description = "suffix for the global replication group ID"
    type = string
    default = null
}

variable "global_replication_group_description" {
    description = "Description for the global replication group"
    type = string
    default = null
}

variable "primary_replication_group_id" {
    description = "ID of replication group to make primary WRITER / READER"
    type = string
    default = null
}

#################################
## Replication Group Variables ##
#################################

variable "create_elasticache_replication_groups" {
    description = "Whether to create elasticache replication groups"
    type = bool
    default = false
}

variable "elasticache_replication_groups" {
    description = "Settings for elasticache replication groups"
    type = map(object({
        global_replication_group_reader = bool
        replication_group_id = string
        replication_group_description = string
        engine = string
        engine_version = string
        node_type = string
        auto_minor_version_upgrade = bool
        port = number
        parameter_group_name = string
        new_parameter_group = object({
            enabled = bool
            name = string
            family = string
            parameters = list(string)
            tags = map(string)
        })
        multi_az_enabled = bool
        automatic_failover_enabled = bool
        cluster_mode = map(object({
            enabled = bool
            num_node_groups = number
            replicas_per_node_group = number
        }))
        number_cache_clusters = number
        elasticache_subnet_group_name = string
        new_elasticache_subnet_group = object({
            enabled = bool
            new_elasticache_subnet_group_name = string
            description = string
            existing_subnet_ids = list(string)
            add_new_subnets = object({
                enabled = bool
                vpc_id = string
                cidr_block_az = list(string)
            })
        })
        at_rest_encryption_enabled = bool
        transit_encryption_enabled = bool
        auth_token = string
        kms_key_id = string
        vpc_security_group_ids = list(string)
        create_security_group = bool
        security_group = object({
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
        snapshot_arns = list(string)
        snapshot_name = string
        snapshot_window = string
        snapshot_retention_limit = number
        final_snapshot_identifier = string
        maintenance_window = string
        notification_topic_arn = string
        create_notification_topic = bool
        new_notification_topic = object({
            name = string
            values = map(any)
            tags = map(string)
        })
        tags = map(string)
    }))
}


###################################
## Elasticache Cluster Variables ##
###################################

variable "create_elasticache_clusters" {
    description = "Whether to create to create Elasticache Clusters"
    type = bool
    default = false
}

variable "elasticache_clusters" {
    description = "Settings for creating elasticache clusters"
    type = map(object({
        cluster_id = string
        engine = string
        engine_version = string 
        node_type = string
        num_cache_nodes = number
        port = number
        parameter_group_name = string
        new_parameter_group = object({
            enabled = bool
            name = string
            family = string
            parameters = list(string)
            tags = map(string)
        })
        az_mode = string
        availability_zone = string
        preferred_availability_zones = list(string)
        elasticache_subnet_group_name = string
        new_elasticache_subnet_group = object({
            enabled = bool
            new_elasticache_subnet_group_name = string
            description = string
            existing_subnet_ids = list(string)
            add_new_subnets = object({
                enabled = bool
                vpc_id = string
                cidr_block_az = list(string)
            })
        })
        security_group_ids = list(string)
        create_elasticache_security_group = bool
        elasticache_security_group = object({
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
        replication_group_id = string
        maintenance_window = string
        snapshot_name = string
        snapshot_arns = list(string)
        snapshot_window = string
        snapshot_retention_limit = number
        final_snapshot_identifier = string
        notification_topic_arn = string
        create_notification_topic = bool
        new_notification_topic = object({
            name = string
            values = map(any)
            tags = map(string)
        })
        apply_immediately = bool
        tags = map(string)
    }))
}