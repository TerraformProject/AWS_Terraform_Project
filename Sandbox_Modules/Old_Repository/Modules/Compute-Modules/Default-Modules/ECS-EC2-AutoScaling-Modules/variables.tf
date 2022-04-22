############################
## ECS: Cluster Variables ##
############################

variable "create_new_ecs_cluster" {
  description = "Whether to create a new ECS Cluster"
  type = bool
  default = false
}

variable "new_ecs_cluster_settings" {
  description = "Settings for the new ECS cluster"
  type = map(object({
    name = string
    existing_capacity_providers = list(string)
    new_capacity_provider_key = list(string)
    default_capacity_provider_strategies = map(object({
      capacity_provider = string
      weight = number
      base = number
    }))
    enable_container_insights = bool
    tags = map(string)
  }))
  default = null
}


#######################################
## ECS: Capacity Providers Variables ##
#######################################

variable "create_capacity_providers" {
  description = "Whether to create capacity providers for an ECS cluster"
  type = bool
  default = false
}

variable "capacity_providers" {
  description = "New capacity providers"
  type = map(object({
    name = string
    auto_scaling_group_arn = string
    managed_termination_protection = string
    maximum_scaling_step_size = number
    minimum_scaling_step_size = number
    status = string
    target_capacity = number
  }))
  default = null
}

###########################################
## Loadbalancer: Target Groups Variables ##
###########################################

## Get VPC ID by Tag ##

variable "vpc_id" {
  description = "VPC ID to use for target groups"
  type = string
  default = null
}


## Load Balancer Target Groups ##

variable "create_lb_target_groups" {
  description = "Whether to create target groups for a load balancer listener"
  type = bool
  default = false
}

variable "lb_target_groups" {
  description = "Settings for target groups that ASGs will be assigned to"
  type = map(object({
    name = string
    protocol = string
    port = number
    target_type = string
    app_lb_algorithm_type = string
    slow_start = number
    health_check = object({
      enabled = bool
      path = string
      port = number
      protocol = string
      healthy_threshold = number
      interval = number
      matcher = string
      timeout = number
      unhealthy_threshold = number
    })
    stickiness = object({
      enabled = bool
      type = string
      cookie_duration = number
    })
    tags = map(string)
  }))
  default = null
}

##################################
## Auto Scaling Group Variables ##
##################################

variable "create_auto_scaling_groups" {
  description = "Whether or not to create auto scaling groups"
  type = bool
  default = false
}

variable "auto_scaling_groups" {
  description = "Map of objects to specify the auto scaling groups for the lb target groups"
  type = map(object({
    name = string
    use_name_prefix = bool
    service_linked_role_arn = string
    vpc_zone_identifier = list(string)
    existing_target_group_arns = list(string)
    new_target_group_keys = list(string)
    placement_group = string
    use_launch_configuration = bool
    launch_configuration_name = string
    use_launch_template = bool
    launch_template_id = string
    version = string
    create_launch_template_overrides = bool
    launch_template_overrides = map(map(string))
    create_instance_distributions = bool
    instance_distributions = map(object({
      on_demand_allocation_strategy = string
      on_demand_base_capacity = number
      on_demand_percentage_above_base_capacity = number
      spot_allocation_strategy = string
      spot_instance_pools = number
      spot_max_price = string
    }))
    max_size = number
    min_size = number
    desired_capacity = number
    capacity_rebalance = bool
    protect_from_scale_in = bool
    max_instance_lifetime = number
    default_cooldown = number
    health_check_grace_period = number
    health_check_type = string
    min_elb_capacity = number
    wait_for_capacity_timeout = string
    create_initial_lifecycle_hooks = bool
    initial_lifecycle_hooks = map(object({
      lifecycle_hook_name = string
      lifecycle_transition = string
      heartbeat_timeout = number
      default_result = string
      notification_metadata = string
      notification_target_arn = string
      role_arn = string
    }))
    create_lifecycle_hooks = bool
    lifecycle_hooks = map(object({
      lifecycle_hook_name = string
      autoscaling_group_name = string
      lifecycle_transition = string
      heartbeat_timeout = number
      default_result = string
      notification_metadata = string
      notification_target_arn = string
      role_arn = string
    }))
    create_warm_pool = bool
    warm_pool = map(object({
      pool_state = string
      min_size = number
      max_group_prepared_capacity = number
    }))
    create_instance_refresh = bool
    instance_refresh = map(object({
      strategy = string
      preferences = map(number)
      triggers = set(string)
    }))
    enabled_metrics = list(string)
    metrics_granularity = string
    suspended_processes = list(string)
    termination_policies = list(string)
    force_delete = bool
    tags = set(map(string))
  }))
}
















