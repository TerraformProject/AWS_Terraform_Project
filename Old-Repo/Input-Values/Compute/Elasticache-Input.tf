module "ELASTICACHE" {
    source = "../../Modules/Compute-Modules/Default-Modules/Elasticache-Modules"

##########################################
## Elasticache Global Replication Group ##
##########################################
create_global_replication_group = false

global_replication_group_id_suffix = ""
global_replication_group_description = ""
primary_replication_group_id = ""

###################################
## Elasticache Replication Group ##
###################################
create_elasticache_replication_groups = false
elasticache_replication_groups = {
    replication_group_1 = {
        ## Group Settings ##
        global_replication_group_reader = false
        replication_group_id = ""
        replication_group_description = ""
        engine = "" # "redis is only supported value"
        engine_version = ""
        node_type = "" # Null if global_replication_group_reader == true
        auto_minor_version_upgrade = true
        port = 6379
        parameter_group_name = ""
        new_parameter_group = {
            enabled = false
            name = ""
            family = ""
            parameters = [] # "Name.Value"
            tags = { "key" = "value" }
        }

        ## Clustering & Placement Settings ##
        multi_az_enabled = false
        automatic_failover_enabled = false
        cluster_mode = {
          values = {
            enabled = false 
            num_node_groups = 0
            replicas_per_node_group = 0
          }
        }
        number_cache_clusters = 0
        elasticache_subnet_group_name = ""
        new_elasticache_subnet_group = {
            enabled = false
            new_elasticache_subnet_group_name = ""
            description = ""
            existing_subnet_ids = []
            add_new_subnets = {
                enabled = false
                vpc_id = ""
                cidr_block_az = [] # "CIDR_Block:AZ"
            }
        }

        ## Security Settings ##
        at_rest_encryption_enabled = false
        transit_encryption_enabled = false
        auth_token = ""
        kms_key_id = ""
        vpc_security_group_ids = []
        create_security_group = false
        security_group = {
            name = ""
            description = ""
            vpc_id = ""
            ingress_protocols_ports = [""] # "protocol.fromport.toport"
            ingress_security_groups = []
            ingress_ipv4_cidr_blocks = []
            ingress_ipv6_cidr_blocks = []
            egress_protocols_ports = [] # "protocol.fromport.toport"
            egress_security_groups = []
            egress_ipv4_cidr_blocks = []
            egress_ipv6_cidr_blocks = []
            security_group_tags = { "key" = "value"}
        }

        ## Backup & Maintenance Settings ##
        snapshot_arns = []
        snapshot_name = ""
        snapshot_window = ""
        snapshot_retention_limit = 0
        final_snapshot_identifier = ""
        maintenance_window = ""

        ## Alert Settings ##
        notification_topic_arn = ""
        create_notification_topic = false
        new_notification_topic = {
            name = ""
            values = {}
            tags = { "key" = "value" }
        }

        ## Tag Settings ##
        tags = {
            "key" = "value"
        }
    }

}

##########################
## Elasticache Clusters ##
##########################
create_elasticache_clusters = true
elasticache_clusters = {

    cluster_1 = {
        ## Cluster Settings ##
        cluster_id = "memcached001cluster"
        engine = "memcached"
        engine_version = "1.6.6"
        node_type = "cache.t2.micro"
        num_cache_nodes = 2
        port = 11211
        parameter_group_name = ""
        new_parameter_group = {
            enabled = true
            name = "memcached001parameters"
            family = "memcached1.6"
            parameters = [
                "idle_timeout.3600"
            ] # "Name.Value"
            tags = { "elasticache_params" = "memcached001params" }
        }

        ## Redis Only Settings ##
        replication_group_id = "" # Leave "" if standalone cluster
        snapshot_name = ""
        snapshot_arns = [] # Single element list
        snapshot_window = ""
        snapshot_retention_limit = 0
        final_snapshot_identifier = ""
        
        ## Placement Settings ##
        az_mode = "cross-az"
        availability_zone = "" # For one-zone setup
        preferred_availability_zones = ["us-east-1a", "us-east-1b"] # For multi-AZ setup
        elasticache_subnet_group_name = ""
        new_elasticache_subnet_group = {
            enabled = true
            new_elasticache_subnet_group_name = "memcached001subnetgroup"
            description = "Subnet group for memcached001"
            existing_subnet_ids = [module.VPC_VPC1.database_subnet_1.id, module.VPC_VPC1.database_subnet_2.id]
            add_new_subnets = {
                enabled = false
                vpc_id = ""
                cidr_block_az = [] # "CIDR_Block:AZ"
            }
        }

        ## Security Settings ##
        security_group_ids = []
        create_elasticache_security_group = true
        elasticache_security_group = {
            name = "memcached_security_group"
            description = "Security Group for Memcached"
            vpc_id = module.VPC_VPC1.vpc.id
            ingress_protocols_ports = ["tcp.11211.11211"] # "protocol.fromport.toport"
            ingress_security_groups = [module.AMI_LT.launch_template_security_group]
            ingress_ipv4_cidr_blocks = []
            ingress_ipv6_cidr_blocks = []
            egress_protocols_ports = [] # "protocol.fromport.toport"
            egress_security_groups = []
            egress_ipv4_cidr_blocks = []
            egress_ipv6_cidr_blocks = []
            security_group_tags = { "elasticache_security_groups" = "memcached_001_security_group"}
        }

        ## Maintenance Settings ##
        maintenance_window = ""

        ## Alert Settings ##
        notification_topic_arn = ""
        create_notification_topic = false
        new_notification_topic = {
            name = ""
            values = {}
            tags = { "key" = "value" }
        }

        ## Overwrite Settings ##
        apply_immediately = false

        ## Tag Settings ##
        tags = {
            "elasticache_clusters" = "memcached_001"
        }
    }

}







    
}