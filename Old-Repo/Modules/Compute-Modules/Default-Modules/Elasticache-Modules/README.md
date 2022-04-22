# Elasticache Module

```
In this module the user is able to create:
    1   -   Elasticache Global Replication Group.
    2   -   Create one or more Elasticache Replication Groups.
    3   -   Create one or more Elasticache Clusters.
```

## Elasticache Global Replication Group

```
In this section of the module, the user is able to create:
    1   -   Elasticach Global Replication Group
        1a - Specify Global Replication Group Settings.
        1b - Specify a Primary Replication Group ID.

```

Use the example below to create an Elasticache Global Replication Group.

[Global Replication Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_global_replication_group)

```terraform
##########################################
## Elasticache Global Replication Group ##
##########################################
create_global_replication_group = false # Whether to create an Elasticache Global Replication Group

global_replication_group_id_suffix = "" # Specified suffix to append to the Global Replication Group ID for identification
global_replication_group_description = "" # Description for the Global Replication Group
primary_replication_group_id = "" # Replication Group ID to designate as the primary WRITER/READER in the Global Replication Group
```

## Elasticache Replication Group 

```
In this section of the module the user is able to create:
    2   -   One or more Elasticache Replication Groups.
        2a - Specify Replication Group Settings.
            2aa - Specify if Replication group is part of the Global Replication Group created above.
            2ab - Specify the replication group ID.
            2ac - Replication Group System Settings.
            2ad - Specify existing or create new Elasticache parameter group for the Elasticache Replication Group.
        2b - Specify Replication Group placement settings.
            2ba - Specify multi-zone clustering.
            2bb - Specify cluster mode or number of cache clusters.
            2bc - Specify existing or create new Elasticache subnet group.
                2bca - Able to create new subnets if specifying new Elasticache subnet group.
        2c - Specify Replication Group Security Settings.
            2ca - Specify Encryption Settings.
            2cb - Specify existing or create new Security Group.
        2d - Specify Replication Group Backup & Maintenance Settings.
            2da - Specify Snapshot settings.
            2db - Specify Maintenance Window
        2e - Specify Replication Group Alert settings.
            2ea - Specify existing or create new sns topic.
        2f - Associate tags with the replication group.

```

Use the example below to create one or more replication groups:

[Elasticache Replication Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group)

[Elasticache Parameter Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group)

[Elasticache Subnet Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group)

