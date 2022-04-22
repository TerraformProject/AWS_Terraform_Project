module "CODEDEPLOY_VPC1" {
    source = "../../../Modules/CICD-Modules/CodeDeploy-Modules"
    
############################
## CodeDeploy Application ##
############################

    create_codedeploy_app = false
    app_compute_platform = "ECS"
    app_name = "app_yuh"

    codedeploy_app_tags = {
        "key" = "value"
    }

######################################
## CodeDeploy Deployment Config ##
######################################

    create_deployment_config = false
    deployment_config_name = "config_yuh"
    config_compute_platform = "ECS"

    create_minimum_healthy_hosts = false
    minimum_healthy_hosts = {
        settings = {
            type = "HOST_COUNT"
            value = 10
        }
    }

    create_traffic_routing_config = false
    traffic_routing_config = {
        settings = {
          # One of TimeBasedLinear or TimeBasedCanary only
            type = "TimeBasedLinear"
            create_time_based_linear = false
                time_based_linear = {
                  settings = {
                    interval = 10
                    percentage = 10
                  }  
                }
            create_time_based_canary = false
                time_based_canary = {
                  settings = {
                    interval = 10
                    percentage = 50
                  }
                }
        }
    }

#################################
## CodeDeploy Deployment Group ##
#################################

    create_deployment_group = false
    deployment_group_name = "deployment_group_yuh"
    deployment_config_for_group = "config_yuh"
    codedeploy_app_name = "app_yuh"
    deployment_goup_service_role_arn = ""

    deployment_style = {
        deployment_option = "WITH_TRAFFIC_CONTROL"
        deployment_type = "BLUE_GREE"
    }

    create_ec2_tag_filter = false
    ec2_tag_filter = {
      # Able to create more than one Tag Filter
        tag_filter_1 = {
            type = "KEY_AND_VALUE"
            key = "yuh1"
            value = "huy1"
        }
    } 

    create_ecs_deployment = false
    ecs_service = {
        settings = {
            cluster_name = "cluster_yuh" 
            service_name = "service_yuh"
        }
    }

    create_blue_green_deployment_config = false
    blue_green_deployment_config = {
    # Only one deployemnt configuration is allowed
        settings = {
            create_deployment_ready_option = false
                deployment_ready_option = {
                  setttings = {
                    action_on_timeout = ""
                    wait_time_in_minutes = 30
                    }
                }
            create_green_fleet_provisioning_option = false
                green_fleet_provisioning_option = {
                    action = ""
                }
            create_terminate_blue_instances_on_deployment_success = false
                terminate_blue_instances_on_deployment_success = {
                  settings = {
                    action = ""
                    termination_wait_time_in_minutes = 0 
                    }
                }
        }
    }

    use_autoscaling_groups = false
    autoscaling_groups_for_deployment_group = [""]

    create_load_balancer_info = false
    load_balancer_info = {
    # One of elb_info or target_group_info or target_group_pair_info only
      settings = {
        create_elb_info = false
            elb_info = {
              settings = {
                name = ""
              }
            }
        create_target_group_info = false
            target_group_info = {
              settings = {
                name = "target_group_yuh"
              }
            }
        create_target_group_pair_info = false
            target_group_pair_info = {
              settings = {
                prod_traffic_route = {
                    listener_arns = [""]
                    }
                target_group = {
                    target_group_name = ""
                    } 
                create_test_traffic_route = false
                test_traffic_route = {
                    listener_arns = [""]
                    }
                }
            }
        }
    }

    create_trigger_configuration = false
        trigger_configuration = {
            settings = {
                trigger_events = ["DeploymentRollback"]
                trigger_name = ""
                trigger_target_arn = "" 
            }
        }

    create_auto_rollback_configuration = false
    auto_rollback_configuration = {
        settings = {
            enabled = false
            events = [""]
        }
    }

    create_alarm_configuration = false
    alarm_configuration = {
        settings = {
            alarms = [""]
            enabled = false
            ignore_poll_alarm_failure = false
        }
    }

    deployment_group_tags = {
        "key" = "value"
    }

}