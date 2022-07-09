locals {

## GET VALUES FROM ecs_clusters variable to create a new kms key for the cluster

    ecs_cluster_kms = flatten([ for cluster, cluster_values in var.ecs_clusters: {
                                    key_name = cluster_values.new_kms_key.key_name
                                    description = cluster_values.new_kms_key.description
                                    is_enabled = cluster_values.new_kms_key.is_enabled
                                    key_usage = cluster_values.new_kms_key.key_usage
                                    cstmr_mstr_key_spec = cluster_values.new_kms_key.customer_master_key_spec
                                    enable_key_rotation = cluster_values.new_kms_key.enable_key_rotation
                                    multi_region = cluster_values.new_kms_key.multi_region
                                    policy_file = cluster_values.new_kms_key.policy_file 
                                    bypass_policy_lockout_safety_check = cluster_values.new_kms_key.bypass_policy_lockout_safety_check
                                    deletion_window_in_days = cluster_values.new_kms_key.deletion_window_in_days
                                    kms_tags = cluster_values.new_kms_key.kms_tags
                            } if cluster_values.kms_key_id == "" && cluster_values.new_kms_key.key_name != "" 
                            ]  )

}



##################
## ECS Clusters ##
##################
resource "aws_ecs_cluster" "aws_ecs_cluster" {
for_each = var.ecs_clusters

  name = each.value.name
  setting {
    name = "containerInsights"
    value = each.value.enable_container_insights == true ? "enabled" : "disabled"
  }
  configuration {
    execute_command_configuration {
        kms_key_id = each.value.kms_key_id
        logging = each.value.logging
        log_configuration {
            cloud_watch_log_group_name = each.value.log_exports.cloudwatch.enabled == true ? each.value.log_exports.cloudwatch.log_group_name : null
            cloud_watch_encryption_enabled = each.value.log_exports.cloudwatch.enabled == true ? each.value.log_exports.cloudwatch.encryption_enabled : null
            s3_bucket_name = each.value.log_exports.s3_bucket.enabled == true ? each.value.log_exports.s3_bucket.bucket_name : null
            s3_key_prefix = each.value.log_exports.s3_bucket.enabled == true ? each.value.log_exports.s3_bucket.bucket_folder : null
            s3_bucket_encryption_enabled = each.value.log_exports.s3_bucket.enabled == true ? each.value.log_exports.s3_bucket.encryption_enabled : null
        }
    }
  }

  tags = {}
}

## ECS Cluster KMS Key ##
resource "aws_kms_key" "ecs_kms" {
for_each = { for o in local.ecs_cluster_kms: o.key_name => o}

      description = each.value.description
      is_enabled = each.value.is_enabled
      key_usage = each.value.key_usage
      customer_master_key_spec = each.value.cstmr_mstr_key_spec == "" ? null : each.value.cstmr_mstr_key_spec
      enable_key_rotation = each.value.enable_key_rotation
      multi_region = each.value.multi_region
      policy = each.value.policy_file != "" ? file(each.value.policy_file) : null
      bypass_policy_lockout_safety_check = each.value.bypass_policy_lockout_safety_check
      deletion_window_in_days = each.value.deletion_window_in_days

      tags = merge(
        {Name = each.value.key_name },
        each.value.kms_tags
        )
}

##################
## ECS Services ##
##################
resource "aws_ecs_service" "ecs_service" {
for_each = {}
  name    = "example"
  cluster = aws_ecs_cluster.example.id
  task_definition = ""



  capacity_provider_strategy {
    base = 1
    capacity_provider = ""
    weight = 100
  }
  deployment_circuit_breaker {
    enable = false
    rollback = false
  }
  deployment_controller {
    type = "EXTERNAL" # CODE_DEPLOY | ECS | EXTERNAL
  }
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 100
  desired_count = 10
  enable_ecs_managed_tags = false
  enable_execute_command = false
  force_new_deployment = false
  health_check_grace_period_seconds = 123456
  iam_role = ""
  launch_type = ""
  load_balancer {
    target_group_arn = ""
    container_name = ""
    container_port = 80
  }
  network_configuration {
    subnets = []
    security_groups = []
    assign_public_ip = false
  }
  ordered_placement_strategy {
    type = ""
    field = ""
  }
  placement_constraints {
    type = ""
    expression = ""
  }
  platform_version = "" # FARGATE Only
  propogate_tags = "" # SERVICE | TASK_DEFINITION
  scheduling_strategy = "" # REPLICA | DAEOMON
  service_registries {
    registry_arn = ""
    port = 80
    container_port = 80
    container_name = ""
  }
  wait_for_strady_state = false
  tags = {}


}

############################
## ECS Capacity Providers ##
############################

resource "aws_ecs_cluster_capacity_providers" "cap_prov_strat" {
  cluster_name = aws_ecs_cluster.example.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_capacity_provider" "cap_prov" {
  name = "test"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.test.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
      instance_warmup_period = 300
    }
  }
}