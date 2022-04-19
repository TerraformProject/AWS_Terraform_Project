module "Blank_LOADBALANCER" {
source = ""
    
###################
## LOAD BALANCER ##
########################################################
  ## Load Balancer Settings ##
  create_load_balancer = false
  load_balancer_name = ""
  use_name_prefix = false
  load_balancer_environment = ""
  load_balancer_type = ""
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
  load_balancer_tags = { "" = "" }
########################################################




##################################
## LOAD BALANCER CONFIGURATIONS ##
########################################################
## APPLICATION LOAD BALANCER CONFIG ##
application = {
  application = {
    existing_subnets = []
    new_subnet_keys = []
    existing_security_groups = []
    new_security_group_keys = []
    ip_address_type = ""
    customer_owned_ipv4_pool = ""
    enable_http2 = false
    drop_invalid_header_fields = false
    idle_timeout = 0
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
create_lb_target_groups = false
vpc_id = ""
lb_target_groups = {
  #-----------------------------------------#
  target_group_1 = {
    ## Target Group Settings ##
    name = ""
    protocol = ""
    port = 0
    target_type = ""
    app_lb_algorithm_type = ""
    slow_start = 0
    ## Health Check Settings ##
    health_check = {
      enabled = false
      path = ""
      port = 0
      protocol = ""
      healthy_threshold = 0
      interval = 0
      matcher = "0"
      timeout = 0
      unhealthy_threshold = 0
    }
    ## Stickiness Settings ##
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 0 
    }
    ## Target Group Tags ##
    tags = { "" = "" }
  }
  #-----------------------------------------#
  #-----------------------------------------#
  target_group_2 = {
    ## Target Group Settings ##
    name = ""
    protocol = ""
    port = 0
    target_type = ""
    app_lb_algorithm_type = ""
    slow_start = 0
    ## Health Check Settings ##
    health_check = {
      enabled = false
      path = ""
      port = 0
      protocol = ""
      healthy_threshold = 0
      interval = 0
      matcher = "0"
      timeout = 0
      unhealthy_threshold = 0
    }
    ## Stickiness Settings ##
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 0 
    }
    ## Target Group Tags ##
    tags = { "" = "" }
  }
  #-----------------------------------------#
}
## CREATE NEW TARGET GROUP LISTENERS ##
create_listeners = true
listeners = {
  #-----------------------------------------#
  listener_1 = {
      ## Listener Settings ##
      port = 0
      protocol = ""
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
              type = ""
              values = {
              target_groups = {
                  #-------------------------#
                  target_group_1 = {
                    arn = ""
                    weight = 0
                  }
                  #-------------------------#
                  #-------------------------#
                  target_group_2 = {
                    arn = ""
                    weight = 0
                  }
                  #-------------------------#
                } 
              stickiness = {
                enabled = false
                duration = 0
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
                  arn = ""
                  weight = 0
                }
                #---------------------------#
                #---------------------------#
                target_group_2 = {
                  arn = ""
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
create_new_security_groups = false
new_security_groups = {
  #-----------------------------------------#
  app_lb_security_group = {
    ## Security Group Settings ##
    name        = ""
    description = "" 
    vpc_id      = "" 
    ## Ingress Rule Declarations ##
    ingress_rules = { 
          #---------------------------------#
          rule_1 = {
            description      = "" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "" 
            cidr_blocks      = [] 
            ipv6_cidr_blocks = []   
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
            protocol         = "" 
            cidr_blocks      = [] 
            ipv6_cidr_blocks = []   
            self = false 
            }
          #---------------------------------#
    }
    ## Security Group Tags ##
    tags = {
        "" = "" # Tags to associate with security group
      }}
  #-----------------------------------------#
}
########################################################




###################
## END OF MODULE ##
###################
}