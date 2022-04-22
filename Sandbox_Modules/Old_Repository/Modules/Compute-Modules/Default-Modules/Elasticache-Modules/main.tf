locals {

    ## New Elasticache Replication Group Parameter Group ##
    new_replication_group_parameter_group = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: group_vals.new_parameter_group if group_vals.new_parameter_group.enabled == true ] )

    ## New Elasticache Replication Group Subnet Group ##

    new_replication_group_subnet_group = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: group_vals.new_elasticache_subnet_group if group_vals.new_elasticache_subnet_group.enabled == true ] )

    add_new_replication_group_subnets = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: 
                                    [ for new_subnet_group, subnet_group_vals in group_vals.new_elasticache_subnet_group:
                                        [ for new_subnets, subnet_vals in group_vals.new_elasticache_subnet_group.add_new_subnets: 
                                            [ for cidr_block_az in group_vals.new_elasticache_subnet_group.add_new_subnets.cidr_block_az: join(":", concat( [group_vals.new_elasticache_subnet_group.add_new_subnets.vpc_id], split(":", cidr_block_az )  ) ) ] 
                                        if group_vals.new_elasticache_subnet_group.enabled == true ] 
                                    ] if group_vals.new_elasticache_subnet_group.enabled == true ] )

    ## New Elasticache Replication Group Security Group ##

    new_replication_group_security_group = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: group_vals.security_group if group_vals.create_security_group == true ] )

    new_replication_group_security_group_name = flatten( [ for replication_group, group_vals in var.elasticache_replication_groups: group_vals.security_group.name if group_vals.create_security_group == true ] )

    replication_group_allowed_ingress_protocols_ports = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: 
                                                    [ for ingress_rules, rule_vals in group_vals.security_group: 
                                                        [ for vals in group_vals.security_group.ingress_protocols_ports: vals ] 
                                                    ]
                                                    if group_vals.create_security_group == true ] )

    replication_group_allowed_egress_protocols_ports = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: 
                                                    [ for egress_rules, rule_vals in group_vals.security_group: 
                                                        [ for vals in group_vals.security_group.egress_protocols_ports: vals ] 
                                                    ]
                                                    if group_vals.create_security_group == true ] )

    ## New Elasticache Replication Group SNS Topic ##

    new_replication_group_sns_topic_name = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: group_vals.new_notification_topic.name if group_vals.create_notification_topic == true ] )

    new_replication_group_sns_topic = flatten( [ for replication_groups, group_vals in var.elasticache_replication_groups: group_vals.new_notification_topic if group_vals.create_notification_topic == true ] )

##############################################################################################################################################################################################################################################################################

    ## New Elasticache Cluster Parameter Group ##
    new_elasticache_parameter_group = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: cluster_vals.new_parameter_group if cluster_vals.new_parameter_group.enabled == true ] )

    ## New Elasticache Cluster Subnets ##

    new_elasticache_subnet_group = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: cluster_vals.new_elasticache_subnet_group if cluster_vals.new_elasticache_subnet_group.enabled == true ] )

    add_new_subnets = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: 
                                    [ for new_subnet_group, subnet_group_vals in cluster_vals.new_elasticache_subnet_group:
                                        [ for new_subnets, subnet_vals in cluster_vals.new_elasticache_subnet_group.add_new_subnets: 
                                            [ for cidr_block_az in cluster_vals.new_elasticache_subnet_group.add_new_subnets.cidr_block_az: join(":", concat( [cluster_vals.new_elasticache_subnet_group.add_new_subnets.vpc_id], split(":", cidr_block_az )  ) ) ] 
                                        if cluster_vals.new_elasticache_subnet_group.enabled == true ] 
                                    ] if cluster_vals.new_elasticache_subnet_group.enabled == true ] )    

    ## New Elasticache Cluster Security Group ##

    new_elasticache_security_group = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: cluster_vals.elasticache_security_group if cluster_vals.create_elasticache_security_group == true ] )

    new_elasticache_security_group_name = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: cluster_vals.elasticache_security_group.name if cluster_vals.create_elasticache_security_group == true ] )

    allowed_ingress_protocols_ports = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: 
                                                    [ for ingress_rules, rule_vals in cluster_vals.elasticache_security_group: 
                                                        [ for vals in cluster_vals.elasticache_security_group.ingress_protocols_ports: vals ] 
                                                    ]
                                                    if cluster_vals.create_elasticache_security_group == true ] )

    allowed_egress_protocols_ports = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: 
                                                    [ for egress_rules, rule_vals in cluster_vals.elasticache_security_group: 
                                                        [ for vals in cluster_vals.elasticache_security_group.egress_protocols_ports: vals ] 
                                                    ]
                                                    if cluster_vals.create_elasticache_security_group == true ] )

    ## New Elasticache Cluster SNS Topic ##

    new_elasticache_sns_topic_name = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: cluster_vals.new_notification_topic.name if cluster_vals.create_notification_topic == true ] )

    new_elasticache_sns_topic = flatten( [ for elasticache_clusters, cluster_vals in var.elasticache_clusters: cluster_vals.new_notification_topic if cluster_vals.create_notification_topic == true ] )
}

