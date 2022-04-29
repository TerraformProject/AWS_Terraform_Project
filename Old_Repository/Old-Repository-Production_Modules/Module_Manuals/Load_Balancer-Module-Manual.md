# Load Balancer Module

## Load Balancer

This section of the module allows you to create:

```
    1 - Load Balancer
        1a - Allows you to create application load balancer.
            1aa - Specify application load balancer settings.
            1ab - Associate existing security groups with the load balancer.
            1ac - Create new security groups to associate with the load balancer.
        1b - Allows you to create a network load balancer.
            1ba - Specify network load balancer settings.
        1c - Allows you to create a gateway load balancer.
            1ca - Specify gateway load balancer settings
        1d - Allows you to create new subnets for the load balancer.
            1da - Specify new subnet settings. 
            1db - Associate new subnet with the load balancer.
            1dc - Associate new subnet with a route table.
        1e - Allows you to create a subnet mappings for the load balancer.
            1ea - Specify subnet mapping settings.
        1f - Allows you to create S3 access logs.
            1fa - Specify settings for S3 access logs.
        1g - Allows you to associate tags with the load balancer.
```

Use the example below as a reference to create a load balancer:

[Load Balancer Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)

[Subnets Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

[Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

```terraform

create_load_balancer = false # Whether to create a load balancer 

  load_balancer_name = "" # Name for the load balancer
  use_name_prefix = false # Whether to use a name prefix for the load balancer
  load_balancer_environment = "" # The environmnet tag to be merged with the load balancer tags below 

  load_balancer_type = "" # Type of load balancer to create. "application" || "network" || "gateway" 
  internal_load_balancer = false # Whether the load balancer is private or public
  enable_deletion_protection = false # Whether deletion protection should be enabled for the load balancer

## Application Load Balancer ##
  application = {
    application = {
      existing_subnets = [] # Subnet ID of existing subnets to associate with application load balancer
      new_subnet_keys = [] # Keys that reference the newly created subnets below for the application load balancer 
      existing_security_groups = [] # Existing security groups for the application load balancer
      new_security_group_keys = [] # Keys that reference the newly created security groups from below for the application load balancer 
      ip_address_type = "" # Type of ip address to use for the application load balancer. "ipv4" || "dualstack"
      customer_owned_ipv4_pool = "" # Customer owned ipv4 pool to use for the application load balancer
      enable_http2 = false # Whether to enable http2 for the application load balancer
      drop_invalid_header_fields = false # Whether to drop invalid header fields when passing through the application load balancer
      idle_timeout = 60 # Amount of time (in seconds) a connection can go idle before the connection is dropped
    }
  }
  ## New Security Groups ##
    create_new_security_groups = false # Whether to create new security groups. See new_security_group_keys to associate with application load balancer
    new_security_groups = {

    # Able to create multiple security groups. Copy and paste the reference below.

      security_group_1 = { # Key for the security group. Must be unique. Terraform does not process duplicates.
        name        = "" # Name for the security group
        description = "" # Description for the security group 
        vpc_id      = "" # VPC ID where the security group will be located in 

        ingress_rules = { 
          rule_1 = { # Key for the ingress rule. Must be unique. Terraform does not process duplicates.
            description      = "" # Description for the ingress rule 
            from_port        = 0 # Starting port for the ingress rule
            to_port          = 0 # Ending port for the security group
            protocol         = "-1" # Protocol for the ingress rule. If "-1" (All), from/to ports must == 0
            cidr_blocks      = [] # ipv4 CIDR blocks to receive inbound traffic from
            ipv6_cidr_blocks = [] # ipv6 CIDR blocks to receive inbound traffic from   
            self = false # Whether the ingress rule should reference the security group itself
            }
          }

        egress_rules = {  
          rule_1 = { # Key for the egress rule. Must be unique. Terraform does not process duplicates.
            description      = "" # Description for the egress rule 
            from_port        = 0 # Starting port for the egress rule
            to_port          = 0 # Ending port for the security group
            protocol         = "-1" # Protocol for the egress rule. If "-1" (All), from/to ports must == 0
            cidr_blocks      = [] # ipv4 CIDR blocks to send outbound traffic to
            ipv6_cidr_blocks = [] # ipv6 CIDR blocks to send outbound traffic to   
            self = false # Whether the egress rule should reference the security group itself
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
      existing_subnets = [] # Updateing forces new resource. Subnet IDs to associate with the network load balancer
      new_subnet_keys = [] # Updateing forces new resource. Subnet IDs to associate with the network load balancer
      customer_owned_ipv4_pool = "" # Customer IPv4 pool to associate with the network load balancer
      ip_address_type = "" # Type of ip address to use for the application load balancer. "ipv4" || "dualstack"
      enable_cross_zone_load_balancing = false # Whether load balancing across multiple availablity zones is enabled 
    }
  }
## Gateway Load Balancer ##
  gateway = {
    gateway = {
      existing_subnets = [] # Updateing forces new resource. Subnet IDs to associate with the network load balancer
      new_subnet_keys = [] # Updating force new resource. # Keys that reference the newly created subnets below for the application load balancer
      customer_owned_ipv4_pool = "" # Customer IPv4 pool to associate with the network load balancer
      ip_address_type = "ipv4" # Type of ip address to use for the application load balancer. "ipv4" || "dualstack"
    }
  }

## Create New Subnets ##
  create_new_subnets = false # Whether to create new subnets for the load balancer. See new_subnet_keys to associate 
  new_subnets = {

    # Able to create multiple subnets. Copy and paste the reference below.

    subnet_1 = { # Key for the subnet. Must be unique. Terraform does not process duplicates.
      subnet_name = "" # Name of the subnet 
      vpc_id = "" # VPC ID the subnet will be created in 
      cidr_block = "" # CIDR block to associate with the subnet
      availability_zone = "" # The availablity zone the subnet will be located in 
      customer_owned_ipv4_pool = "" # Customer owned ipv4 pool to associate with the subnet
      assign_ipv6_address_on_creation = false # Whether interfaces within the subnet should be allocated an ipv6 address
      ipv6_cidr_block = "" # ipv6 CIDR block to associate with the subnet
      map_customer_owned_ip_on_launch = false # Whether provisioned interfaces in the subnet should receive an ipv4 address from the customer owned ipv4 pool
      map_public_ip_on_launch = false # Whether provisioned interface in the subnet should receive a public IP address 
      outpost_arn = "" # ARN of the outpost to associate with the subnet

      route_table_id_association = "" # Route table ID to associate the subnet with

      tags = {
          "Key" = "Value" # Tags to associate with the subnet
      }
    }

  }

## Subnet Mapping ##
  create_subnet_mapping = false # Whether to create subnet mappings for the load balancer
  subnet_mapping = {

    # Able to create multiple subnet mappings. Copy and paste the reference below.

      mapping_1 = { # Key for the subnet mapping. Must be unique. Terraform does not process duplicates.
        subnet_id = "" # Subnet ID to use in the subnet mapping. Conflicts with new_subnet_key
        new_subnet_key = "" # Subnet key from above to reference the subnet for the subnet mapping. Conflicts with subnet_id
        allocation_id = "" # The allocation id of the Elastic IP (EIP) address to use for the subnet mapping
        private_ipv4_address = "" # The private IPv4 address, within the subnet, to assign to the internal facing load balancer
        ipv6_address = "" # The IPv6 address, within the subnet, to assign to the internet facing load balancer
      }

    }

## Access Logs ##
  create_s3_access_logs = false # Whether to create a S3 access logs for the load balancer
  s3_access_logs = {
    values = {
      bucket = "" # S3 Bucket name to store the access logs in
      prefix = "" # S3 bucket prefix. Logs are stored in the root (/) if not configured
      enable = false # Whether to enable access logs for the load balancer
    }
  }

## Tags ##
  load_balancer_tags = {
    "key" = "value" # Tags to associate with the load balancer
  }

```

## Load Balancer Listeners

This section of the module allows you to create:

```
    2 - Listener
        2a - Specify listener port and protocol.
        2b - Specify listener SSL certificates.
            2ba - Specify default listener certificate.
            2bb - Add additional SSL certificates.
        2c - Create one or more default actions.
            2ca - Create forward default action.
            2cb - Create redirect default action.
            2cc - Create fixed-response default action.
            2cd - Create authenticate-cognito default action.
            2ce - Create authenticate-oidc default action.
        2d - Automatically associates listener with the load balancer above.
```

Use the example below as reference to create one or more listeners for the load balancer above:

[Load Balancer Listener Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)

[Listener SSL Certificate Association Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate)

```terraform

create_listeners = false # Whether to create listeners for the load balancer
listeners = {

  ## Abled to create multiple listeners. Copy and paste example below

  listener_1 = { # Key for the listener. Must be unique. Terraform does not process duplicates

    ## Listener Settings ##
      port = 80 # Port for listener
      protocol = "" # Protocol to use for the listener

    ## Listener SSL Certificates ##
      use_ssl_certificate = false # Whether to use SSL certificates for the load balancer 
        ssl_certificates = {
            
          default_certificate = {
            default_ssl_policy = "" # Default SSL policy to use for the default SSL certificate
            default_certificate_arn = "" # ARN of the SSL certificate to use for the listener
          }
        }

      use_additional_ssl_certificates = false # Whether to add additional SSL certificates to the load balancer 
        additional_certificates = {

        # Able to associate multiple SSL certificates. Copy and paste the reference below.

          cert_1 = { # Key for the SSL certificate. Must be unique. Terraform does not process duplicates.
            module_key = "1" # Key for module reference. Must be unique. Terraform does not process duplicates
            listener_key = "" # Key of this listener for module reference. 
            certificate_arn = "" # ARN of the SSL certificate to use for the listener
          }

        }

    ## Listener Default Actions ##
      default_actions = { # Default actions for the listener. 

      ## Able to create multiple default actions. Copy and paste desired actions from below

        action_1 = { # Key for the default action. Must be unique. Terraform does not process duplicates.
          type = "forward" # Type of default action for the listener. In this case it is "forward"
          values = {

            target_group_arn = "" # Target group ARN to forward traffic to.

            target_groups = { # Target group to associate with the listener

              # Abled to specify multiple target groups. Copy and paste the reference below

              target_group_1 = { # Key for the target group. Must be unique. Terraform does not process duplicates.
                arn = "" ARN of the target group to associate with the load balancer
                weight = 100 # Distribution of network traffic amongst the other target groups 
              }
            } 

            stickiness = {
              enabled = true # Whether stickiness is enabled for the target groups specified above
              duration = 888 # Duration (in seconds), requests from a client should be forwarded to the same target group
            }

            ## IF BOTH target_group_arn AND target_groups ARE SPECIFIED, target_groups MUST CONTAIN A VALUE THAT IS EXACTLY 
            ## EQUAL TO target_group_arn 

          }
        }  

        action_2 = { # Key for the default action. Must be unique. Terraform does not process duplicates.
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

        action_3 = { # Key for the default action. Must be unique. Terraform does not process duplicates.
          type = "fixed-response" # Type of default action for the listener. In this case it is "fixed-response"
          values = {
            content_type = "" # Content Type. Valid values: "text/plain" || "text/css" || text/html" || "application/javascript" || "application/json" 
            message_body = "" # Message Body
            status_code = "" # HTTP response code. Valid Values: "2XX" || "4XX" || "5XX". Where are XX are numbers
          }
        }

        action_4 = { # Key for the default action. Must be unique. Terraform does not process duplicates.
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

        action_5 = { # Key for the default action. Must be unique. Terraform does not process duplicates.
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

      }
    }

}

```

## Load Balancer Listener Rules

This section of the module allows you to create:

```
    3 - Listener Rule
        3a - Specify listener rule port and listener to associate with.
        3b - Create one or more default actions.
            3ba - Create forward default action.
            3bb - Create redirect default action.
            3bc - Create fixed-response default action.
            3bd - Create authenticate-cognito default action.
            3be - Create authenticate-oidc default action.
        3c - Create one or more rule conditions.
            3ca - Create host_header condition
            3cb - Create http_header condition
            3cc = Create query_string condition
            3cd - Create http_request_method condtion
            3ce - Create path_pattern condition
            3cf - Create ip_source condition
```

Use the example below as reference to create one or more listener rules to associate with the listeners above:

[Listener Rule Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule)

```terraform
create_listener_rules = false # Whether to create listener rules for the listeners above
listener_rules = {

rule_1 = {
    listener_map_key_name = "listener_1"
    priority = 100

    actions = { # Actions for the listener. 

      ## Able to create multiple actions. Copy and paste desired actions from below

        action_1 = { # Key for the action. Must be unique. Terraform does not process duplicates.
          type = "forward" # Type of action for the listener. In this case it is "forward"
          values = {

            target_group_arn = "" # Target group ARN to forward traffic to.

            target_groups = { # Target group to associate with the listener

              # Abled to specify multiple target groups. Copy and paste the reference below

              target_group_1 = { # Key for the target group. Must be unique. Terraform does not process duplicates.
                arn = "" ARN of the target group to associate with the load balancer
                weight = 100 # Distribution of network traffic amongst the other target groups 
              }
            } 

            stickiness = {
              enabled = true # Whether stickiness is enabled for the target groups specified above
              duration = 888 # Duration (in seconds), requests from a client should be forwarded to the same target group
            }

            ## IF BOTH target_group_arn AND target_groups ARE SPECIFIED, target_groups MUST CONTAIN A VALUE THAT IS EXACTLY 
            ## EQUAL TO target_group_arn 

          }
        }  

        action_2 = { # Key for the action. Must be unique. Terraform does not process duplicates.
          type = "redirect" # Type of action for the listener. In this case it is "redirect"
          values = {
            status_code = "" # HTTP redirect code. "HTTP_301" (Permanent) || "HTTP_302" (Temporary) 
            host = "" # Hostname, Not percent encoded. Default == "#{host}"
            path = "" # Absolute path starting with "/". Not percent encoded. Default == "/#{path}
            port = 80 # Port. Defaul == "#{port}
            protocol = "" Protocol to use. Valid values: "HTTP" || "HTTPS" || #{protocol}. Default == "#{protocol}
            query = "" # Query parameters, do not include the leading "?". URL-encoded when necessary. Not percent encoded. Default == "#{query}" 
          }
        }

        action_3 = { # Key for the action. Must be unique. Terraform does not process duplicates.
          type = "fixed-response" # Type of action for the listener. In this case it is "fixed-response"
          values = {
            content_type = "" # Content Type. Valid values: "text/plain" || "text/css" || text/html" || "application/javascript" || "application/json" 
            message_body = "" # Message Body
            status_code = "" # HTTP response code. Valid Values: "2XX" || "4XX" || "5XX". Where are XX are numbers
          }
        }

        action_4 = { # Key for the action. Must be unique. Terraform does not process duplicates.
          type = "authenticate-cognito" # Type of action for the listener. In this case it is "authenticate-cognito"
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

        action_5 = { # Key for the action. Must be unique. Terraform does not process duplicates.
          type = "authenticate-oidc" # Type of action for the listener. In this case it is "authenticate-oidc"
          values = {
            authorization_endpoint = "" # Authorization endpoint of the idP
            client_id              = "" # OAuth 2.0 client identifier
            client_secret          = "" # OAuth 2.0 client secret
            issuer                 = "" # OIDC issuer identifier of the idP
            token_endpoint         = "" # Token endpoint of the idP
            user_info_endpoint     = "" # User info endpoint of the idP 
          }
        }
      }
    }

    ## Listener Rule Conditions ##
    conditions = {

      host_header = { 
        host_header_1 = {
          values = [] # List containing host header patterns to match
        }
      }

      http_header = { 

        # Able to create more than one http_header. Copy and post from below.

        header_1 = { # Key of http_header. Must be unique. Terraform does not process duplicates
          http_header_name = "" # Name of the http header to search
          values = [] # List of header patterns to match
        }
        
      }

      query_string = {

        # Able to create more than one http_header. Copy and post from below.

        string_1 = { # Key of the query_string. Must be unique. Terraform does not process duplicates
          key = "" # Query string key pattern to match
          value = "" # Query string value pattern to match
        }

      }

      http_request_method = {
        method_1 ={
          values = [] # List of HTTP request methods or verbs to match
        }
      }

      path_pattern = {
        pattern_1 = {
          values = [] # List of path patterns to match against the request URL
        }
      }

      source_ip = {
        ip_1 = {
          values = [] # List of source IP CIDR notations to match. Can use both IPv4 and IPv6
        }
      }
    }

}

```
