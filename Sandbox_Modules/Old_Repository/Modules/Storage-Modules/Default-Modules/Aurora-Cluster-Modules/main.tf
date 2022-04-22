locals {

  db_subnets = flatten( [ for clusters, cluster_vals in var.aurora_clusters: cluster_vals.new_db_subnet_group if cluster_vals.create_new_db_subnet_group == true ] )

  endpoints = flatten( [ for clusters, cluster_vals in var.aurora_clusters: 
                          [ for endpoints, endpoint_vals in cluster_vals.cluster_endpoints: endpoint_vals ] if cluster_vals.create_cluster_endpoints == true ] )

  cluster_kms = flatten( [ for clusters, cluster_vals in var.aurora_clusters: cluster_vals.new_kms_key if cluster_vals.create_new_kms_key == true ] )

  new_security_group = flatten( [ for clusters, cluster_vals in var.aurora_clusters: cluster_vals.new_vpc_security_group if cluster_vals.create_new_vpc_security_group == true ] )

  allowed_ingress_protocols_ports = flatten( [ for clusters, cluster_vals in var.aurora_clusters: 
                                                [ for ingress_rules, rule_vals in cluster_vals.new_vpc_security_group: 
                                                    [ for vals in cluster_vals.new_vpc_security_group.ingress_protocols_ports: vals ] 
                                                  ]
                                                 if cluster_vals.create_new_vpc_security_group == true ] )

  allowed_egress_protocols_ports = flatten( [ for clusters, cluster_vals in var.aurora_clusters: 
                                                [ for egress_rules, rule_vals in cluster_vals.new_vpc_security_group: 
                                                    [ for vals in cluster_vals.new_vpc_security_group.egress_protocols_ports: vals ] 
                                                  ]
                                                 if cluster_vals.create_new_vpc_security_group == true ] )
}

###########################
## Aurora Global Cluster ##
###########################

resource "aws_rds_global_cluster" "global_cluster" {
count = var.create_aurora_global_cluster == true ? 1 : 0

  global_cluster_identifier = var.global_cluster_identifier
  database_name             = var.global_database_name
  engine                    = var.source_db_cluster_identifier != "" || var.source_db_cluster_identifier != null ? null : var.global_engine
  engine_version            = var.global_engine_version
  storage_encrypted = var.global_storage_encrypted

  source_db_cluster_identifier = var.source_db_cluster_identifier
 
  deletion_protection = var.global_deletion_protection
  force_destroy = var.global_force_destroy
}

#####################
## Aurora Clusters ##
#####################