##########################################
## Elasticache Global Replication Group ##
##########################################
resource "aws_elasticache_global_replication_group" "global_replication_group" {
count = var.create_global_replication_group == true ? 1 : 0

  
  global_replication_group_id_suffix = var.global_replication_group_id_suffix
  global_replication_group_description = var.global_replication_group_description
  primary_replication_group_id       = var.primary_replication_group_id 
}

####################################
## Elasticache Replication Groups ##
####################################
resource "aws_elasticache_replication_group" "elasticache_replication_group" {
for_each = var.create_elasticache_replication_groups == true ? var.elasticache_replication_groups : {}

  ## Group Settings ##
  global_replication_group_id = each.value.global_replication_group_reader == true ? aws_elasticache_global_replication_group.global_replication_group[0].id : null
  replication_group_id = each.value.replication_group_id
  replication_group_description = each.value.replication_group_description
  engine = each.value.engine
  engine_version = each.value.engine_version
  node_type = each.value.global_replication_group_reader == true ? null : each.value.node_type
  auto_minor_version_upgrade = each.value.auto_minor_version_upgrade 
  port = each.value.port
  parameter_group_name = each.value.new_parameter_group["enabled"] == true ? each.value.new_parameter_group["name"]  : each.value.parameter_group_name

  ## Clustering & Placement Settings ##
  multi_az_enabled = each.value.multi_az_enabled
  automatic_failover_enabled = each.value.automatic_failover_enabled
  dynamic "cluster_mode" {
      for_each = each.value.cluster_mode.values.enabled == true ? each.value.cluster_mode : {}
      content {
          num_node_groups = cluster_mode.value.num_node_groups
          replicas_per_node_group = cluster_mode.value.replicas_per_node_group
      }
  }
  number_cache_clusters = each.value.cluster_mode.values.enabled == true ? null : each.value.number_cache_clusters
  subnet_group_name = each.value.new_elasticache_subnet_group["enabled"] == true ? each.value.new_elasticache_subnet_group["new_elasticache_subnet_group_name"] : each.value.elasticache_subnet_group_name

  ## Security Settings ##
  at_rest_encryption_enabled = each.value.at_rest_encryption_enabled
  transit_encryption_enabled = each.value.transit_encryption_enabled
  auth_token = each.value.auth_token == "" ? null : each.value.auth_token
  kms_key_id = each.value.kms_key_id
  security_group_ids = concat(each.value.vpc_security_group_ids, [ for name in local.new_replication_group_security_group_name: aws_security_group.elasticache_replication_group_security_group[name].id ] ) 

  ## Backup & Maintenance Settings ##
  snapshot_arns = each.value.snapshot_arns
  snapshot_name = each.value.snapshot_name
  snapshot_window = each.value.snapshot_window
  snapshot_retention_limit = each.value.snapshot_retention_limit
  final_snapshot_identifier = each.value.final_snapshot_identifier
  maintenance_window = each.value.maintenance_window

  ## Alert Settings ##
  notification_topic_arn = each.value.create_notification_topic == true ? aws_sns_topic.replication_group_sns_topic[element(local.new_replication_group_sns_topic_name, index(local.new_replication_group_sns_topic_name, each.value.new_notification_topic["name"]) )].arn : each.value.notification_topic_arn

  ## Tag Settings ##
  tags = {
      "key" = "value"
  }
  
}

