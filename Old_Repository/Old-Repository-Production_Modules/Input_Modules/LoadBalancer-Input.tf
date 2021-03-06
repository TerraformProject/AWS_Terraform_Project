module "LOADBALANCER_VPC1" {
    source = "../../Modules/Compute-Modules/Default-Modules/Loadbalancer-Modules"
    
###################
## Load Balancer ##
###################

  create_load_balancer = true

  load_balancer_name = "LB001"
  use_name_prefix = false
  load_balancer_environment = "development"

  load_balancer_type = "application"
  internal_load_balancer = false
  enable_deletion_protection = false

## Application Load Balancer ##
  application = {
    application = {
      existing_subnets = [module.VPC_VPC1.public_subnet_1.id, module.VPC_VPC1.public_subnet_2.id]
      new_subnet_keys = []
      existing_security_groups = []
      new_security_group_keys = ["lb_001_app_security_group"]
      ip_address_type = "ipv4"
      customer_owned_ipv4_pool = ""
      enable_http2 = false
      drop_invalid_header_fields = false
      idle_timeout = 75
    }
  }
  ## New Security Groups ##
    create_new_security_groups = true
    new_security_groups = {

      lb_001_app_security_group = {
        name        = "lb_001_app_security_group"
        description = "This is the security group for the LB 001" 
        vpc_id      = module.VPC_VPC1.vpc.id 

        ingress_rules = { 
          rule_1 = {
            description      = "all" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "-1" 
            cidr_blocks      = ["0.0.0.0/0"] 
            ipv6_cidr_blocks = []   
            self = false  
            }
          }

        egress_rules = {  
          rule_1 = {
            description      = "all" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "-1" 
            cidr_blocks      = ["0.0.0.0/0"] 
            ipv6_cidr_blocks = []   
            self = false 
            }
          }

          tags = {
              "key" = "value" # Tags to associate with security group
            }
          }
        }

## Network Load Balancer ##
  network = {
    network = {
      existing_subnets = [] # Updateing forces new resource
      new_subnet_keys = [] # Updateing forces new resource
      customer_owned_ipv4_pool = ""
      ip_address_type = "ipv4"
      enable_cross_zone_load_balancing = false
    }
  }
## Gateway Load Balancer ##
  gateway = {
    gateway = {
      existing_subnets = [] 
      new_subnet_keys = []
      customer_owned_ipv4_pool = ""
      ip_address_type = "ipv4"
    }
  }

## Create New Subnets ##
  create_new_subnets = false
  new_subnets = {

    subnet_1 = {
      subnet_name = ""
      vpc_id = ""
      cidr_block = ""
      availability_zone = "us-east-1a"
      customer_owned_ipv4_pool = "" 
      assign_ipv6_address_on_creation = false
      ipv6_cidr_block = ""
      map_customer_owned_ip_on_launch = false
      map_public_ip_on_launch = false
      outpost_arn = ""

      route_table_id_association = ""

      tags = {
          "key" = "value",
      }
    }

  }

## Subnet Mapping ##
  create_subnet_mapping = false
  subnet_mapping = {
      mapping_1 = {
        subnet_id = ""
        new_subnet_key = ""
        allocation_id = ""
        private_ipv4_address = ""
        ipv6_address = "ipv4"
      }
    }

## Access Logs ##
  create_s3_access_logs = false
  s3_access_logs = {
    values = {
      bucket = ""
      prefix = ""
      enable = false
    }
  }

## Tags ##
  load_balancer_tags = {
    "LB_useast1" = "LB_001"
  }

##########################################
## Application Load Balancer: Listeners ##
##########################################

create_listeners = true
listeners = {

  listener_1 = {

    ## Listener Settings ##
      port = 80
      protocol = "HTTP"

    ## Listener SSL Certificates ##
      use_ssl_certificate = false
        ssl_certificates = {
          default_certificate = {
            default_ssl_policy = "ELBSecurityPolicy-2016-08"
            default_certificate_arn = ""
          }
        }
      use_additional_ssl_certificates = false
        additional_certificates = {
          cert_1 = {
            module_key = "1" # Must be unique
            listener_key = "listener_1"
            certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
          }
          cert_2 = {
            module_key = "2" # Must be unique
            listener_key = "listener_1"
            certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-1289012"
          }
        }

    ## Listener Default Actions ##
      default_actions = {
        action_1 = {
          type = "forward"
          values = {
            target_groups = {
              target_group_1 = {
                arn = module.AUTO_SCALING_GROUPS.target_group_1.arn
                weight = 50
              }
              target_group_2 = {
                arn = module.AUTO_SCALING_GROUPS.target_group_2.arn
                weight = 50
              }
            } 
            stickiness = {
              enabled = true
              duration = 100
            }
          }
        }  
      }
    }

}

###############################################
## Application Load Balancer: Listener Rules ##
###############################################

create_listener_rules = false
listener_rules = {

  rule_1 = {
    listener_map_key_name = "listener_1"
    priority = 20

  ## Listener Rule Actions ##
    actions = {

      action_1 = {
        type = "forward"
        values = {
          target_groups = {
            target_group_1 = {
              arn = module.AUTO_SCALING_GROUPS.target_group_1.arn
              weight = 50
            }
            target_group_2 = {
              arn = module.AUTO_SCALING_GROUPS.target_group_2.arn
              weight = 50
            }
          } 
          stickiness = {
            enabled = true
            duration = 100
          }
        }
      }

  }

  ## Listener Rule Conditions ##
    conditions = {
      source_ip = {
        ip_1 = {
          values = ["107.11.41.205/32"]
        }
      }

    }
  }   

}




}