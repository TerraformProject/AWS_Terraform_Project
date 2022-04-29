# Aurora Cluster Module

This module allows you to provision an Aurora Global Cluster along with Aurora Cluster members:

## Aurora Global Cluster

This section of the module allows you to create:

```
    1 - Specify Global Cluster Settings
```

Use the example below as a reference to create the Aurora Global Cluster:

[Aurora Global Cluster Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster)

```terraform

###########################
## Aurora Global Cluster ##
###########################
create_aurora_global_cluster = false # Whether or not to create the Aurora Global Cluster

global_cluster_identifier = "" # The Aurora Global Cluster identifier
global_database_name = "" # Name for an automatically created RDS instance within the Aurora Global Custer
global_engine = "" # The engine that all cluster members will utilize
global_engine_version = "" # The engine version that all cluster memebers will utilize
global_storage_encrypted = true # Whether to encrypt the storage. If true, Source DB Cluster must be encrypted as well. 

source_db_cluster_identifier = "" # The cluster designated with READ/WRITE capabilities. All other clusters will be READ replicas

global_deletion_protection = false # Whether deletion protection is enabled for the global cluster. DB instances deny being terminated when this value is true
global_force_destroy = false # Whether cluster members should be removed before global cluster termination

```

## Aurora Clusters

This section of the module allows you to create:

```
    2 - More than one Aurora Clusters.
        2a - Specify Cluster Settings.
        2b - Create new security group for the Cluster.
        2c - Create new DB subnet group for the Cluster.
        2d - Create cluster endpoints for the Cluster.
        2e - Create a KMS key for storage encryption.
```

Use the blow example as a reference to create more than one Aurora Cluster:

[Aurora Cluster Resource reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster)

[Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_security_group)

[DB Subnet Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)

[Aurora Cluster Endpoint Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_endpoint)

[KMS Key Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)