###################################################
## Elasticache Replication Group Parameter Group ##
###################################################
resource "aws_elasticache_parameter_group" "replication_group_parameter_group" {
for_each = { for o in local.new_replication_group_parameter_group: o.name => o }

  name   = each.value.name
  family = each.value.family

  dynamic "parameter" {
    for_each = each.value.parameters
    content {
        name  = element( split(".", parameter.value), 0)
        value =  element( split(".", parameter.value), 1)
    }
  }

  tags = each.value.tags
}

####################################################
## New Elasticache Replication Group Subnet Group ##
####################################################
resource "aws_elasticache_subnet_group" "new_elasticache_replication_group_subnet_group" {
for_each = { for o in local.new_replication_group_subnet_group: o.new_elasticache_subnet_group_name => o }

  name       = each.value.new_elasticache_subnet_group_name
  description = each.value.description
  subnet_ids = concat( each.value.existing_subnet_ids,  [ for val in local.add_new_subnets: aws_subnet.replcation_group_new_subnets[ val ].id ] ) 
}

resource "aws_subnet" "replcation_group_new_subnets" {
for_each = toset( local.add_new_subnets )

  vpc_id     = element( split(":", each.value), 0 )
  cidr_block = element( split(":", each.value), 1 )
  availability_zone = element( split(":", each.value), 2 )
  

  tags = {
    "elasticache_subnet" = each.value 
  }
}

######################################################
## New Elasticache Replication Group Security Group ##
######################################################
resource "aws_security_group" "elasticache_replication_group_security_group" {
for_each = { for o in local.new_replication_group_security_group: o.name => o }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = toset( [ for val in local.replication_group_allowed_ingress_protocols_ports: split(".", val ) ] )
    content {
      description      = each.value.description
      protocol         = ingress.value[0]
      from_port        = ingress.value[1]
      to_port          = ingress.value[2]
      security_groups = each.value.ingress_security_groups
      cidr_blocks      = each.value.ingress_ipv4_cidr_blocks
      ipv6_cidr_blocks = each.value.ingress_ipv6_cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = toset( [ for val in local.replication_group_allowed_egress_protocols_ports: split(".", val ) ] )
    content {
      description      = each.value.description
      protocol         = egress.value[0]
      from_port        = egress.value[1]
      to_port          = egress.value[2]
      security_groups = each.value.egress_security_groups
      cidr_blocks      = each.value.egress_ipv4_cidr_blocks
      ipv6_cidr_blocks = each.value.egress_ipv6_cidr_blocks
    }
  }

  tags = each.value.security_group_tags
}

#################################################
## New Elasticache Replication Group SNS Topic ##
#################################################
resource "aws_sns_topic" "replication_group_sns_topic" {
for_each = { for o in local.new_replication_group_sns_topic: o.name => o }

  name                        = each.value.name
  display_name = lookup(each.value.values, "display_name", null)
  policy = lookup(each.value.values, "policy", null)
  delivery_policy = lookup(each.value.values, "delivery_policy", null)
  application_success_feedback_role_arn = lookup(each.value.values, "application_success_feedback_role_arn", null)
  application_success_feedback_sample_rate = lookup(each.value.values, "application_success_feedback_sample_rate", null)
  application_failure_feedback_role_arn = lookup(each.value.values, "application_failure_feedback_role_arn", null)
  http_success_feedback_sample_rate = lookup(each.value.values, "http_success_feedback_sample_rate", null)
  http_failure_feedback_role_arn = lookup(each.value.values, "http_failure_feedback_role_arn", null)
  kms_master_key_id = lookup(each.value.values, "kms_master_key_id", null)
  fifo_topic = lookup(each.value.values, "fifo_topic", null)
  content_based_deduplication = lookup(each.value.values, "content_based_deduplication", null)
  lambda_success_feedback_role_arn = lookup(each.value.values, "lambda_success_feedback_role_arn", null)
  lambda_success_feedback_sample_rate = lookup(each.value.values, "lambda_success_feedback_sample_rate", null)
  lambda_failure_feedback_role_arn = lookup(each.value.values, "lambda_failure_feedback_role_arn", null)
  sqs_success_feedback_role_arn = lookup(each.value.values, "sqs_success_feedback_role_arn", null)
  sqs_success_feedback_sample_rate = lookup(each.value.values, "sqs_success_feedback_sample_rate", null)
  sqs_failure_feedback_role_arn = lookup(each.value.values, "sqs_success_failure_feedback_role_arn", null)
  firehose_success_feedback_role_arn = lookup(each.value.values, "firehose_success_feedback_role_arn", null)
  firehose_success_feedback_sample_rate = lookup(each.value.values, "firehose_success_feedback_sample_rate", null)
  firehose_failure_feedback_role_arn = lookup(each.value.values, "firehose_failure_feedback_role_arn", null)

  tags = each.value.tags
}


