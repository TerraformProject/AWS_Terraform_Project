module "AUTO_SCALING_GROUPS" {
  source = "../../Modules/Compute-Modules/Default-Modules/ECS-EC2-AutoScaling-Modules"

##################
## ECS: Cluster ##
##################

create_new_ecs_cluster = true
new_ecs_cluster_settings = {
  settings = {
      name = "ECS_Cluster_001"

      existing_capacity_providers = []
      new_capacity_provider_key = ["capacity_provider_001", "capacity_provider_002"]

      default_capacity_provider_strategies = {
        cap_1 = {
          capacity_provider = module.AUTO_SCALING_GROUPS.capacity_provider_001.name
          weight = 1
          base = 1
        }
        cap_2 = {
          capacity_provider = module.AUTO_SCALING_GROUPS.capacity_provider_002.name
          weight = 1
          base = 0
        }
      }

      enable_container_insights = false

      tags = {
        "ecs_cluster_useast1a" = "Cluster_001"
      }
  }
} 

#############################
## ECS: Capacity Providers ##
#############################

create_capacity_providers = true
capacity_providers = {

  capacity_provider_001 = {
    name = "Cluster_001_Capacity_Provider_001"
    auto_scaling_group_arn = module.AUTO_SCALING_GROUPS.asg_001.arn
    managed_termination_protection = "ENABLED"
    maximum_scaling_step_size = 100
    minimum_scaling_step_size = 1
    status = "ENABLED"
    target_capacity = 80
  }

  capacity_provider_002 = {
    name = "Cluster_001_Capacity_Provider_002"
    auto_scaling_group_arn = module.AUTO_SCALING_GROUPS.asg_002.arn
    managed_termination_protection = "ENABLED"
    maximum_scaling_step_size = 100
    minimum_scaling_step_size = 1
    status = "ENABLED"
    target_capacity = 80
  }

}

#################################
## Loadbalancer: Target Groups ##
#################################


## Load Balancer Target Groups ##

create_lb_target_groups = true

vpc_id = module.VPC_VPC1.vpc.id

lb_target_groups = {

  target_group_1 = {
    name = "target-group-001"
    protocol = "HTTP"
    port = 80
    target_type = "instance"
    app_lb_algorithm_type = "round_robin"
    slow_start = 600
    health_check = {
      enabled = true
      path = "/index.html"
      port = 80
      protocol = "HTTP"
      healthy_threshold = 3
      interval = 10
      matcher = "200"
      timeout = 9
      unhealthy_threshold = 3
    }
    stickiness = {
      enabled = true
      type = "lb_cookie"
      cookie_duration = 30 
    }

    tags = {
      "target_groups_useast1" = "target_group_001"
    }
  }

  target_group_2 = {
    name = "target-group-002"
    protocol = "HTTP"
    port = 80
    target_type = "instance"
    app_lb_algorithm_type = "round_robin"
    slow_start = 600
    health_check = {
      enabled = true
      path = "/index.html"
      port = 80
      protocol = "HTTP"
      healthy_threshold = 3
      interval = 10
      matcher = "200"
      timeout = 9
      unhealthy_threshold = 3
    }
    stickiness = {
      enabled = true
      type = "lb_cookie"
      cookie_duration = 86400
    }

    tags = {
      "target_groups_useast1" = "target_group_002"
    }
  }

}
  
#########################
## Auto Scaling Group  ##
#########################

create_auto_scaling_groups = true

auto_scaling_groups = {

  #########################
  ## AutoScaling Group 1 ##
  #########################
  asg_001 = {
    ## General ##
      name = "asg_001"
      use_name_prefix = false
      service_linked_role_arn = ""

    ## Placement ##
      vpc_zone_identifier = [module.VPC_VPC1.private_subnet_1.id]
      existing_target_group_arns = []
      new_target_group_keys = ["target_group_1"]
      placement_group = ""

    ## Launch ##

      # Launch Configuration
      use_launch_configuration = false
      launch_configuration_name = "asdasd" # Leave "" to use launch template

      # Launch Template
      use_launch_template = true
      launch_template_id = module.AMI_LT.LT_001.id
      version = "$Latest"
        
      create_launch_template_overrides = false
      launch_template_overrides = {
        override_1 = {
          instance_type = ""
          weighted_capacity = ""
          launch_template_id = ""
        }
      }
        
      create_instance_distributions = false 
      instance_distributions = {
        settings = {
          on_demand_allocation_strategy = ""
          on_demand_base_capacity = 0
          on_demand_percentage_above_base_capacity = 0
          spot_allocation_strategy = ""
          spot_instance_pools = 0
          spot_max_price = ""
        }
      }
      
    ## Scaling ##
      max_size = 2
      min_size = 1
      desired_capacity = 1
      capacity_rebalance = false
      protect_from_scale_in = true
      max_instance_lifetime = 86400
      default_cooldown = 0
    
    ## Health Check ##
      health_check_grace_period = 600
      health_check_type = "EC2"
      min_elb_capacity = 1
      wait_for_capacity_timeout = "10m"

    ## LifeCycle Hooks ##
      create_initial_lifecycle_hooks = false
      initial_lifecycle_hooks = {
        hook_1 = {
          lifecycle_hook_name = "false" # Name must be unique
          notification_target_arn = ""
          role_arn = ""
          lifecycle_transition = ""
          heartbeat_timeout = 0
          default_result = ""
          notification_metadata = ""
        }
      }

      create_lifecycle_hooks = false
      lifecycle_hooks = {
        hook_1 = {
          lifecycle_hook_name = "" # Name must be unique
          autoscaling_group_name = ""
          notification_target_arn = ""
          role_arn = ""
          lifecycle_transition = ""
          heartbeat_timeout = 0
          default_result = ""
          notification_metadata = ""
        }
      }

    ## Warm Pool ##
      create_warm_pool = false
      warm_pool = {
        settings = {
          pool_state = "Running"
          min_size = 0
          max_group_prepared_capacity = 0
        }
      }

    ## Instance Refresh ##
      create_instance_refresh = false
      instance_refresh = {
        settings = {
          strategy = "Rolling"
          preferences = {
            instance_warmup = 0
            min_healthy_percentage = 0
          }
          triggers = []
        }
      }
    ## Metrics ##
      enabled_metrics = []
      metrics_granularity = ""

    ## Terminate ##
      suspended_processes = [] 
      termination_policies = []
      force_delete = true

    ## Tags ##
      tags = [{
      "key" = "ASG_useast1a"
      "value" = "ASG_001"
      "propagate_at_launch" = "true"
      },
    ]

    }


  asg_002 = {
    ## General ##
      name = "asg_002"
      use_name_prefix = false
      service_linked_role_arn = ""

    ## Placement ##
      vpc_zone_identifier = [module.VPC_VPC1.private_subnet_2.id]
      existing_target_group_arns = []
      new_target_group_keys = ["target_group_2"]
      placement_group = ""

    ## Launch ##

      # Launch Configuration
      use_launch_configuration = false
      launch_configuration_name = "asdasd" # Leave "" to use launch template

      # Launch Template
      use_launch_template = true
      launch_template_id = module.AMI_LT.LT_001.id
      version = "$Latest"
        
      create_launch_template_overrides = false
      launch_template_overrides = {
        override_1 = {
          instance_type = ""
          weighted_capacity = ""
          launch_template_id = ""
        }
      }
        
      create_instance_distributions = false 
      instance_distributions = {
        settings = {
          on_demand_allocation_strategy = ""
          on_demand_base_capacity = 0
          on_demand_percentage_above_base_capacity = 0
          spot_allocation_strategy = ""
          spot_instance_pools = 0
          spot_max_price = ""
        }
      }
      
    ## Scaling ##
      max_size = 2
      min_size = 1
      desired_capacity = 1
      capacity_rebalance = false
      protect_from_scale_in = true
      max_instance_lifetime = 86400
      default_cooldown = 0
    
    ## Health Check ##
      health_check_grace_period = 600
      health_check_type = "EC2"
      min_elb_capacity = 1
      wait_for_capacity_timeout = "10m"

    ## LifeCycle Hooks ##
      create_initial_lifecycle_hooks = false
      initial_lifecycle_hooks = {
        hook_1 = {
          lifecycle_hook_name = "false" # Name must be unique
          notification_target_arn = ""
          role_arn = ""
          lifecycle_transition = ""
          heartbeat_timeout = 0
          default_result = ""
          notification_metadata = ""
        }
      }

      create_lifecycle_hooks = false
      lifecycle_hooks = {
        hook_1 = {
          lifecycle_hook_name = "" # Name must be unique
          autoscaling_group_name = ""
          notification_target_arn = ""
          role_arn = ""
          lifecycle_transition = ""
          heartbeat_timeout = 0
          default_result = ""
          notification_metadata = ""
        }
      }

    ## Warm Pool ##
      create_warm_pool = false
      warm_pool = {
        settings = {
          pool_state = "Running"
          min_size = 0
          max_group_prepared_capacity = 0
        }
      }

    ## Instance Refresh ##
      create_instance_refresh = false
      instance_refresh = {
        settings = {
          strategy = "Rolling"
          preferences = {
            instance_warmup = 0
            min_healthy_percentage = 0
          }
          triggers = []
        }
      }
    ## Metrics ##
      enabled_metrics = []
      metrics_granularity = ""

    ## Terminate ##
      suspended_processes = [] 
      termination_policies = []
      force_delete = true

    ## Tags ##
      tags = [{
      "key" = "ASG_useast1a"
      "value" = "ASG_001"
      "propagate_at_launch" = "true"
      },
    ]
    
    }
  
















  }

  

























}