```terraform

#####################    
## Aurora Clusters ##
#####################
create_aurora_clusters = false # Whether the Aurora Clusters should be created
aurora_clusters = {

    ## Able to create more than one Aurora Cluster. Copy and paste example below

    cluster_1 = { # Key for the Aurora Cluster. Must be unique. Terraform does not process duplicates

    ## Cluster Settings ##
    global_cluster_member = false # Whether the cluster should be a member of the Aurora Global Cluster created above
    cluster_identifier = "" # Unique identifier for the Aurora Cluster
    use_cluster_identifier_prefix = false # Whether to use a prefix for the Cluster Identifier
    replication_source_identifier = "" # The source Aurora Cluster if this cluster were to be a READ replica
    source_region = "" # The AWS region to place a READ replica cluster of this Aurora Cluster 
    apply_immediately = false # Whether changes to this Aurora Cluster are applied immediately or within the next maintenance window
    
    ## Cluster Placement ##
    availability_zones = [] # List of AWS AZs that Cluster Instances may be provisioned in
    db_subnet_group_name = "" # Name of a DB Subnet Group. Cluster Instances must have the same DB Subnet Group name  
    create_new_db_subnet_group = false # Whether to create a new DB Subnet Group
    new_db_subnet_group = {
        name = "" # Name for the DB Subnet Group
        subnet_ids = [] # List of Subnet IDs the DB Subnet Group will use. Subnets must be located with the AZs specified above
        db_subnet_tags = { "key" = "value" } # Keys to associate with the new DB Subnet Group
    }

    ## Cluster System Settings ## 
    database_name = "serverless_1" # Name for an automaitically create DB instance within this Cluster
    master_username = "" # Master username for the Aurora Cluster
    master_password = "" # Master password for the Aurora Cluster
    engine_mode = "" # Engine mode for the Aurora Cluster. See Docs for valid values
    engine = ""# Engine for the Aurora Cluster. See Docs for valid values
    engine_version = "" # Engine version for the Aurora Cluster. See Docs for the valid values
    allow_major_version_upgrade = false # Whether to allow major version upgrades when changing engine versions
    db_cluster_parameter_group_name = "" # Name of a parameter group to apply to the cluster
    deletion_protection = false # DB instances is unable to be deleted of this is set to true

    enabled_cloudwatch_logs_exports = [] # Set of log types to export to CloudWatch. Not Supported when engine_mode == "serverless"

    ## Cluster Network Settings ##
    port = 3306 # Port to send traffic through for the Aurora Cluster
    enable_http_endpoint = true # Whether to enable the Data API Endpoint feature. Only valid if engine_mode == "serverless"

    create_cluster_endpoints = false # Whether to create Cluster Endpoints Cluster endpoints not supported in serverless
    cluster_endpoints = {

        ## Able to create more than one Cluster Endpoint. Copy and paste example below

        endpoint_1 = { # key for the cluster. Must be unique. Terraform does not process duplicates 
            cluster_key = "" # Required, key from above to be used as module reference
            cluster_endpoint_identifier = "" # Unique Cluster endpoint identifier
            custom_endpoint_type = "" # Type of Cluster Endpoint
            static_members = [] # List of instance identiiers to send traffic to
            excluded_members = [] # List of Cluster members to exclude from receive traffic. All other member of this cluster will receive traffic. static_members must == []
            endpoint_tags = { "key" = "value" } # Tags to associate with the Cluster Endpoint 
        }

    }

    ## Cluster Security Settings ##
    vpc_security_group_ids = [] # List of Securit Group IDs to associate with this Cluster
    create_new_vpc_security_group = false # Whether to create a new Security Group for this Cluster
    new_vpc_security_group = {
        name = "" Name for the Security group
        description = "" # Description for the Security Group. "Managed By Terraform" if == ""
        vpc_id = "" # VPC ID the Security Group will be located in
        ingress_protocols_ports = ["tcp.3306.3306"] # "protocol.fromport.toport"
        ingress_security_groups = [] # Security Group IDs to use a source in the ingress rule
        ingress_ipv4_cidr_blocks = [] # List of IPv4 CIDR blocks to apply to the ingress rule
        ingress_ipv6_cidr_blocks = [] # List of IPv6 CIDR blocks to apply to the ingress rule
        egress_protocols_ports = [] # "protocol.fromport.toport"
        egress_security_groups = [] # Security Group IDs to use a source in the egress rule
        egress_ipv4_cidr_blocks = [] # List of IPv4 CIDR blocks to apply to the egress rule
        egress_ipv6_cidr_blocks = [] # List of IPv6 CIDR blocks to apply to the egress rule
        security_group_tags = { "key" = "value" } # Tags to assocaite with the security group
    }
    iam_database_authentication_enabled = false # Whether to enable iam authentication to the databases
    iam_roles = [] # List of ARNs to associate with the created DB instances within the cluster
    storage_encrypted = true # Whether to encrypt store. Required when engine_mode == "serverless"
    kms_key_id = "" # ID of an existing KMS key for encryption
    create_new_kms_key = true # Whether to create new KMS key for encryption
    new_kms_key = {
        description = "" # Required & Unique. Also used for module reference
        deletion_window_in_days = 7 # Number of days before termination of KMS key
        policy = "" # Policy to apply to the KMS key
        enable_key_rotation = false # Whethe key rotation is enabled for this KMS key
        key_tags = { "key" = "value" } # Tags to associate with this key
    }

    ## Cluster Backup & Maintenance Settings ##
    preferred_backup_window = "24:00-24:00" # Preferred window within the AWS region specific time block to perform a backup
    backup_retention_period = 4 # Number of days before the backup is discarded
    backtrack_window = 0 # Amount of time (in seconds) AWS is able to use to rollback changes to a specific point
    skip_final_snapshot = true # Whether to Skip final snapshot upon Cluster termination
    final_snapshot_identifier = "snapyuh" # Unique identifier of the final Cluster snapshot
    preferred_maintenance_window = "sun:24:00-sun:24:00" # Preferred window within the AWS region specific time block to perform system maintnenance

    create_restore_to_point_in_time = false # Whether to create a restore to point in time for the cluster
    restore_to_point_in_time = {
        values = {} # See Terraform & AWS docs for valid values
    }

    ## Cluster Auto Scaling ##
    # Only Valid when engine_mode == "serverless"
    scaling_configuration = {
        values = {
            auto_pause = false # Whether to enable auto pause of the value for seconds_until_auto_pause has been reached
            max_capacity = 0 # Max ACU units the serverless cluster is able to scale out to
            min_capacity = 0 # Min AC units the serverless cluster is able to scale in to
            seconds_until_auto_pause = 0 # Number of seconds before the serverless cluster goes into a paused state
            timeout_action = "" # The action to take when the timeoute is reached
            }
    }

    ## Cluster Tags ##
    copy_tags_to_snapshot = false # Whether to copy the tags specified below to cluster snapshots
    tags = {
        "key" = "value" # Tags to associate with the Aurora Cluster
    }
}

```