#######################################################################################################################################################################################################################
#######################################################################################################################################################################################################################


##########################
## Elasticache Clusters ##
##########################
resource "aws_elasticache_cluster" "elasticache_clusters" {
for_each = var.create_elasticache_clusters == true ? var.elasticache_clusters : {}

  ## Cluster Settings ##
  cluster_id           = each.value.cluster_id
  engine               = each.value.engine
  engine_version = each.value.engine_version
  node_type            = each.value.node_type
  num_cache_nodes      = each.value.num_cache_nodes
  port = each.value.port
  parameter_group_name = each.value.new_parameter_group["enabled"] == true ? aws_elasticache_parameter_group.elasticache_parameter_group[each.value.new_parameter_group.name].name  : each.value.parameter_group_name

  ## Placement Settings ##
  az_mode = each.value.az_mode
  availability_zone = length(each.value.preferred_availability_zones) > 0 ? null : each.value.availability_zone
  preferred_availability_zones = length(each.value.preferred_availability_zones) > 0 ? each.value.preferred_availability_zones : null
  subnet_group_name = each.value.new_elasticache_subnet_group["enabled"] == true ? each.value.new_elasticache_subnet_group["new_elasticache_subnet_group_name"] : each.value.elasticache_subnet_group_name

  ## Security Settings ##
  security_group_ids = concat(each.value.security_group_ids, [ for name in local.new_elasticache_security_group_name: aws_security_group.elasticache_security_group[name].id ] )

  ## Maintenance Settings ##
  maintenance_window = each.value.maintenance_window

  ## Redis Only Settings ##
  replication_group_id = each.value.engine == "redis" ? each.value.replication_group_id : null
  snapshot_name = each.value.engine == "redis" ? each.value.snapshot_name : null
  snapshot_arns = each.value.engine == "redis" ? each.value.snapshot_arns : null
  snapshot_window = each.value.engine == "redis" ? each.value.snapshot_window : null
  snapshot_retention_limit = each.value.engine == "redis" ? each.value.snapshot_retention_limit : null
  final_snapshot_identifier = each.value.engine == "redis" ? each.value.final_snapshot_identifier : null

  ## Alert Settings ##
  notification_topic_arn = each.value.create_notification_topic == true ? aws_sns_topic.user_updates[element(local.new_elasticache_sns_topic_name, index(local.new_elasticache_sns_topic_name, each.value.new_notification_topic["name"]) )].arn : each.value.notification_topic_arn

  ## Overwrite Settings ##
  apply_immediately = each.value.apply_immediately

  ## Tag Settings ##
  tags = each.value.tags
}

#####################################
## New Elasticache Parameter Group ##
#####################################
resource "aws_elasticache_parameter_group" "elasticache_parameter_group" {
for_each = { for o in local.new_elasticache_parameter_group: o.name => o }

  name   = each.value.name
  family = each.value.family

 dynamic "parameter" {
    for_each = each.value.parameters
    content {
        name  = element( split(".", parameter.value), 0)
        value =  element( split(".", parameter.value), 1)
    }
  }

  tags = each.value.tags
}

