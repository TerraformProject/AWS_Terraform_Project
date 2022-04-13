# Auto Scaling ECS Module

This module allow you to create:

```
    1 - Create an ECS Cluster.
        1a - Specify ECS Cluster settings.
        1b - Associate existing capacity providers.
        1c - Associate newly created capacity providers from module
        1d - Create a default capacity provider strategy.
    2 - Capacity Providers.
    3 - Target Groups
    4 - Auto Scaling Groups

```

## ECS Cluster

Use the example below as a reference to create an ECS Cluster:

[ECS Cluster Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster)

```terraform

create_new_ecs_cluster = false # Whether to create an ECS Cluster
new_ecs_cluster_settings = {
  settings = {
      name = "" # Name for the ECS CLuster

      existing_capacity_providers = [] # Existing short names of existing capacity providers to assocaite with ECS Cluster
      new_capacity_provider_key = [] # Keys of newly created capacity providers from below to associate with the ECS Cluster

      default_capacity_provider_strategy = {

        ## Able to create more than one default capacity provider. Copy and paste example below 

        default_cap_prov_strat_1 = { # Key of the default capacity provider strategy. Must be unique. Terraform does not process duplicates
          capacity_provider = "" # The short name of the capacity provider
          weight = 0 # Relative percentage of tasks that should use this cpacity provider
          base = 0 # The minimum number of tasks that must run on this capacity provider
        }
      }

      enable_container_insights = false # Whether to enable container insights for the ECS Cluster

      tags = {
        "key" = "value" # Tags to associate for the ECS CLuster
      }
  }
}

```

## ECS Capacity Providers

Use the example to create more than one capacity provider for the ECS Cluster:

[Capacity Provider Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider)

```terraform

create_capacity_providers = false # Whether to create ECS capacity providers for the ECS Cluster
capacity_providers = {

    ## Able to create more than one capacity provider. Copy and paste example below

  cap_1 = { # Key for the capacity provider. Must be unique. Terraform does not process duplicates
    name = "" # Name for the capacity provider
    auto_scaling_group_arn = "" # ASG ARN to associate the capacity provider to
    managed_termination_protection = "" # Whether termination protection is "ENABLED" || "DISABLED" 
    maximum_scaling_step_size = 1 # Maximum step adjustment size
    minimum_scaling_step_size = 1 # Minumum step adjustment size
    status = "" # Whether capacity provider is "ENABLED" || "DISABLED" 
    target_capacity = 1 # Target utilization for the capacity provider
  }
}

```

## Load Balancer Target_Groups

Use this example to create more than one Target Group

[Target Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)

```terraform

create_lb_target_groups = false # Whether to create the Target Groups

vpc_id = "" # VPC ID of which the target groups will be located in

lb_target_groups = {

    ## Able to create more than one target group. Copy and paste example below

  target_group = { # Key of the target group. Must be unique. Terraform does not process duplicates
    name = "" # Name for the target group
    protocol = "" # Protocol the target group will accept
    port = 80 # Port the target group will accept
    target_type = "" Type of targets. Valid values: "instance" || "ip" || "lambda" 
    app_lb_algorithm_type = "" # How the load balancer selects targets when routing requests. Valid values: "round_robin" || "least_outstanding_requests"
    health_check = {
      enabled = false # Whether health checks are enabled
      path = "" # Destination for the health check request
      port = 80 # Port to use eot connect with the target for the health check
      protocol = "" # Protocol to use for the health check
      healthy_threshold = 5 # Number of consecutive health check successes before considering an unhealthy target healthy
      interval = 5 # Amount of time (in seconds), between health checks
      matcher = "200-299" # Response codes to use when checking for healthy healthy responses from a target
      timeout = 6 # Amount of time (in seconds) during which no response from a target means a failed health check
      unhealthy_threshold = 3 # Number of consecutive health check failures required before considering the target unhealthy
    }
    stickiness = {
      enabled = false # Whether cookie stickiness is enabled
      type = "" # Type of sticky session. Valid values: "lb_cookie" || "source_ip"
      cookie_duration = 30 # Time period in seconds during which request from the client are forwarded to the same target
    }

    tags = {
      "key" = "value" # Tags to associate with the target group
    }
  }
}

```

## Auto Scaling Groups

Use the example below to create more than one Auto Scaling Group: 

[Auto Scaling Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)

[Life Cycle Hook Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_lifecycle_hook)

