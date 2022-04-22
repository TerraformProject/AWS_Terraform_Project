locals {

  lifecycle_hooks = flatten( [ for target_groups, target_group_vals in var.auto_scaling_groups:
                                [ for hooks, hook_vals in target_group_vals.lifecycle_hooks: hook_vals ]
                                   if target_group_vals.create_lifecycle_hooks == true ] )
}

##################
## ECS: Cluster ##
##################

resource "aws_ecs_cluster" "new_ecs_cluster" {
  for_each = var.create_new_ecs_cluster == true ? var.new_ecs_cluster_settings : {}

  name = each.value.name

  capacity_providers = concat(each.value.existing_capacity_providers, [ for cap_prov in each.value.new_capacity_provider_key: aws_ecs_capacity_provider.new_capacity_providers[cap_prov].name ] )

  dynamic "default_capacity_provider_strategy" {
    for_each = each.value.default_capacity_provider_strategies
    content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider
      weight = default_capacity_provider_strategy.value.weight
      base = default_capacity_provider_strategy.value.base
    }
  }

  setting {
    name  = "containerInsights"
    value = each.value.enable_container_insights == true ? "enabled" : "disabled"
  }

  tags = each.value.tags
}

resource "aws_iam_service_linked_role" "ecs_service_linked_role" {
  count = var.create_new_ecs_cluster == true ? 1 : 0

  aws_service_name = "ecs.amazonaws.com"
}

#############################
## ECS: Capacity Providers ##
#############################

resource "aws_ecs_capacity_provider" "new_capacity_providers" {
  for_each = var.create_capacity_providers == true ? var.capacity_providers : {}

  name = each.value.name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = each.value.auto_scaling_group_arn
    managed_termination_protection = each.value.managed_termination_protection

    managed_scaling {
      maximum_scaling_step_size = each.value.maximum_scaling_step_size
      minimum_scaling_step_size = each.value.minimum_scaling_step_size
      status                    = each.value.status
      target_capacity           = each.value.target_capacity
    }
  }

  depends_on = [
    aws_iam_service_linked_role.ecs_service_linked_role
  ]
}

#################################
## Loadbalancer: Target Groups ##
#################################
## Get VPC ID ##

resource "aws_lb_target_group" "lb_target_groups" {
  for_each = var.create_lb_target_groups == true ? var.lb_target_groups : {}

  vpc_id   = var.vpc_id

  name     = each.value.name
  port     = each.value.port
  protocol = each.value.protocol
  target_type = each.value.target_type
  load_balancing_algorithm_type = each.value.app_lb_algorithm_type
  slow_start = each.value.slow_start
  
  health_check {
    enabled = each.value.health_check["enabled"]
    path = each.value.health_check["path"]
    port = each.value.health_check["port"]
    protocol = each.value.health_check["protocol"]
    healthy_threshold = each.value.health_check["healthy_threshold"]
    interval = each.value.health_check["interval"]
    matcher = each.value.health_check["matcher"]
    timeout = each.value.health_check["timeout"]
    unhealthy_threshold = each.value.health_check["unhealthy_threshold"]
  }
  
  stickiness {
    enabled = each.value.stickiness["enabled"]
    type = each.value.stickiness["type"]
    cookie_duration = each.value.stickiness["cookie_duration"]
  }

  tags = each.value.tags

}

########################
## Auto Scaling Group ##
########################