resource "aws_rds_cluster" "aurora_clusters" {
for_each = var.create_aurora_clusters == true ? var.aurora_clusters : {}

  ## Cluster Settings ##
  global_cluster_identifier = each.value.global_cluster_member == true && var.create_aurora_global_cluster == true ? var.global_cluster_identifier : null
  cluster_identifier      = each.value.use_cluster_identifier_prefix == true ? null : each.value.cluster_identifier
  cluster_identifier_prefix = each.value.use_cluster_identifier_prefix == true ? "${each.value.cluster_identifier}-" : null
  replication_source_identifier = each.value.replication_source_identifier
  source_region = each.value.source_region
  apply_immediately = each.value.apply_immediately

  ## Cluster Placement ##
  availability_zones      = each.value.availability_zones
  db_subnet_group_name = each.value.create_new_db_subnet_group == true ? each.value.new_db_subnet_group["name"] : each.value.db_subnet_group_name

  ## Cluster System Settings ##
  database_name = each.value.global_cluster_member == true && var.create_aurora_global_cluster == true ? var.global_database_name : each.value.engine_mode
  master_username = each.value.master_username
  master_password = each.value.master_password
  engine_mode = each.value.global_cluster_member == true && var.create_aurora_global_cluster == true ? "global" : each.value.engine_mode
  engine                  = each.value.global_cluster_member == true && var.create_aurora_global_cluster == true ? var.global_engine : each.value.engine
  engine_version          = each.value.global_cluster_member == true && var.create_aurora_global_cluster == true ? var.global_engine_version : each.value.engine_version
  allow_major_version_upgrade = each.value.allow_major_version_upgrade
  db_cluster_parameter_group_name = each.value.db_cluster_parameter_group_name
  deletion_protection = each.value.deletion_protection

  enabled_cloudwatch_logs_exports = each.value.enabled_cloudwatch_logs_exports

  ## Cluster Network Settings ##
  port = each.value.port
  enable_http_endpoint = each.value.enable_http_endpoint

  ## Cluster Security Settings ##
  vpc_security_group_ids = each.value.create_new_vpc_security_group == true ? concat( [aws_security_group.db_security_group[each.value.new_vpc_security_group["name"]].id], each.value.vpc_security_group_ids ) : each.value.vpc_security_group_ids
  iam_database_authentication_enabled = each.value.iam_database_authentication_enabled
  iam_roles = each.value.iam_roles
  storage_encrypted = each.value.storage_encrypted
  kms_key_id = each.value.create_new_kms_key == true ? aws_kms_key.cluster_kms[each.value.new_kms_key["description"]].arn : each.value.kms_key_id

  ## Cluster Backup & Maintenance Settings ##
  preferred_backup_window = each.value.preferred_backup_window
  backup_retention_period = each.value.backup_retention_period
  backtrack_window = each.value.backtrack_window
  skip_final_snapshot = each.value.skip_final_snapshot
  final_snapshot_identifier = each.value.final_snapshot_identifier
  preferred_maintenance_window = each.value.preferred_maintenance_window

  dynamic "restore_to_point_in_time" {
      for_each = each.value.create_restore_to_point_in_time == true ? each.value.restore_to_point_in_time : {}
      content {
        source_cluster_identifier  = restore_to_point_in_time.value.source_cluster_identifier
        restore_type               = restore_to_point_in_time.value.restore_type
        restore_to_time = restore_to_point_in_time.value.restore_to_time
      }
  }

  ## Cluster Auto Scaling ##
  dynamic "scaling_configuration" {
      for_each = each.value.engine_mode == "serverless" ? each.value.scaling_configuration : {}
      content {
        auto_pause = scaling_configuration.value.auto_pause
        max_capacity = scaling_configuration.value.max_capacity
        min_capacity = scaling_configuration.value.min_capacity
        seconds_until_auto_pause = scaling_configuration.value.seconds_until_auto_pause
        timeout_action = scaling_configuration.value.timeout_action
      }
  }

  ## Cluster Tags ##
  copy_tags_to_snapshot = each.value.copy_tags_to_snapshot
  tags = each.value.tags
}

##############################
## Aurora Cluster Endpoints ##
##############################

resource "aws_rds_cluster_endpoint" "cluster_endpoints" {
for_each = { for o in local.endpoints: o.cluster_endpoint_identifier => o }

  cluster_identifier          = aws_rds_cluster.aurora_clusters[each.value.cluster_key].cluster_identifier
  cluster_endpoint_identifier = each.value.cluster_endpoint_identifier
  custom_endpoint_type        = each.value.custom_endpoint_type
  static_members = each.value.static_members
  excluded_members = each.value.static_members != [] ? null : each.value.excluded_members

  tags = each.value.endpoint_tags
}

############################
## Aurora DB Subnet Group ##
############################

resource "aws_db_subnet_group" "db_subnet_group" {
for_each = { for o in local.db_subnets: o.name => o }

  name       = each.value.name
  subnet_ids = each.value.subnet_ids

  tags = each.value.db_subnet_tags
}

#########################
## New Cluster KMS Key ##
#########################

resource "aws_kms_key" "cluster_kms" {
for_each = { for o in local.cluster_kms: o.description => o }

  description             = each.value.description
  is_enabled = true
  deletion_window_in_days = each.value.deletion_window_in_days
  policy = each.value.policy
  enable_key_rotation = each.value.enable_key_rotation
  
  tags = each.value.key_tags
}

###########################
## New DB Security Group ##
###########################

resource "aws_security_group" "db_security_group" {
for_each = { for o in local.new_security_group: o.name => o }

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