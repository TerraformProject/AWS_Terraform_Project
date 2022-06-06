module "LOADBALANCER_AWS_PROJECT" {
source = "../Back_End_Modules/Load_Balancer-Module"
    
###################
## LOAD BALANCER ##
########################################################
  ## Load Balancer Settings ##
  create_load_balancer = true
  load_balancer_name = "LB-001-VPC-001"
  use_name_prefix = false
  load_balancer_environment = "Testing"
  load_balancer_type = "application"
  internal_load_balancer = false
  enable_deletion_protection = false
  ## Access Log Settings ##
  create_s3_access_logs = false
  s3_access_logs = {
    values = {
      bucket = ""
      prefix = ""
      enable = false
    }}
  ## Load Balancer Tags ##
  load_balancer_tags = { "Load_Balancers_VPC_001" = "LB001VPC001" }
########################################################




##################################
## LOAD BALANCER CONFIGURATIONS ##
########################################################
## APPLICATION LOAD BALANCER CONFIG ##
application = {
  application = {
    existing_subnets = [
      module.VPC_AWS_PROJECT.PubSub_001_VPC_001_id,
      module.VPC_AWS_PROJECT.PubSub_002_VPC_001_id,
    ]
    new_subnet_keys = []
    existing_security_groups = []
    new_security_group_keys = ["app_lb_security_group"]
    ip_address_type = "dualstack"
    customer_owned_ipv4_pool = ""
    enable_http2 = true
    drop_invalid_header_fields = false
    idle_timeout = 30
}}
## NETWORK LOAD BALANCER CONFIG ##
network = {
  network = {
    existing_subnets = [] # Updateing forces new resource
    new_subnet_keys = [] # Updateing forces new resource
    customer_owned_ipv4_pool = ""
    ip_address_type = ""
    enable_cross_zone_load_balancing = false
}}
## GATEWAY LOAD BALANCER CONFIG ##
gateway = {
  gateway = {
    existing_subnets = [] 
    new_subnet_keys = []
    customer_owned_ipv4_pool = ""
    ip_address_type = ""
}}
## SUBNET MAPPING ##
create_subnet_mapping = false
subnet_mapping = {
  #-----------------------------------------#
  mapping_1 = {
    subnet_id = ""
    new_subnet_key = ""
    allocation_id = ""
    private_ipv4_address = ""
    ipv6_address = ""
  }
  #-----------------------------------------#
}
## CREATE NEW SUBNETS ##
create_new_subnets = false
new_subnets = {
  #-----------------------------------------#
  subnet_1 = {
    subnet_name = ""
    vpc_id = ""
    cidr_block = ""
    availability_zone = ""
    customer_owned_ipv4_pool = "" 
    assign_ipv6_address_on_creation = false
    ipv6_cidr_block = ""
    map_customer_owned_ip_on_launch = false
    map_public_ip_on_launch = false
    outpost_arn = ""
    route_table_id_association = ""
    tags = { "" = "", }
  }
  #-----------------------------------------#
}
## CREATE NEW TARGET GROUPS ##
create_lb_target_groups = true
vpc_id = module.VPC_AWS_PROJECT.vpc_001_id
lb_target_groups = {
  #-----------------------------------------#
  target_group_1 = {
    ## Target Group Settings ##
    name = "Trgt-Grp-001-PubSub-001-VPC-001"
    protocol = "HTTP"
    port = 80
    target_type = "instance"
    app_lb_algorithm_type = "round_robin"
    slow_start = 60
    ## Health Check Settings ##
    health_check = {
      enabled = true
      path = "/index"
      port = 80
      protocol = "HTTP"
      healthy_threshold = 3
      interval = 30
      matcher = "200-299"
      timeout = 10
      unhealthy_threshold = 3
    }
    ## Stickiness Settings ##
    stickiness = {
      enabled = true
      type = "lb_cookie"
      cookie_duration = 6000
    }
    ## Target Group Tags ##
    tags = { "Load_Balancer_Target_Groups_VPC_001" = "Trgt-Grp-001-PubSub-001-VPC-001" }
  }
  #-----------------------------------------#
 #-----------------------------------------#
  target_group_2 = {
    ## Target Group Settings ##
    name = "Trgt-Grp-001-PubSub-002-VPC-001"
    protocol = "HTTP"
    port = 80
    target_type = "instance"
    app_lb_algorithm_type = "round_robin"
    slow_start = 60
    ## Health Check Settings ##
    health_check = {
      enabled = true
      path = "/index"
      port = 80
      protocol = "HTTP"
      healthy_threshold = 3
      interval = 30
      matcher = "200-299"
      timeout = 10
      unhealthy_threshold = 3
    }
    ## Stickiness Settings ##
    stickiness = {
      enabled = true
      type = "lb_cookie"
      cookie_duration = 6000
    }
    ## Target Group Tags ##
    tags = { "Load_Balancer_Target_Groups_VPC_001" = "Trgt-Grp-001-PubSub-002-VPC-001" }
  }
  #-----------------------------------------#
}
## CREATE NEW TARGET GROUP LISTENERS ##
create_listeners = true
listeners = {
  #-----------------------------------------#
  listener_1 = {
      ## Listener Settings ##
      port = 80
      protocol = "HTTP"
      ## Listener SSL Certificates ##
      use_ssl_certificate = false
          ssl_certificates = {
            default_certificate = {
              default_ssl_policy = ""
              default_certificate_arn = ""
        }}
        use_additional_ssl_certificates = false
        additional_certificates = {
            #-------------------------------#
            cert_1 = {
              module_key = "" # Must be unique
              listener_key = ""
              certificate_arn = ""
            }
            #-------------------------------#
        }
      ## Listener Default Actions ##
      default_actions = {
            #-------------------------------#
            action_1 = {
              type = "forward"
              values = {
              target_groups = {
                  #-------------------------#
                  target_group_1 = {
                    target_group_index_key = "target_group_1"
                    weight = 50
                  }
                  #-------------------------#
                  #-------------------------#
                  target_group_2 = {
                    target_group_index_key = "target_group_2"
                    weight = 50
                  }
                  #-------------------------#
                } 
              stickiness = {
                enabled = true
                duration = 6000
              }
            }}  
            #-------------------------------#
        }}
  #-----------------------------------------#
}
## CREATE NEW LISTENER RULES ##
create_listener_rules = false
listener_rules = {
  #-----------------------------------------#
  rule_1 = {
      ## Listener Rule Settings ##
      listener_map_key_name = ""
      priority = 0
      ## Listener Rule Actions ##
      actions = {
          #---------------------------------#
          action_1 = {
            type = ""
            values = {
            target_groups = {
                #---------------------------#
                target_group_1 = {
                  target_group_index_key = ""
                  weight = 0
                }
                #---------------------------#
                #---------------------------#
                target_group_2 = {
                  target_group_index_key = ""
                  weight = 0
                }
                #---------------------------#
              } 
              stickiness = {
                enabled = false
                duration = 0
              }
            }}
          #---------------------------------#
      }
      ## Listener Rule Conditions ##
      conditions = {
          #---------------------------------#
          #---------------------------------#
      }}   
  #-----------------------------------------#
}
########################################################




###################################
## LOAD BALANCER SECURITY GROUPS ##
########################################################
create_new_security_groups = true
new_security_groups = {
  #-----------------------------------------#
  app_lb_security_group = {
    ## Security Group Settings ##
    name        = "SecGrp_001_LB_001_VPC_001"
    description = "Security for the 001 Application Load Balancer in VPC 001" 
    vpc_id      = module.VPC_AWS_PROJECT.vpc_001_id
    ## Ingress Rule Declarations ##
    ingress_rules = { 
          #---------------------------------#
          rule_1 = {
            description      = "" 
            from_port        = 80 
            to_port          = 80 
            protocol         = "udp" 
            cidr_blocks      = ["0.0.0.0/0"] 
            ipv6_cidr_blocks = ["::/0"]   
            self = false  
          }
          rule_2 = {
            description      = "" 
            from_port        = 443 
            to_port          = 443 
            protocol         = "tcp" 
            cidr_blocks      = ["0.0.0.0/0"] 
            ipv6_cidr_blocks = ["::/0"]   
            self = false  
          }
          #---------------------------------#
    }
    ## Egress Rule Declarations ##
    egress_rules = {  
          #---------------------------------#
          rule_1 = {
            description      = "" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "-1" 
            cidr_blocks      = ["0.0.0.0/0"] 
            ipv6_cidr_blocks = ["::/0"]   
            self = false 
            }
          #---------------------------------#
    }
    ## Security Group Tags ##
    tags = {
        "AppLB_Security_Groups_VPC_001" = "SecGrp_001_LB_001_VPC_001" # Tags to associate with security group
      }}
  #-----------------------------------------#
}
########################################################




###################
## END OF MODULE ##
###################
}