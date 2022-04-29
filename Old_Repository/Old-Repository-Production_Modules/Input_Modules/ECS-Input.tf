module "ECS_VPC1" {
    source = "../../Modules/CICD-Modules/ECS-Modules"

##################
## ECS Services ##
##################
create_ecs_services = true

## General Settings ##
  ecs_service_name = "YUH_Service"
  use_new_task_definition = true
  task_definition_arn = ""
  ecs_cluster = module.AUTO_SCALING_GROUPS.ecs_cluster.arn
  ecs_service_iam_role = ""

## Launch Settings ##
  launch_type = "EC2"
  platform_version = "" # Only valid when launch_type == "FARGATE"
  deployment_controller_type = "ECS"
  scheduling_strategy = "REPLICA"
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 100
  desired_count = 2
  health_check_grace_period_seconds = 300
  wait_for_steady_state = false

  configure_service_registry = false
  service_registry = {
    config = {
      registry_arn = ""
      port = 0
      container_port = 0
      container_name = "" 
    }
  }

  enable_deployment_circuit_breaker_logic = true
  enable_ecs_rollback = true

  configure_capacity_provider_strategies = true
  capacity_provider_strategies = {
    strategy_1 = {
        capacity_provider = module.AUTO_SCALING_GROUPS.capacity_provider_001.name
        base = 1
        weight = 1
    }
    strategy_2 = {
        capacity_provider = module.AUTO_SCALING_GROUPS.capacity_provider_002.name
        base = 0
        weight = 1
    }
  }

  configure_ordered_placement_strategy = false
  ordered_placement_strategy = {
    config = {
        type = ""
        field = ""
    }
  }

  configure_load_balancers = true
  load_balancers = {
      lb_1 = {
          elb_name = ""
          target_group_arn = module.AUTO_SCALING_GROUPS.target_group_1.arn
          container_name = "WordPress"
          container_port = 80
      }
      lb_2 = {
          elb_name = ""
          target_group_arn = module.AUTO_SCALING_GROUPS.target_group_2.arn
          container_name = "WordPress"
          container_port = 80
      }
  }

  configure_service_task_placement_constraints = false
  service_task_placement_constraints = {
    constraint_1 = {
        type = ""
        expression = ""
    }
  }

## Network Settings ##
  configure_network_configuration = false # Only valid for task definitions network_mode == "awsvpc"
  network_configuration = {
    config = {
        subnets = []
        security_groups = []
        assign_public_ip = false
    }
}

## Debug Settings ##
  enable_execute_command = false

## Overrwrite Settings ##
  force_new_deployment = false

## Tag Settings ##
  enable_ecs_managed_tags = false
  propagate_tags = ""
  ecs_service_tags = {
      "key" = "value"
  }



########################## 
## ECS Task Definitiona ##
##########################
create_task_definition = true

## General Settings ##
  family = "Task_Definition_001"
  task_role_arn = ""
  execution_role_arn = ""

## System Settings ##
  ecs_cpu = 1
  ecs_memory = 2
  ipc_mode = "host"
  pid_mode = "host"
  requires_compatibilities = ["EC2"]
  container_definitions = "Input-Values\\Compute\\Scripts\\task_def.json" # Local file path to file containing container definitions
  container_definitions_env_vars = {
    image_url = module.ECR_VPC1.ecr_1.repository_url
    image_name_tag = "$Latest"
    WORDPRESS_DB_HOST = module.AURORA_CLUSTERS_VPC1.serverless1.endpoint
    WORDPRESS_DB_NAME = module.AURORA_CLUSTERS_VPC1.serverless1.database_name
    WORDPRESS_DB_USER = module.AURORA_CLUSTERS_VPC1.serverless1.master_username
    WORDPRESS_DB_PASSWORD = "SuperSecretPassword123" 
    WP_HOME = module.LOADBALANCER_VPC1.app_lb.dns_name
    WP_SITEURL = module.LOADBALANCER_VPC1.app_lb.dns_name
  }

## GPU Settings ##
  configure_inference_accelerator = false
  inference_accelerator = {
    config = {
      device_name = ""
      device_type = ""
    }
  }

## Volume Configurations ##
volume_configurations = {

  config_1 = {
    enabled = false
    module_key = "" # Required, must be unique
    name = ""
    host_path = ""
    volume_config_type = ""
    config = {
      autoprovision = false
      scope = ""
      driver_opts = {}
      driver = ""
      labels = null
    }
  }

  config_2 = {
    enabled = false
    module_key = "wp_cache" # Required, must be unique
    name = "wp_cache"
    host_path = null
    volume_config_type = "docker_volume_configuration"
    config = {
      autoprovision = null
      scope = "task"
      driver_opts = {
        type = "nfs"
        device = ":/cache"
        o = module.EFS.EFS_1.dns_name
      }
      driver = "local"
      labels = null
    }
  }

  config_3 = {
    enabled = true
    module_key = "wp_plugins" # Required, must be unique
    name = "wp_plugins"
    host_path = "/etc/ecs/efsVols"
    volume_config_type = "efs_volume_configuration"
    config = {
      file_system_id = module.EFS.EFS_1.dns_name
      root_directory = "/"
      transit_encryption = "DISABLED"
      transit_encryption_port = null
      authorization_config = {
          access_point_id = ""
          iam = "DISABLED"
      }
    }
  }

  config_4 = {
    enabled = false
    module_key = "" # Required, must be unique
    name = ""
    host_path = ""
    volume_config_type = "fsx_windows_file_server_volume_configuration"
    config = {
      file_system_id = ""
      root_directory = ""
      authorization_config = {
          credentials_parameter = ""
          domain = ""
      }
    }
  }

}

configure_ephemeral_storage = false # AWS Fargate Only
  ephemeral_storage = {
    size_in_gib = 0
  }

  ## Network Settings ##
  network_mode = "bridge"

  configure_proxy_configuration = false
  proxy_configuration = {
    config = {
      type = "APPMESH"
      container_name = ""
      properties = {}
    }
  }

  ## Placement Settings ##
  configure_task_placement_constraints = false
  task_placement_constraints = {
      constraint_1 = {
          type = ""
          expression = ""
      }
  }

  ## Tag Settings ##
  task_definition_tags = {
      "key" = "value"
  }






}