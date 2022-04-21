# AWS Load Balancer

### Load Balancer Settings

**Declare Load Balancer will be created using the below example.**

[AWS Documentation: Load Balancer Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/what-is-load-balancing.html)

[HashiCorp Terraform: Load Balancer Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)

```Terraform
###################
## LOAD BALANCER ##
########################################################
  ## Load Balancer Settings ##
  create_load_balancer = false # Whether or not to create a load balancer
  load_balancer_name = "" # Name of the load balancer
  use_name_prefix = false # Whether to use a naming prefix for the name of the load balancer
  load_balancer_environment = "" # The environment tag to be merged with the load balancer tags
  load_balancer_type = "" # type of load balancer to create 
  internal_load_balancer = false # Whether or not this load balancer should be internal or public
  enable_deletion_protection = false # Whether deletion protection should be enabled for the load balancer
  ## Access Log Settings ##
  create_s3_access_logs = false # Whether or not to create S3 access logs for the load balancer 
  s3_access_logs = {
    values = {
      bucket = "" # S3 Bucket name to store the access logs in
      prefix = "" # S3 Bucket prefix. Logs are stored in root (/) if not configured
      enable = false # Whether or not to enable access logs for the load balancer
    }}
  ## Load Balancer Tags ##
  load_balancer_tags = { "" = "" } # Tags to associate with the load balancer
########################################################
```

### Load Balancer Configurations

[AWS Documentation: Application Load Balancer Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)   
    
[AWS Documentation: Network Load Balancer Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/introduction.html)    
    
[AWS Documentation: Gateway Load Balancer Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/introduction.html)    
   
[HashiCorp Terraform: Load Balancer Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)        

**Use the example below to specify whether the load balancer being created will be an application, network, gateway load balancer. As well, create new Subnets, Target Groups, Listeners, Listener Rules, and associate security groups.**

```Terraform
##################################
## LOAD BALANCER CONFIGURATIONS ##
########################################################
## APPLICATION LOAD BALANCER CONFIG ##
application = {
  application = {
    existing_subnets = [] # Subnet ID of existing subnets to associate with the application load balancer
    new_subnet_keys = [] # Module keys that reference the newly created subnets below for the application load balancer
    existing_security_groups = [] # Existing security groups for the application load balancer
    new_security_group_keys = [] # Module keys that reference the newly create security groups from below for the application load balancer
    ip_address_type = "" # Type of IP address to use for the application load balancer
    customer_owned_ipv4_pool = "" # Customer owned IPv4 pool to use for the application load balancer
    enable_http2 = false # Whether or not to enable HTTP2 for the application load balancer
    drop_invalid_header_fields = false # Whether or not to drop invalid header fields when passing through the application load balancer
    idle_timeout = 0 # Amount of time (in seconds) a connection can go idle before the connection is dropped
}}
## NETWORK LOAD BALANCER CONFIG ##
network = {
  network = {
    existing_subnets = [] # Updating forces new resource. Subnet IDs to associate with the network load balancer
    new_subnet_keys = [] # Updating forces new resource. Module keys that reference the subnets created below for the network load balancer
    customer_owned_ipv4_pool = "" # Customer IPv4 pool to associate with the network load balancer
    ip_address_type = "" # Type of IP address to use for the network load balancer
    enable_cross_zone_load_balancing = false # Whether or not load balancing across multiple availability zones should be enabled 
}}
## GATEWAY LOAD BALANCER CONFIG ##
gateway = {
  gateway = {
    existing_subnets = [] Updating forces new resource. Subnet IDs to associate with the gateway load balancer
    new_subnet_keys = [] # Updating forces new resource. Module keys that are reference below for the gateway load balancer
    customer_owned_ipv4_pool = "" # Customer IPv4 pool to associate with the gateway load balancer
    ip_address_type = "" # Type of IP address to use for the gateway load balancer
}}
```

### Load Balancer Subnet Mapping   