[Subnet Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

[Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

[SNS Topic Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)

```terraform
###################################
## Elasticache Replication Group ##
###################################
create_elasticache_replication_groups = false
elasticache_replication_groups = {

    ## Able to create more than one replication group. Copy and paste example below

    replication_group_1 = { # Module key for the replication group. Must be unique. Terraform does not process duplicates
        ## Group Settings ##
        global_replication_group_reader = false # Whether this replication group is a READER member of the Global Replication group create above
        replication_group_id = "" # ID for the replication group
        replication_group_description = "" # Description for the replication group
        engine = "" # "redis" is only supported value
        engine_version = "" # Redis Engine version to use for the replication group
        node_type = "" # Null if global_replication_group_reader == true. Also may be referred to as the cache instance class
        auto_minor_version_upgrade = false # Whether to enable minor version upgrades during maintenance windows
        port = 6379 # Port 6379 supported only. Port Elasticache Redis listens on. 
        parameter_group_name = "" # Name of existing Elasticache Parameter Group to apply to the replication group
        new_parameter_group = {
            enabled = false # Whether to create a new Elasticache Parameter Group to apply to the replication group
            name = "" # Name for the Elasticache Parameter Group
            family = "" # Specific parameter group family to apply to this Elasticache Parameter Group. See AWS Docs to specify
            parameters = [] # Ex: "Name.Value"  ( List of Name to value pairings for the Elasitcache Parameter Group. See AWS Docs for specific parameter. ) 
            tags = { "key" = "value" } # Tags to associate with the Elasticache Parameter Group
        }

        ## Clustering & Placement Settings ##
        multi_az_enabled = false # Whether multi-availability-zone is enabled for the replication group
        automatic_failover_enabled = false # cluster_mode must be enabled. Whether automatic failover from one AZ to another is enabled
        cluster_mode = {
          values = {
            enabled = false # Whether cluster mode is enabled for the Replication Group
            num_node_groups = 0 # Number of Node groups 
            replicas_per_node_group = 0 # Number of replicas per node group
          }
        }
        number_cache_clusters = 0 # Number of cache cluster for the Replication Group. Conflicts if cluster_mode is enabled. If multi_az_enabled == true, value must be > 1 
        elasticache_subnet_group_name = "" # Name of existing Elasticache Subnet Group to apply to this Replication group
        new_elasticache_subnet_group = {
            enabled = false # Whether to create a new Elasticache Replication Group
            new_elasticache_subnet_group_name = "" # Name of new Elasticache Subnet Group
            description = "" # Description of new Elasticache Subnet Group
            existing_subnet_ids = [] # List of existing subnet group IDs to use in new Elasticache subnet group
            add_new_subnets = {
                enabled = false # Whether to create new subnets for the Elasticache subnet group
                vpc_id = "" # VPC ID of which the subnets will be located in
                cidr_block_az = [] # Ex: "CIDR_Block:AZ" (CIDR block and Availability Zone for the new subnet)
            }
        }

        ## Security Settings ##
        at_rest_encryption_enabled = false # Whether data rest in elasticache nodes is encrypted
        transit_encryption_enabled = false # Whether data in-transit to and from Elasticache nodes is encrypted
        auth_token = "" # Auth token for access
        kms_key_id = "" # ID of KMS key to encrypt Elasticache data
        vpc_security_group_ids = [] # List of existing security group ids to apply to the replication group
        create_security_group = false # Whether to create a new security group for the replciation group
        security_group = {
            name = "" # Name for the new security group
            description = "" # Description for the new security group
            vpc_id = "" # VPC ID the new security group will be located in
            ingress_protocols_ports = [] # Ex: "protocol.fromport.toport" 
            ingress_security_groups = [] # Security group IDs to be used as a source for ingress traffic
            ingress_ipv4_cidr_blocks = [] # IPv4 CIDR blocks to be used for a soucr of ingress traffic
            ingress_ipv6_cidr_blocks = [] # IPv6 CIDR blocks to be used for a soucr of ingress traffic
            egress_protocols_ports = [] # "protocol.fromport.toport"
            egress_security_groups = [] # Security Group IDs to be used for a destination of egress traffic
            egress_ipv4_cidr_blocks = [] # IPv4 CIDR Blocks to be used for a destination of egress traffic
            egress_ipv6_cidr_blocks = [] # IPv6 CIDR Blocks to be used for a destination of egress traffic
            security_group_tags = { "key" = "value"} # Tags to assoicate to the security group
        }

        ## Backup & Maintenance Settings ##
        snapshot_arns = [] # Must not contain commas List of Redis Snapshot ARNs stored in S3
        snapshot_name = "" # Name of snapshot of which to restore data into the new node group with
        snapshot_window = "" # Timeframe of which snapshots of the Elasticache nodes will be taken
        snapshot_retention_limit = 0 # If 0, no snapshots are taken. Number of days snapshots are held in retention before deletion
        final_snapshot_identifier = "" # Final snapshot identifier upon termination of the replication group
        maintenance_window = "" # Timeframe of which Replication group will undergo maintenance

        ## Alert Settings ##
        notification_topic_arn = "" # Existing SNS topic arn to apply to the Replication Group
        create_notification_topic = false # Whether to create a new SNS topic for the replication group
        new_notification_topic = {
            name = "" # Name for the SNS topic
            values = {

                ## Reference the SNS Topic Resource Reference above to specify attributes and element for the new SNS Topic

            }
            tags = { "key" = "value" } # Tags to associate with the new SNS Topic
        }

        ## Tag Settings ##
        tags = {
            "key" = "value" # Tags to associate with the Elasticache Replication Group
        }
    }

}
```

## Elasticache Clusters

```
Use thos section of the module to create:
    3   -   One or more Elasticache Clusters
        3a - Specify Cluster Settings.
        3b - Specify Redis Only Cluster Settings.
        3c - Specify Placement Settings.
            3ca - Specify Availability Zone placement settings.
            3cb - Specify existing or create new Elasticache Subnet Group.
                3cba - Specify new subnets if creating new Elasticache Subnet Group.
        3d - Specify Elasticache Security Settings.
            3da - Specify existing or create new Security Groups.
        3e - Specify Maintenance Window Settings.
        3f - Specify Alert Settings.
            3fa - Specify existing or create new SNS Topic
        3g - Specify Overwrite Settings
        3h - Specify Cluster Tags
```

Use the example below as a reference to create one or more Elasticache Cluster:

[Elasticache Cluster Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster)

[Elasticache Subnet Group Reosurce Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group)

[Subnet Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

[Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

[SNS Topic Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)

```terraform 
##########################
## Elasticache Clusters ##
##########################
create_elasticache_clusters = true # Whether to create Elasticache Clusters
elasticache_clusters = {

    ## Able to create more than one Elasticache Cluster. Copy and paste example below

    cluster_1 = { # Module key for the Elasticache Cluster. Must be unique. Terraform does process duplicates
        ## Cluster Settings ##
        cluster_id = "" # ID for the Elasticache Cluster
        engine = "" # Engine for the Elasticache Cluster. Values : "redis" || "memcached"
        engine_version = "" # Engine version for cluster engine. See AWS docs to specify
        node_type = "" # Node type to run the Cluster engine on. Also may referred to as the cach instance class 
        num_cache_nodes = 0 # Number of Cache nodes to run in the cluster
        port = 11211 # Port the Elasiticache Cluster listens on. Values: 11211 (memcached) || 6379 (redis)
        parameter_group_name = "" # Name of existinf parameter group to apply to the Elasticache Cluster
        new_parameter_group = {
            enabled = false # Whether to create a new Elasticache parameter group for the Elasticache Cluster
            name = "" # Name for the Elasticache parameter group
            family = "" # Specific parameter group family. See AWS Docs to specify
            parameters = [] # "Name.Value" ( List of name and value pairings to be set as parameters for the Elasticache parameter group)
            tags = { "Key" = "value" } # Tags to assocaite with the new Elasticache paramter group
        }

        ## Redis Only Settings ##
        replication_group_id = "" # Replication Group ID to make this Elasticache Cluster a READER for. Otherwise this Elasticache Cluster is a Standalone Primary WRITER/READER
        snapshot_name = "" # Name of the snapshot to restore the node group with
        snapshot_arns = [] # Single element list, ARN of snapshot stored in S3
        snapshot_window = "" # Timeframe for when automatic snapshots are taken of the Elasticache Cluster
        snapshot_retention_limit = 0 # If 0, no snapshots are taken. Number of days snapshots are held in retention before deletion
        final_snapshot_identifier = "" # Name of final snapshot identifier upon deletion of Elasticache Cluster
        
        ## Placement Settings ##
        az_mode = "cross-az" # Availiability Zone mode for the Elasticache Cluster. Values: "cross-az" || "single-az"
        availability_zone = "" # For one-zone setup
        preferred_availability_zones = [] # For multi-AZ setup
        elasticache_subnet_group_name = "" # Existing name of Elasticache subnet group to apply to the Elasticache Cluster
        new_elasticache_subnet_group = {
            enabled = true # Whether a new Elasticache subnet group should be created
            new_elasticache_subnet_group_name = "" # Name for the Elasticache subnet group
            description = "" # Description for the Elasticache subnet group
            existing_subnet_ids = [] # List of existing subnet ids to apply to the new Elasticache subnet group
            add_new_subnets = {
                enabled = false # Whether to create new subnets for the Elasticache Subnet groups
                vpc_id = "" # The VPC ID the new subnets will be located in
                cidr_block_az = [] # "CIDR_Block:AZ" ( List of CIDR Block:Availability zones for the the new subnet)
            }
        }

        ## Security Settings ##
        security_group_ids = [] # Existing security group ids to apply to the Elasticache Cluster
        create_elasticache_security_group = true # Whether to create a new security group for the Elasticache Cluster
        elasticache_security_group = {
            name = "" # Name for the new Security group
            description = "" Description for the new security group
            vpc_id = "" # VPC ID the new security group will be located in
            ingress_protocols_ports = [] # Ex: "protocol.fromport.toport" 
            ingress_security_groups = [] # Security group IDs to be used as a source for ingress traffic
            ingress_ipv4_cidr_blocks = [] # IPv4 CIDR blocks to be used for a soucr of ingress traffic
            ingress_ipv6_cidr_blocks = [] # IPv6 CIDR blocks to be used for a soucr of ingress traffic
            egress_protocols_ports = [] # "protocol.fromport.toport"
            egress_security_groups = [] # Security Group IDs to be used for a destination of egress traffic
            egress_ipv4_cidr_blocks = [] # IPv4 CIDR Blocks to be used for a destination of egress traffic
            egress_ipv6_cidr_blocks = [] # IPv6 CIDR Blocks to be used for a destination of egress traffic
            security_group_tags = { "key" = "value"} # Tags to assoicate to the security group
        }

        ## Maintenance Settings ##
        maintenance_window = "" # Timeframe for when the Elasticache Cluster wil undergo maintenance

        ## Alert Settings ##
        notification_topic_arn = "" # ARN of existing notification topic to apply to the Elasticache Cluster
        create_notification_topic = false # Whether to create a new SNS Topic for the Elasticache Cluster
        new_notification_topic = {
            name = "" # Name for the new SNS Topic
            values = {

            ## Reference the SNS Topic Resource Reference above to specify attributes and element for the new SNS Topic

            }
            tags = { "key" = "value" } # Tags to associate with the new SNS Topic
        }

        ## Overwrite Settings ##
        apply_immediately = false # Whether to apply changes to the Elasticache Cluster immediately or in the next maintenance window

        ## Tag Settings ##
        tags = {
            "key" = "value" # Tags to associate with the Elasticache Cluster
        }
    }

}
```