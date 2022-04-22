module "AURORA_CLUSTERS_VPC1" {
    source = "../../Modules/Storage-Modules/Default-Modules/Aurora-Cluster-Modules"
    
###########################
## Aurora Global Cluster ##
###########################
create_aurora_global_cluster = false

global_cluster_identifier = ""
global_database_name = ""
global_engine = ""
global_engine_version = ""
global_storage_encrypted = false # Source DB Cluster must be encrypted as well

source_db_cluster_identifier = ""

global_deletion_protection = false
global_force_destroy = false

#####################    
## Aurora Clusters ##
#####################
create_aurora_clusters = true
aurora_clusters = {

## Serverless Cluster 1 ##
    cluster_1 = {
    ## Cluster Settings ##
    global_cluster_member = false
    cluster_identifier = "serverless1"
    use_cluster_identifier_prefix = false
    replication_source_identifier = ""
    source_region = ""
    apply_immediately = false
    
    ## Cluster Placement ##
    availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
    db_subnet_group_name = ""
    create_new_db_subnet_group = true
    new_db_subnet_group = {
        name = "db_serverless"
        subnet_ids = [
            module.VPC_VPC1.database_subnet_1.id,
            module.VPC_VPC1.database_subnet_2.id,
            module.VPC_VPC1.database_subnet_3.id
        ]
        db_subnet_tags = { "db_subnet" = "serverless" }
    }

    ## Cluster System Settings ## 
    database_name = "serverless_1"
    master_username = "Serverless_Admin_One"
    master_password = "SuperSecretPassword123"
    engine_mode = "serverless"
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.07.1"
    allow_major_version_upgrade = false
    db_cluster_parameter_group_name = ""
    deletion_protection = false

    enabled_cloudwatch_logs_exports = [] # Not Supported when engine_mode == "serverless"

    ## Cluster Network Settings ##
    port = 3306
    enable_http_endpoint = true # Only valid if engine_mode == "serverless"

    create_cluster_endpoints = false # Cluster endpoints not supported in serverless
    cluster_endpoints = {
        endpoint_1 = {
            cluster_key = "cluster_1"
            cluster_endpoint_identifier = "endpointyuh1"
            custom_endpoint_type = "READER"
            static_members = []
            excluded_members = []
            endpoint_tags = {}
        }
    }

    ## Cluster Security Settings ##
    vpc_security_group_ids = []
    create_new_vpc_security_group = true
    new_vpc_security_group = {
        name = "Serverless_1_Security_Group_1"
        description = "Description YUH"
        vpc_id = module.VPC_VPC1.vpc.id
        ingress_protocols_ports = ["tcp.3306.3306"] # "protocol.fromport.toport"
        ingress_security_groups = []
        ingress_ipv4_cidr_blocks = [module.VPC_VPC1.private_subnet_1.cidr_block, module.VPC_VPC1.private_subnet_2.cidr_block]
        ingress_ipv6_cidr_blocks = []
        egress_protocols_ports = [] # "protocol.fromport.toport"
        egress_security_groups = []
        egress_ipv4_cidr_blocks = []
        egress_ipv6_cidr_blocks = []
        security_group_tags = { "severless_security_groups" = "serverless_1_security_group_1"}
    }
    iam_database_authentication_enabled = false
    iam_roles = []
    storage_encrypted = true # Required when engine_mode == "serverless"
    kms_key_id = ""
    create_new_kms_key = true
    new_kms_key = {
        description = "key1356"
        deletion_window_in_days = 7
        policy = ""
        enable_key_rotation = false
        key_tags = { "serverless_kms" = "key1356" }
    }

    ## Cluster Backup & Maintenance Settings ##
    preferred_backup_window = "03:00-04:00"
    backup_retention_period = 4
    backtrack_window = 0
    skip_final_snapshot = true
    final_snapshot_identifier = "snapyuh"
    preferred_maintenance_window = "sun:04:00-sun:05:00"

    create_restore_to_point_in_time = false
    restore_to_point_in_time = {
        values = {}
    }

    ## Cluster Auto Scaling ##
    # Only Valid when engine_mode == "serverless"
    scaling_configuration = {
        values = {
            auto_pause = true
            max_capacity = 4
            min_capacity = 1
            seconds_until_auto_pause = 300
            timeout_action = "RollbackCapacityChange"
            }
    }

    ## Cluster Tags ##
    copy_tags_to_snapshot = false
    tags = {
        "db_serverless" = "serverless_1"
    }
}



## Serverless Cluster 2 ##
cluster_2 = {

    ## Cluster Settings ##
    global_cluster_member = false
    cluster_identifier = "serverless2"
    use_cluster_identifier_prefix = false
    replication_source_identifier = ""
    source_region = ""
    apply_immediately = false
    
    ## Cluster Placement ##
    availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
    db_subnet_group_name = "db_serverless"
    create_new_db_subnet_group = false
    new_db_subnet_group = {
        name = "db_serverless"
        subnet_ids = []
        db_subnet_tags = { "db_subnet" = "serverless" }
    }

    ## Cluster System Settings ## 
    database_name = "serverless_2"
    master_username = "Serverless_Admin_Two"
    master_password = "Security101isABC123"
    engine_mode = "serverless"
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.07.1"
    allow_major_version_upgrade = false
    db_cluster_parameter_group_name = ""
    deletion_protection = false

    enabled_cloudwatch_logs_exports = [] # Not Supported when engine_mode == "serverless"

    ## Cluster Network Settings ##
    port = 3306
    enable_http_endpoint = true # Only valid if engine_mode == "serverless"

    create_cluster_endpoints = false # Cluster endpoints not supported in serverless
    cluster_endpoints = {
        endpoint_1 = {
            cluster_key = "cluster_1"
            cluster_endpoint_identifier = "endpointyuh1"
            custom_endpoint_type = "READER"
            static_members = []
            excluded_members = []
            endpoint_tags = {}
        }
    }

    ## Cluster Security Settings ##
    vpc_security_group_ids = []
    create_new_vpc_security_group = true
    new_vpc_security_group = {
        name = "Serverless_2_Security_Group_1"
        description = "Description YUH"
        vpc_id = module.VPC_VPC1.vpc.id
        ingress_protocols_ports = ["tcp.3306.3306", "tcp.443.443", "tcp.80.80"] # "protocol.fromport.toport"
        ingress_security_groups = []
        ingress_ipv4_cidr_blocks = [module.VPC_VPC1.private_subnet_1.cidr_block, module.VPC_VPC1.private_subnet_2.cidr_block]
        ingress_ipv6_cidr_blocks = []
        egress_protocols_ports = [] # "protocol.fromport.toport"
        egress_security_groups = []
        egress_ipv4_cidr_blocks = []
        egress_ipv6_cidr_blocks = []
        security_group_tags = { "severless_security_groups" = "serverless_2_security_group_1"}
    }
    iam_database_authentication_enabled = false
    iam_roles = []
    storage_encrypted = true # Required when engine_mode == "serverless"
    kms_key_id = ""
    create_new_kms_key = true
    new_kms_key = {
        description = "key1357"
        deletion_window_in_days = 7
        policy = ""
        enable_key_rotation = false
        key_tags = { "serverless_kms" = "key1357" }
    }

    ## Cluster Backup & Maintenance Settings ##
    preferred_backup_window = "04:00-05:00"
    backup_retention_period = 4
    backtrack_window = 0
    skip_final_snapshot = true
    final_snapshot_identifier = "snapyuh"
    preferred_maintenance_window = "sun:05:00-sun:06:00"

    create_restore_to_point_in_time = false
    restore_to_point_in_time = {
        values = {}
    }

    ## Cluster Auto Scaling ##
    # Only Valid when engine_mode == "serverless"
    scaling_configuration = {
        values = {
            auto_pause = true
            max_capacity = 4
            min_capacity = 1
            seconds_until_auto_pause = 300
            timeout_action = "RollbackCapacityChange"
            }
    }

    ## Cluster Tags ##
    copy_tags_to_snapshot = false
    tags = {
        "db_serverless" = "serverless_2"
    }
}

## Serverless Cluster 3 ##
cluster_3 = {

    ## Cluster Settings ##
    global_cluster_member = false
    cluster_identifier = "serverless3"
    use_cluster_identifier_prefix = false
    replication_source_identifier = ""
    source_region = ""
    apply_immediately = false
    
    ## Cluster Placement ##
    availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
    db_subnet_group_name = "db_serverless"
    create_new_db_subnet_group = false
    new_db_subnet_group = {
        name = "db_serverless"
        subnet_ids = []
        db_subnet_tags = { "db_subnet" = "serverless" }
    }

    ## Cluster System Settings ## 
    database_name = "serverless_3"
    master_username = "Serverless_Admin_Three"
    master_password = "WelliGuessUfoundit"
    engine_mode = "serverless"
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.07.1"
    allow_major_version_upgrade = false
    db_cluster_parameter_group_name = ""
    deletion_protection = false

    enabled_cloudwatch_logs_exports = [] # Not Supported when engine_mode == "serverless"

    ## Cluster Network Settings ##
    port = 3306
    enable_http_endpoint = true # Only valid if engine_mode == "serverless"

    create_cluster_endpoints = false # Cluster endpoints not supported in serverless
    cluster_endpoints = {
        endpoint_1 = {
            cluster_key = "cluster_1"
            cluster_endpoint_identifier = "endpointyuh1"
            custom_endpoint_type = "READER"
            static_members = []
            excluded_members = []
            endpoint_tags = {}
        }
    }

    ## Cluster Security Settings ##
    vpc_security_group_ids = []
    create_new_vpc_security_group = true
    new_vpc_security_group = {
        name = "Serverless_3_Security_Group_1"
        description = "Description YUH"
        vpc_id = module.VPC_VPC1.vpc.id
        ingress_protocols_ports = ["tcp.3306.3306"] # "protocol.fromport.toport"
        ingress_security_groups = []
        ingress_ipv4_cidr_blocks = [module.VPC_VPC1.private_subnet_1.cidr_block, module.VPC_VPC1.private_subnet_2.cidr_block]
        ingress_ipv6_cidr_blocks = []
        egress_protocols_ports = [] # "protocol.fromport.toport"
        egress_security_groups = []
        egress_ipv4_cidr_blocks = []
        egress_ipv6_cidr_blocks = []
        security_group_tags = { "severless_security_groups" = "serverless_3_security_group_1"}
    }
    iam_database_authentication_enabled = false
    iam_roles = []
    storage_encrypted = true # Required when engine_mode == "serverless"
    kms_key_id = ""
    create_new_kms_key = true 
    new_kms_key = {
        description = "key1358"
        deletion_window_in_days = 7
        policy = ""
        enable_key_rotation = false
        key_tags = { "serverless_kms" = "key1358" }
    }

    ## Cluster Backup & Maintenance Settings ##
    preferred_backup_window = "05:00-06:00"
    backup_retention_period = 4
    backtrack_window = 0
    skip_final_snapshot = true
    final_snapshot_identifier = "snapyuh"
    preferred_maintenance_window = "sun:06:00-sun:07:00"

    create_restore_to_point_in_time = false
    restore_to_point_in_time = {
        values = {}
    }

    ## Cluster Auto Scaling ##
    # Only Valid when engine_mode == "serverless"
    scaling_configuration = {
        values = {
            auto_pause = true
            max_capacity = 4
            min_capacity = 1
            seconds_until_auto_pause = 300
            timeout_action = "RollbackCapacityChange"
            }
    }

    ## Cluster Tags ##
    copy_tags_to_snapshot = false
    tags = {
        "db_serverless" = "serverless_3"
    }
}

## Serverless Cluster 4 ##
cluster_4 = {

    ## Cluster Settings ##
    global_cluster_member = false
    cluster_identifier = "serverless4"
    use_cluster_identifier_prefix = false
    replication_source_identifier = ""
    source_region = ""
    apply_immediately = false
    
    ## Cluster Placement ##
    availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
    db_subnet_group_name = "db_serverless"
    create_new_db_subnet_group = false
    new_db_subnet_group = {
        name = "db_serverless"
        subnet_ids = []
        db_subnet_tags = { "db_subnet" = "serverless" }
    }

    ## Cluster System Settings ## 
    database_name = "serverless_4"
    master_username = "Serverless_Admin_Four"
    master_password = "abcdefghijklmnop"
    engine_mode = "serverless"
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.07.1"
    allow_major_version_upgrade = false
    db_cluster_parameter_group_name = ""
    deletion_protection = false

    enabled_cloudwatch_logs_exports = [] # Not Supported when engine_mode == "serverless"

    ## Cluster Network Settings ##
    port = 3306
    enable_http_endpoint = true # Only valid if engine_mode == "serverless"

    create_cluster_endpoints = false # Cluster endpoints not supported in serverless
    cluster_endpoints = {
        endpoint_1 = {
            cluster_key = "cluster_1"
            cluster_endpoint_identifier = "endpointyuh1"
            custom_endpoint_type = "READER"
            static_members = []
            excluded_members = []
            endpoint_tags = {}
        }
    }

    ## Cluster Security Settings ##
    vpc_security_group_ids = []
    create_new_vpc_security_group = true
    new_vpc_security_group = {
        name = "Serverless_4_Security_Group_1"
        description = "Description YUH"
        vpc_id = module.VPC_VPC1.vpc.id
        ingress_protocols_ports = ["tcp.3306.3306"] # "protocol.fromport.toport"
        ingress_security_groups = []
        ingress_ipv4_cidr_blocks = [module.VPC_VPC1.private_subnet_1.cidr_block, module.VPC_VPC1.private_subnet_2.cidr_block]
        ingress_ipv6_cidr_blocks = []
        egress_protocols_ports = [] # "protocol.fromport.toport"
        egress_security_groups = []
        egress_ipv4_cidr_blocks = []
        egress_ipv6_cidr_blocks = []
        security_group_tags = { "severless_security_groups" = "serverless_4_security_group_1"}
    }
    iam_database_authentication_enabled = false
    iam_roles = []
    storage_encrypted = true # Required when engine_mode == "serverless"
    kms_key_id = ""
    create_new_kms_key = true
    new_kms_key = {
        description = "key1359"
        deletion_window_in_days = 7
        policy = ""
        enable_key_rotation = false
        key_tags = { "serverless_kms" = "key1359" }
    }

    ## Cluster Backup & Maintenance Settings ##
    preferred_backup_window = "06:00-07:00"
    backup_retention_period = 4
    backtrack_window = 0
    skip_final_snapshot = true
    final_snapshot_identifier = "snapyuh"
    preferred_maintenance_window = "sun:07:00-sun:08:00"

    create_restore_to_point_in_time = false
    restore_to_point_in_time = {
        values = {}
    }

    ## Cluster Auto Scaling ##
    # Only Valid when engine_mode == "serverless"
    scaling_configuration = {
        values = {
            auto_pause = true
            max_capacity = 4
            min_capacity = 1
            seconds_until_auto_pause = 300
            timeout_action = "RollbackCapacityChange"
            }
    }

    ## Cluster Tags ##
    copy_tags_to_snapshot = false
    tags = {
        "db_serverless" = "serverless_4"
    }
}

}





}