[AWS Documentation: Load Balancer Subnet Mapping Reference](https://docs.aws.amazon.com/prescriptive-guidance/latest/load-balancer-stickiness/subnets-routing.html)

[HashiCorp Terraform: Load Balancer Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)

**Use the example below to map existing or new subnets to the load balancer.**

```Terraform
## SUBNET MAPPING ##
create_subnet_mapping = false # Whether or not to create a subnet mapping for the load balancer
subnet_mapping = {
# Able to create more than one subnet mapping
  #-----------------------------------------#
  mapping_1 = {
    subnet_id = "" # Subnet ID to use in the subnet mapping
    new_subnet_key = "" # Module Key that reference the subnets created below for the subnet mapping
    allocation_id = "" # The allocation ID of the Elastic IP (EIP) address to use for the subnet mapping
    private_ipv4_address = "" # The prive IPv4 address, within the subnet, to assign to an internal facing load balancer
    ipv6_address = "" # The IPv6 address, within the subnet, to assign to the internet facing load balancer
  }
  #-----------------------------------------#
```

### Create New VPC Subnets   

[AWS Documentation: Subnet Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)    

[HashiCorp Terraform: Subnet Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)    

**Use the example below to create new subnets to be associated with the load balancer.**

```Terraform  
}
## CREATE NEW SUBNETS ##
create_new_subnets = false # Whether or not to create new subnets for the load balancer
new_subnets = {
# Able to create more than one subnet mapping
  #-----------------------------------------#
  subnet_1 = {
    subnet_name = "" # Name of the subnet
    vpc_id = "" # The VPC ID the subnet will be created in
    cidr_block = "" # The CIDR block to assign to the subnet
    availability_zone = "" # The availability zone the subnet will be created in 
    customer_owned_ipv4_pool = "" # Customer owned IPv4 pool to associate with the subnet
    assign_ipv6_address_on_creation = false # Whether or not interfaces within the subnet should be allocated an IPv6 address
    ipv6_cidr_block = "" # The IPv6 CIDR block to associate with the subnet
    map_customer_owned_ip_on_launch = false # Whether or not provisioned interfaces in the subnet should receive a public IP address
    map_public_ip_on_launch = false # Whether provisioned interfaces in the subnet should receive a public IP address
    outpost_arn = "" # ARN of the AWS outpost to associate with the subnet
    route_table_id_association = "" # Route Table ID to associate the subnet with
    tags = { "" = "", } # Tags to associate with the subnet
  }
  #-----------------------------------------#
}
```

### Create New Target Groups   

[AWS Documentation: Application Load Balancer Target Group Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html)    

[AWS Documentation: Network Load Balancer Target Group Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-target-groups.html)    

[AWS Documentation: Gateway Load Balancer Target Group Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/target-groups.html)    

[HashiCorp Terraform: Target Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)    

**Use the example below to create new target groups to be associated with the load balancer.**

```Terraform
## CREATE NEW TARGET GROUPS ##
create_lb_target_groups = false # Whether or not target groups should be created for the load balancer
vpc_id = "" # The VPC ID to create the target groups in
lb_target_groups = {
# Able to create more than one target group
  #-----------------------------------------#
  target_group_1 = {
    ## Target Group Settings ##
    name = "" # Name of the target group
    protocol = "" # Protocol the target group will accept
    port = 0 # Port the target group will accept
    target_type = "" # Type of targets associated with the target group
    app_lb_algorithm_type = "" # How the load balancer will select target when directing requests
    slow_start = 0 # 
    ## Health Check Settings ##
    health_check = {
      enabled = false # Whether health checks are enabled
      path = "" # Target destination for the health check request
      port = 0 # Port to use when perform health checks on targets
      protocol = "" # Protocol to use for the health check
      healthy_threshold = 0 # Number of consecutive health successess before cons
      interval = 0 # Amount of time (in seconds), between health checks
      matcher = "0" # Response codes to use when checking for healthy responses from targets
      timeout = 0 # Amount og time (in seconds), during which no response from a target means a failed health check
      unhealthy_threshold = 0 # Number of consecutive health check failure required before considering the target unhealthy
    }
    ## Stickiness Settings ##
    stickiness = {
      enabled = false # Whether or not cookie stickiness is enabled
      type = "" # Type of sticky session
      cookie_duration = 0 # Time period in second during which requests from the client are forwarded to the same target
    }
    ## Target Group Tags ##
    tags = { "" = "" } # Tags to associate with the target group
  }
  #-----------------------------------------#
  #-----------------------------------------#
  target_group_1 = {
    ## Target Group Settings ##
    name = "" # Name of the target group
    protocol = "" # Protocol the target group will accept
    port = 0 # Port the target group will accept
    target_type = "" # Type of targets associated with the target group
    app_lb_algorithm_type = "" # How the load balancer will select target when directing requests
    slow_start = 0 # 
    ## Health Check Settings ##
    health_check = {
      enabled = false # Whether health checks are enabled
      path = "" # Target destination for the health check request
      port = 0 # Port to use when perform health checks on targets
      protocol = "" # Protocol to use for the health check
      healthy_threshold = 0 # Number of consecutive health successess before cons
      interval = 0 # Amount of time (in seconds), between health checks
      matcher = "0" # Response codes to use when checking for healthy responses from targets
      timeout = 0 # Amount og time (in seconds), during which no response from a target means a failed health check
      unhealthy_threshold = 0 # Number of consecutive health check failure required before considering the target unhealthy
    }
    ## Stickiness Settings ##
    stickiness = {
      enabled = false # Whether or not cookie stickiness is enabled
      type = "" # Type of sticky session
      cookie_duration = 0 # Time period in second during which requests from the client are forwarded to the same target
    }
    ## Target Group Tags ##
    tags = { "" = "" } # Tags to associate with the target group
  }
  #-----------------------------------------#
}
```
### Create New Target Group Listeners

[AWS Documentation: Application Load Balancer Target Group Listener Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html)  

[AWS Documentation: Network Load Balancer Target Group Listener Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-listeners.html)   

[AWS Documentation: Network Load Balancer Target Group Listener Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/gateway-listeners.html)   

[HashiCorp Terraform: Listener Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)   

**Use the example below to create new target group listeners to be associated with target groups.**

```Terraform
## CREATE NEW TARGET GROUP LISTENERS ##
create_listeners = false # Whether or not target group listeners should be created
listeners = {
# Able to create more than one target group listener
  #-----------------------------------------#
  listener_1 = {
      ## Listener Settings ##
      port = 0 # Port for the listener
      protocol = "" # Protocol for the listener
      ## Listener SSL Certificates ##
      use_ssl_certificate = false # Whether or not to associate SSL certificates to the listener
          ssl_certificates = {
            default_certificate = {
              default_ssl_policy = "" # Defaul SSL policy to use for the default SSL certificate
              default_certificate_arn = "" # ARN of the SSL certificate to use for the listener
        }}
        use_additional_ssl_certificates = false # Whether or not to associate additional SSL certificates to the load balancer
        additional_certificates = {
            #-------------------------------#
            cert_1 = {
            # Able to associate more than one SSL certificate for the listener
              module_key = "" # Module Key to use to identify the SSL certificate within module
              listener_key = "" # Module Key of the listener to associate this SSL certificate to
              certificate_arn = "" # ARN of the certificate to use in the association
            }
            #-------------------------------#
        }
      ## Listener Default Actions ##
        default_actions = {
        # Able to create more than one Default Action
            #-------------------------------#
            action_1 = {
              type = "" # Type of default action for the listener
              values = {
              target_group_arn = "" # Target group ARN to forward traffic to.
              target_groups = {
              # Able to create more than one target group association
                  #-------------------------#
                  target_group_1 = {
                    arn = "" # ARN of the target group to associate this action to
                    weight = 0 # Ratio of traffic this target group will receive when compared to other target groups
                  }
                  #-------------------------#
                  #-------------------------#
                  target_group_2 = {
                    target_group_1 = {
                    arn = "" # ARN of the target group to associate this action to
                    weight = 0 # Ratio of traffic this target group will receive when compared to other target groups
                  }
                  #-------------------------#
                } 
              stickiness = {
                enabled = false # Whether stickiness is enabled for the target groyps specified above
                duration = 0 # Duration (in seconds), requests from the client should be forwarded to the same target group
              }
            }}}  
            #-------------------------------#
            #-------------------------------#
            action_2 = { 
              type = "redirect" # Type of default action for the listener. In this case it is "redirect"
              values = {
                status_code = "" # HTTP redirect code. "HTTP_301" (Permanent) || "HTTP_302" (Temporary) 
                host = "" # Hostname, Not percent encoded. Default == "#{host}"
                path = "" # Absolute path starting with "/". Not percent encoded. Default == "/#{path}
                port = 80 # Port. Defaul == "#{port}
                protocol = "" Protocol to use. Valid values: "HTTP" || "HTTPS" || #{protocol}. Default == "#{protocol}
                query = "" # Query parameters, do not include the leading "?". URL-encoded when necessary. Not percent encoded. Default == "#{query}" 
              }
            }
            #-------------------------------#
            #-------------------------------#
            action_3 = { 
              type = "fixed-response" # Type of default action for the listener. In this case it is "fixed-response"
              values = {
                content_type = "" # Content Type. Valid values: "text/plain" || "text/css" || text/html" || "application/javascript" || "application/json" 
                message_body = "" # Message Body
                status_code = "" # HTTP response code. Valid Values: "2XX" || "4XX" || "5XX". Where are XX are numbers
              }
            }
            #-------------------------------#
            #-------------------------------#
            action_4 = { 
              type = "authenticate-cognito" # Type of default action for the listener. In this case it is "authenticate-cognito"
              values = {
                user_pool_arn       = "" # ARN of the Cognito user pool
                user_pool_client_id = "" # ID of the Cognito user pool client
                user_pool_domain    = "" # Domain prefix || FQDN of the Cognito user pool
                session_timeout = "" # Maximum duration of authentication, in seconds
                session_cookie_name = "" # Name of the cookie used to maintain session information
                scope = [] # Set of user claims to be requested from the idP
                on_unauthenticated_request = "" # Behavior if the user is unauthenticated. Valid Values: "deny" || "allow" || "authenticate"
                authentication_request_extra_params = { 
                    "key" = "value" # Key/value query parameters to include in the redirect request. Max 10
                    }
                }
            }
            #-------------------------------#
            #-------------------------------#
            action_5 = { 
              type = "authenticate-oidc" # Type of default action for the listener. In this case it is "authenticate-oidc"
              values = {
                authorization_endpoint = "" # Authorization endpoint of the idP
                client_id              = "" # OAuth 2.0 client identifier
                client_secret          = "" # OAuth 2.0 client secret
                issuer                 = "" # OIDC issuer identifier of the idP
                token_endpoint         = "" # Token endpoint of the idP
                user_info_endpoint     = "" # User info endpoint of the idP 
              }
            }
            #-------------------------------#
    }
  #-----------------------------------------#
}
```
### Create New Listener Rules  

[AWS Documentation: Application Load Balancer Listener Rule Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/listener-update-rules.html)   

[AWS Documentation: Network Load Balancer Listener Rule Resource Reference](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/listener-update-rules.html)    

[HashiCorp Terraform: Listener Rule Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule)   

**Use the example below to create new listener rules to be associated with the listeners of a load balancer.**

```Terraform
## CREATE NEW LISTENER RULES ##
create_listener_rules = false # Whether or not to create listener rules for the target group listener
listener_rules = {
# Able to create more than one listener rule
  #-----------------------------------------#
  rule_1 = {
      ## Listener Rule Settings ##
      listener_map_key_name = ""
      priority = 0
      ## Listener Rule Actions ##
      actions = {
           #-------------------------------#
            action_1 = {
              type = "" # Type of default action for the listener
              values = {
              target_group_arn = "" # Target group ARN to forward traffic to.
              target_groups = {
              # Able to create more than one target group association
                  #-------------------------#
                  target_group_1 = {
                    arn = "" # ARN of the target group to associate this action to
                    weight = 0 # Ratio of traffic this target group will receive when compared to other target groups
                  }
                  #-------------------------#
                  #-------------------------#
                  target_group_2 = {
                    target_group_1 = {
                    arn = "" # ARN of the target group to associate this action to
                    weight = 0 # Ratio of traffic this target group will receive when compared to other target groups
                  }
                  #-------------------------#
                } 
              stickiness = {
                enabled = false # Whether stickiness is enabled for the target groyps specified above
                duration = 0 # Duration (in seconds), requests from the client should be forwarded to the same target group
              }
            }}}  
            #-------------------------------#
            #-------------------------------#
            action_2 = { 
              type = "redirect" # Type of default action for the listener. In this case it is "redirect"
              values = {
                status_code = "" # HTTP redirect code. "HTTP_301" (Permanent) || "HTTP_302" (Temporary) 
                host = "" # Hostname, Not percent encoded. Default == "#{host}"
                path = "" # Absolute path starting with "/". Not percent encoded. Default == "/#{path}
                port = 80 # Port. Defaul == "#{port}
                protocol = "" Protocol to use. Valid values: "HTTP" || "HTTPS" || #{protocol}. Default == "#{protocol}
                query = "" # Query parameters, do not include the leading "?". URL-encoded when necessary. Not percent encoded. Default == "#{query}" 
              }
            }
            #-------------------------------#
            #-------------------------------#
            action_3 = { 
              type = "fixed-response" # Type of default action for the listener. In this case it is "fixed-response"
              values = {
                content_type = "" # Content Type. Valid values: "text/plain" || "text/css" || text/html" || "application/javascript" || "application/json" 
                message_body = "" # Message Body
                status_code = "" # HTTP response code. Valid Values: "2XX" || "4XX" || "5XX". Where are XX are numbers
              }
            }
            #-------------------------------#
            #-------------------------------#
            action_4 = { 
              type = "authenticate-cognito" # Type of default action for the listener. In this case it is "authenticate-cognito"
              values = {
                user_pool_arn       = "" # ARN of the Cognito user pool
                user_pool_client_id = "" # ID of the Cognito user pool client
                user_pool_domain    = "" # Domain prefix || FQDN of the Cognito user pool
                session_timeout = "" # Maximum duration of authentication, in seconds
                session_cookie_name = "" # Name of the cookie used to maintain session information
                scope = [] # Set of user claims to be requested from the idP
                on_unauthenticated_request = "" # Behavior if the user is unauthenticated. Valid Values: "deny" || "allow" || "authenticate"
                authentication_request_extra_params = { 
                    "key" = "value" # Key/value query parameters to include in the redirect request. Max 10
                    }
                }
            }
            #-------------------------------#
            #-------------------------------#
            action_5 = { 
              type = "authenticate-oidc" # Type of default action for the listener. In this case it is "authenticate-oidc"
              values = {
                authorization_endpoint = "" # Authorization endpoint of the idP
                client_id              = "" # OAuth 2.0 client identifier
                client_secret          = "" # OAuth 2.0 client secret
                issuer                 = "" # OIDC issuer identifier of the idP
                token_endpoint         = "" # Token endpoint of the idP
                user_info_endpoint     = "" # User info endpoint of the idP 
              }
            }
            #-------------------------------#
      }
  #-----------------------------------------#
  #-----------------------------------------#
      ## Listener Rule Conditions ##
      conditions = {
            #-------------------------------#
            host_header = { 
                host_header_1 = {
                values = [] # List containing host header patterns to match
              }
            }
            #-------------------------------#
            #-------------------------------#
            http_header = { 
                header_1 = { 
                    http_header_name = "" # Name of the http header to search
                    values = [] # List of header patterns to match
                } 
            }
            #-------------------------------#
            #-------------------------------#
            query_string = {
                string_1 = { 
                    key = "" # Query string key pattern to match
                    value = "" # Query string value pattern to match
                }
            }
            #-------------------------------#
            #-------------------------------#
            http_request_method = {
                method_1 = {
                    values = [] # List of HTTP request methods or verbs to match
                }
            }
            #-------------------------------#
            path_pattern = {
                pattern_1 = {
                    values = [] # List of path patterns to match against the request URL
                }
            }
            #-------------------------------#
            #-------------------------------#
            source_ip = {
                ip_1 = {
                    values = [] # List of source IP CIDR notations to match. Can use both IPv4 and IPv6
                }
            }
            #-------------------------------#
      }}   
  #-----------------------------------------#
}
########################################################
```

### Create Security Groups   

[AWS Documentation: Security Group Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

[HashiCorp Terraform: Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)   

**Use the below example to create a security group if the above is an application load balancer. As well, this allows you to create security groups to be assocaited with instances inside the subnet mappings or security groups.**

```Terraform
###################################
## LOAD BALANCER SECURITY GROUPS ##
########################################################
create_new_security_groups = false
new_security_groups = {
# Able to create more than security group
  #-----------------------------------------#
  app_lb_security_group = {
    ## Security Group Settings ##
    name        = string # Name of security group. If "", Terraform will assign a random unigue name to the security group
    description = string # Description of the security group. If "", Terraform will auto assign the description "Managed by Terraform
    vpc_id      = string # The VPC ID where the security group will be located in 
    ## Ingress Rule Declarations ##
    ingress_rules = { 
    # Able to create more than one ingress rule
          #---------------------------------#
          rule_1 = {
            description      = string # Description of the ingress rule
            from_port        = number # Starting port of the ingress rule
            to_port          = number # Ending port of the ingress rule
            protocol         = string # Protocol for the ingress rule. If "-1" (all), from/to ports must == 0
            cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the ingress rule. If [], then cidr_blocks == null
            ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the ingress rule. If [], then ipv6_cidr_blocks == null  
            self = false  # Whether the security group itself will be added as a source to this ingress rule
          }
          #---------------------------------#
    }
    ## Egress Rule Declarations ##
    egress_rules = {  
    # Able to create more than one egress rule
          #---------------------------------#
          rule_1 = {
            description      = string # Description of the egress rule
            from_port        = number # Starting port of the egress rule
            to_port          = number # Ending port of the egress rule
            protocol         = string # Protocol for the egress rule. If "-1" (all), from/to ports must == 0
            cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the egress rule. If [], then cidr_blocks == null
            ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the egress rule. If [], then ipv6_cidr_blocks == null  
            self = false  # Whether the security group itself will be added as a source to this egress rule
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
```