##################################
## New Elasticache Subnet Group ##
##################################
resource "aws_elasticache_subnet_group" "new_elasticache_subnet_group" {
for_each = { for o in local.new_elasticache_subnet_group: o.new_elasticache_subnet_group_name => o }

  name       = each.value.new_elasticache_subnet_group_name
  description = each.value.description
  subnet_ids = concat( each.value.existing_subnet_ids,  [ for val in local.add_new_subnets: aws_subnet.add_new_subnets[ val ].id ] ) 
}

resource "aws_subnet" "add_new_subnets" {
for_each = toset( local.add_new_subnets )

  vpc_id     = element( split(":", each.value), 0 )
  cidr_block = element( split(":", each.value), 1 )
  availability_zone = element( split(":", each.value), 2 )
  

  tags = {
    "elasticache_subnet" = each.value
  }
}

#####################################
## New Elasticache Security Group ##
#####################################
resource "aws_security_group" "elasticache_security_group" {
for_each = { for o in local.new_elasticache_security_group: o.name => o }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = toset( [ for val in local.allowed_ingress_protocols_ports: split(".", val ) ] )
    content {
      description      = each.value.description
      protocol         = ingress.value[0]
      from_port        = ingress.value[1]
      to_port          = ingress.value[2]
      security_groups = each.value.ingress_security_groups
      cidr_blocks      = each.value.ingress_ipv4_cidr_blocks
      ipv6_cidr_blocks = each.value.ingress_ipv6_cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = toset( [ for val in local.allowed_egress_protocols_ports: split(".", val ) ] )
    content {
      description      = each.value.description
      protocol         = egress.value[0]
      from_port        = egress.value[1]
      to_port          = egress.value[2]
      security_groups = each.value.egress_security_groups
      cidr_blocks      = each.value.egress_ipv4_cidr_blocks
      ipv6_cidr_blocks = each.value.egress_ipv6_cidr_blocks
    }
  }

  tags = each.value.security_group_tags
}

###############################
## New Elasticache SNS Topic ##
###############################
resource "aws_sns_topic" "user_updates" {
for_each = { for o in local.new_elasticache_sns_topic: o.name => o }

  name                        = each.value.name
  display_name = lookup(each.value.values, "display_name", null)
  policy = lookup(each.value.values, "policy", null)
  delivery_policy = lookup(each.value.values, "delivery_policy", null)
  application_success_feedback_role_arn = lookup(each.value.values, "application_success_feedback_role_arn", null)
  application_success_feedback_sample_rate = lookup(each.value.values, "application_success_feedback_sample_rate", null)
  application_failure_feedback_role_arn = lookup(each.value.values, "application_failure_feedback_role_arn", null)
  http_success_feedback_sample_rate = lookup(each.value.values, "http_success_feedback_sample_rate", null)
  http_failure_feedback_role_arn = lookup(each.value.values, "http_failure_feedback_role_arn", null)
  kms_master_key_id = lookup(each.value.values, "kms_master_key_id", null)
  fifo_topic = lookup(each.value.values, "fifo_topic", null)
  content_based_deduplication = lookup(each.value.values, "content_based_deduplication", null)
  lambda_success_feedback_role_arn = lookup(each.value.values, "lambda_success_feedback_role_arn", null)
  lambda_success_feedback_sample_rate = lookup(each.value.values, "lambda_success_feedback_sample_rate", null)
  lambda_failure_feedback_role_arn = lookup(each.value.values, "lambda_failure_feedback_role_arn", null)
  sqs_success_feedback_role_arn = lookup(each.value.values, "sqs_success_feedback_role_arn", null)
  sqs_success_feedback_sample_rate = lookup(each.value.values, "sqs_success_feedback_sample_rate", null)
  sqs_failure_feedback_role_arn = lookup(each.value.values, "sqs_success_failure_feedback_role_arn", null)
  firehose_success_feedback_role_arn = lookup(each.value.values, "firehose_success_feedback_role_arn", null)
  firehose_success_feedback_sample_rate = lookup(each.value.values, "firehose_success_feedback_sample_rate", null)
  firehose_failure_feedback_role_arn = lookup(each.value.values, "firehose_failure_feedback_role_arn", null)

  tags = each.value.tags
}