resource "aws_autoscaling_group" "this" {
  for_each = var.create_auto_scaling_groups == true ? var.auto_scaling_groups : {}  

  ## General ##
  name        = each.value.use_name_prefix == true ? null : each.value.name
  name_prefix = each.value.use_name_prefix == true ? "${each.value.name}-" : null
  service_linked_role_arn = each.value.service_linked_role_arn

  ## Placement ##
  vpc_zone_identifier = each.value.vpc_zone_identifier
  target_group_arns = toset( concat( each.value.existing_target_group_arns, each.value.new_target_group_keys != [] ? [ for target_group_key in each.value.new_target_group_keys: aws_lb_target_group.lb_target_groups[target_group_key].arn ] : [] ) )
  placement_group = each.value.placement_group == "" ? null : each.value.placement_group

  ## Launch ##
  launch_configuration = each.value.use_launch_configuration == true ? each.value.launch_configuration_name : null

  dynamic "mixed_instances_policy" {
    for_each = each.value.use_launch_template == true ? each.value.launch_template_overrides : {}
    content {
      launch_template {
        launch_template_specification {
          launch_template_id = each.value.launch_template_id
          version = each.value.version
        }
      dynamic "override" {
        for_each = each.value.create_launch_template_overrides == true ? each.value.launch_template_overrides : {}
        content {
          instance_type = override.value.instance_type == "" ? null : override.value.instance_type
          weighted_capacity = override.value.weighted_capacity == "" ? null : override.value.weighted_capacity 
          dynamic "launch_template_specification" {
            for_each = override.value.launch_template_id == "" ? {} : each.value.launch_template_overrides
            content {
              launch_template_id = override.value.launch_template_id
            }
          }
        }
      }
    }
    dynamic "instances_distribution" {
      for_each = each.value.create_instance_distributions == true ? each.value.instance_distributions : {}
      content {
        on_demand_allocation_strategy = instances_distribution.value.on_demand_allocation_strategy == "" ? null : instances_distribution.value.on_demand_allocation_strategy
        on_demand_base_capacity = instances_distribution.value.on_demand_base_capacity == 0 ? null : instances_distribution.value.on_demand_base_capacity
        on_demand_percentage_above_base_capacity = instances_distribution.value.on_demand_percentage_above_base_capacity == 0 ? null : instances_distribution.value.on_demand_percentage_above_base_capacity
        spot_allocation_strategy = instances_distribution.value.spot_allocation_strategy == "" ? null : instances_distribution.value.spot_allocation_strategy
        spot_instance_pools = instances_distribution.value.spot_instance_pools == 0 ? null : instances_distribution.value.spot_instance_pools
        spot_max_price = instances_distribution.value.spot_max_price == "" ? null : instances_distribution.value.spot_max_price
      }
    }
  }
}

  ## Scaling ##
    max_size = each.value.max_size
    min_size = each.value.min_size
    desired_capacity = each.value.desired_capacity == 0 ? null : each.value.desired_capacity
    capacity_rebalance = each.value.capacity_rebalance 
    protect_from_scale_in = each.value.protect_from_scale_in 
    max_instance_lifetime = each.value.max_instance_lifetime == 0 ? null : each.value.max_instance_lifetime
    default_cooldown = each.value.default_cooldown == 0 ? null : each.value.default_cooldown

  ## Health Check ##
    health_check_grace_period = each.value.health_check_grace_period == 0 ? null : each.value.health_check_grace_period
    health_check_type = each.value.health_check_type == "" ? null : each.value.health_check_type
    min_elb_capacity = each.value.min_elb_capacity == 0 ? null : each.value.min_elb_capacity
    wait_for_capacity_timeout = each.value.wait_for_capacity_timeout == "" ? null : each.value.wait_for_capacity_timeout

  ## Lifecycle Hooks ##

    dynamic "initial_lifecycle_hook" {
      for_each = each.value.create_initial_lifecycle_hooks == true ? each.value.initial_lifecycle_hooks : {}
      content {
        name                   = initial_lifecycle_hook.value.lifecycle_hook_name
        default_result         = initial_lifecycle_hook.value.default_result
        heartbeat_timeout      = initial_lifecycle_hook.value.heartbeat_timeout == "" ? null : initial_lifecycle_hook.value.heartbeat_timeout
        lifecycle_transition   = initial_lifecycle_hook.value.lifecycle_transition

        notification_metadata =  initial_lifecycle_hook.value.notification_metadata 

        notification_target_arn = initial_lifecycle_hook.value.notification_target_arn == "" ? null : initial_lifecycle_hook.value.notification_target_arn
        role_arn                = initial_lifecycle_hook.value.role_arn == "" ? null : initial_lifecycle_hook.value.role_arn
      }
    }

  ## Warm Pool ##
    dynamic "warm_pool" {
      for_each = each.value.create_warm_pool == true ? each.value.warm_pool : {}
      content {
        pool_state = warm_pool.value.pool_state 
        min_size = warm_pool.value.min_size 
        max_group_prepared_capacity = warm_pool.value.max_group_prepared_capacity 
      }
    }

  ## Instance Refresh ##
    dynamic "instance_refresh" {
      for_each = each.value.create_instance_refresh == true ? each.value.instance_refresh : {}
      content {
        strategy = instance_refresh.value.strategy
        dynamic "preferences" {
          for_each = instance_refresh.value.preferences.instance_warmup == 0 && instance_refresh.value.preferences.min_healthy_percentage == 0 ? {} : instance_refresh.value.preferences
          content {
          instance_warmup = instance_refresh.value.preferences.instance_warmup == 0 ? null : instance_refresh.value.preferences.instance_warmup == 0
          min_healthy_percentage = instance_refresh.value.preferences.min_healthy_percentage == 0 ? null : instance_refresh.value.preferences.min_healthy_percentage
          }
        }
        triggers = instance_refresh.value.triggers == [] ? null : instance_refresh.value.triggers
      }
    }
  
  ## Metrics ## 
    enabled_metrics = each.value.enabled_metrics == [] ? null : each.value.enabled_metrics
    metrics_granularity = each.value.metrics_granularity == "" ? null : each.value.metrics_granularity

  ## Terminate ##
    suspended_processes = each.value.suspended_processes == [] ? null : each.value.suspended_processes
    termination_policies = each.value.termination_policies == [] ? null : each.value.termination_policies
    force_delete = each.value.force_delete

  ## Tags ##
    tags = each.value.tags
}

resource "aws_autoscaling_lifecycle_hook" "asg_lifecycle_hooks" {
  for_each = { for o in local.lifecycle_hooks: o.lifecycle_hook_name => o } 

  name                   = each.value.lifecycle_hook_name
  autoscaling_group_name = each.value.autoscaling_group_name
  default_result         = each.value.default_result
  heartbeat_timeout      = each.value.heartbeat_timeout == "" ? null : each.value.heartbeat_timeout
  lifecycle_transition   = each.value.lifecycle_transition

  notification_metadata =  each.value.notification_metadata 

  notification_target_arn = each.value.notification_target_arn == "" ? null : each.value.notification_target_arn
  role_arn                = each.value.role_arn == "" ? null : each.value.role_arn
}


     