```terraform

create_auto_scaling_groups = false # Whether to create auto scaling groups
auto_scaling_groups = {

    ## Able to create more than one auto scaling group. Copy and paste example below

  asg_1 = { # Key for the Auto Scaling Group. Must be unqique. Terraform does not process duplicates
    ## General ##
      name = "" # Name for the Auto Scaling Group
      use_name_prefix = false # Whether to use a name prefix for the Auto Scaling Group name
      service_linked_role_arn = "" # # Service liked role ARN for the Auto Scaling group

    ## Placement ##
      vpc_zone_identifier = [] # Subnet IDs the Auto Scaling Group will be located in
      existing_target_group_arns = [] # Existing Target group IDs to associate the Auto Scaling Group with
      new_target_group_keys = [] # Keys of the target groups created above to associate the Auto Scaling Group with
      placement_group = "" # The placement group, if any, to associate the Auto Scaling Group with

    ## Launch ##

      # Launch Configuration
      use_launch_configuration = false # Whether to use a launch configuration for the Auto Scaling Group
      launch_configuration_name = "" # Leave "" to use launch template. Name of the launch configuration

      # Launch Template
      use_launch_template = false # Whether to use a launch template for the Auto Scaling Group
      launch_template_id = "" # The ID of the launch template to use with the Auto Scaling Group
      version = "" # The Launch Template version to use with the Auto Scaling Group
        
      create_launch_template_overrides = false # Whether to create launch template overrides
      launch_template_overrides = { 

          ## Able to create more than one launch template override. Copy and paste the example below.

        override_1 = {
          instance_type = "" # Instance type for the launch template override
          weighted_capacity = "" # Distribution of traffic to launch template override
          launch_template_id = "" # Launch template ID for the launch temoplate override
        }
      }
        
      create_instance_distributions = false # Whether to create instance distributions for the launch template
      instance_distributions = {
        settings = {
          on_demand_allocation_strategy = "" # Strategy to use when launching on-demand instances. Valid values: "prioritized"
          on_demand_base_capacity = 0 # Absolute minimum amount of desired capacity that must be fulfiled by on-demand instances
          on_demand_percentage_above_base_capacity = 0 # Percentage split between on-demand and Spot instances above the base on-demand capacity
          spot_allocation_strategy = "" # How to allocate capacity cpacity across the Spot pools
          spot_instance_pools = 0 # Number of spot pools per availablity zone to allocate capacity
          spot_max_price = "" # Max price per unit hour that the user is willing to pay for the spot instances
        }
      }
      
    ## Scaling ##
      max_size = 0 # Maximum size of the Auto Scaling Group
      min_size = 0 # Minumum size of the Auto Scaling Group
      desired_capacity = 0 # The number of EC2 instances that should be running in the Auto Scaling Group
      capacity_rebalance = false # Whether capacity rebalance for the Auto Scaling Group is enabled
      protect_from_scale_in = false # Whether protection from Auto Scaling group scaling in enabled
      max_instance_lifetime = 0 # Maximum time in seconds an instance on the Auto scaling Group runs before it is destroyed
      default_cooldown = 0 # Amount of time in between scaling for the Auto Scaling Group
    
    ## Health Check ##
      health_check_grace_period = 0 # Amount of time in seconds, before checking health
      health_check_type = "" # How health checking is done. Valid values: "EC2" || "ELB"
      min_elb_capacity = 0 # Causes Terraform to wait for this number of instances from this Auto Scaling Group to show up healthy in the ELB, only on creation
      wait_for_capacity_timeout = "" # Maximum duration that Terraform should wait for ASG instances to be healthy before timing out 

    ## LifeCycle Hooks ##
      create_initial_lifecycle_hooks = false # Whether to create an intial lifecycle hook for the Auto Scaling group
      initial_lifecycle_hooks = {

          ## Able to create more than one intial life cylce hook. Copy and paste the example below

        hook_1 = { Key for the initial lifecycle. Must be unique. Terraform does not process duplicates
          lifecycle_hook_name = "" # Name must be unique. Used for module reference 
          notification_target_arn = "" # ARN of the target to send notifications to
          role_arn = "" # Service role the ASG will use to send notifications to
          lifecycle_transition = "" # Instance state for which the hook will be assocaited with
          heartbeat_timeout = 0 # Amount of time in seconds, before the hook time out
          default_result = "" # The action to take when the hook times out
          notification_metadata = "" # Additional information to include in the notification
        }
      }

      create_lifecycle_hooks = false # Whether to create a life cycle hook for the Auto Scaling group
      lifecycle_hooks = {

         ## Able to create more than one life cylce hook. Copy and paste the example below

        hook_1 = { Key for the initial lifecycle. Must be unique. Terraform does not process duplicates
          lifecycle_hook_name = "" # Name must be unique. Used for module reference 
          notification_target_arn = "" # ARN of the target to send notifications to
          role_arn = "" # Service role the ASG will use to send notifications to
          lifecycle_transition = "" # Instance state for which the hook will be assocaited with
          heartbeat_timeout = 0 # Amount of time in seconds, before the hook time out
          default_result = "" # The action to take when the hook times out
          notification_metadata = "" # Additional information to include in the notification
        }
      }

    ## Warm Pool ##
      create_warm_pool = false # Whether to create a warm pool for the Auto Scaling Group
      warm_pool = {
        settings = {
          pool_state = "Running" # Sets the instance state to transition after the lifecycle hooks finish
          min_size = 0 # Specified the minimum number of instances to maintain in the warm pool
          max_group_prepared_capacity = 0 # Maximum number of instances that are allowed in the warm pool
        }
      }

    ## Instance Refresh ##
      create_instance_refresh = false # Whether to create an instance refresh
      instance_refresh = {
        settings = {
          strategy = "Rolling" The strategy to use for the isntance refresh
          preferences = {
            instance_warmup = 0 # Number of seconds until a newly launched instance is configured and redy to use
            min_healthy_percentage = 0 # Amount of capacity in the Auto Scaling Group the must remain healthy for the instance refresh to continue
          }
          triggers = [] # Property names that will trigger an instance refresh
        }
      }
    ## Metrics ##
      enabled_metrics = [] # List of metrics to collect
      metrics_granularity = "" # The granularity to associate with the metrics to collect

    ## Terminate ##
      suspended_processes = [] # A list of processes to suspend for the Auto Scaling Group
      termination_policies = [] # # A list of policies that detirmine how the instances should be terminated
      force_delete = false # Whether instances should be deleted upon termination of the Auto Scaling Group

    ## Tags ##
      tags = [{ # List of tags to associate with the Auto Scaling Group
      "key" = "yuhkey"
      "value" = "yuhval"
      "propagate_at_launch" = "true"
      },
    ]
    }

```