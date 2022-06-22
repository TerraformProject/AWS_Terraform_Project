locals {
 
 lb_types = [ var.application, var.network, var.gateway ]

 ssl_cert = flatten( [ for listener, add_ssl in var.listeners: 
                      [ for certs, cert_vals in add_ssl.additional_certificates: {
                        module_key = cert_vals.module_key
                        listener_key = cert_vals.listener_key
                        certificate_arn = cert_vals.certificate_arn
                      } ] if add_ssl.use_additional_ssl_certificates == true && var.create_listeners == true  ] )
}
###############################
## Application Load Balancer ##
###############################

resource "aws_lb" "load_balancer" {
for_each = var.create_load_balancer == true ? element([for k, v in local.lb_types: v ], index([ "application", "network", "gateway" ], var.load_balancer_type)) : {}

  name               = var.use_name_prefix == true ? null : var.load_balancer_name
  name_prefix = var.use_name_prefix == true ? "${var.load_balancer_name}-" : null

  load_balancer_type = var.load_balancer_type
  internal           = var.internal_load_balancer
  enable_deletion_protection = var.enable_deletion_protection

  ## General Settings ##
  subnets            = concat( each.value.existing_subnets, [ for subnet_key in each.value.new_subnet_keys: aws_subnet.new_subnets[subnet_key].id ] )
  ip_address_type = each.value.ip_address_type
  customer_owned_ipv4_pool = each.value.customer_owned_ipv4_pool

  ## Application Load Balancer Settings ##
  security_groups    = var.load_balancer_type == "application" ? concat(each.value.existing_security_groups, [ for sec_grp_keys in each.value.new_security_group_keys: aws_security_group.new_security_groups[sec_grp_keys].id ] ) : null
  drop_invalid_header_fields = var.load_balancer_type == "application" ? each.value.drop_invalid_header_fields : null
  idle_timeout = var.load_balancer_type == "application" ? each.value.idle_timeout : null
  enable_http2 = var.load_balancer_type == "application" ? each.value.enable_http2 : null
   
  ## Network Load Balancer Settings ## 
  enable_cross_zone_load_balancing = var.load_balancer_type == "network" ? each.value.enable_cross_zone_load_balancing : null

  ## Gateway Load Balancer ##

    # No Specific Settings for Gateway Load Balancers
  
## Subnet Mapping ##
dynamic "subnet_mapping" {
  for_each = var.create_subnet_mapping == true ? var.subnet_mapping : {}
  content{
    subnet_id = each.value.subnet_id == "" ? aws_subnet.new_subnets[each.value.new_subnet.key].id : null
    allocation_id = each.value.allocation_id
    private_ipv4_address = each.value.private_ipv4_address
    ipv6_address = each.value.ipv6_address
  }
}

###############################################
## Application Load Balancer: S3 Access Logs ##
###############################################

  dynamic "access_logs" {
    for_each = var.create_s3_access_logs == true ? var.s3_access_logs : {}
    content{
      bucket  = each.value.bucket
      prefix  = each.value.prefix
      enabled = each.value.enable
    }
  }

  tags = merge({
    Environment = var.load_balancer_environment
  },
    var.load_balancer_tags
  )
}

###################################################
## Application Load Balancer: Create New Subnets ##
###################################################

  resource "aws_subnet" "new_subnets" {
  for_each = var.create_load_balancer == true && var.create_new_subnets == true ? var.new_subnets : {} 

  vpc_id = each.value.vpc_id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  customer_owned_ipv4_pool = each.value.customer_owned_ipv4_pool
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  ipv6_cidr_block = each.value.ipv6_cidr_block == "" ? null : each.value.ipv6_cidr_block
  map_customer_owned_ip_on_launch = each.value.map_customer_owned_ip_on_launch
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  outpost_arn = each.value.outpost_arn
  tags = merge(
    {
      "Name" = each.value.subnet_name
    },
    each.value.tags,
  )
}

    ## New Subnet route table association
    resource "aws_route_table_association" "route_table_associations" {
    for_each = var.create_load_balancer == true && var.create_new_subnets == true ? var.new_subnets : {}

      subnet_id      = aws_subnet.new_subnets[each.key].id
      route_table_id = each.value.route_table_id_association
    }

#################################
## Loadbalancer: Target Groups ##
#################################
## Get VPC ID ##

resource "aws_lb_target_group" "lb_target_groups" {
  for_each = var.create_lb_target_groups == true ? var.lb_target_groups : {}

  vpc_id   = var.vpc_id

  name     = each.value.name
  port     = each.value.port
  protocol = each.value.protocol
  target_type = each.value.target_type
  load_balancing_algorithm_type = each.value.app_lb_algorithm_type
  slow_start = each.value.slow_start
  
  health_check {
    enabled = each.value.health_check["enabled"]
    path = each.value.health_check["path"]
    port = each.value.health_check["port"]
    protocol = each.value.health_check["protocol"]
    healthy_threshold = each.value.health_check["healthy_threshold"]
    interval = each.value.health_check["interval"]
    matcher = each.value.health_check["matcher"]
    timeout = each.value.health_check["timeout"]
    unhealthy_threshold = each.value.health_check["unhealthy_threshold"]
  }
  
  stickiness {
    enabled = each.value.stickiness["enabled"]
    type = each.value.stickiness["type"]
    cookie_duration = each.value.stickiness["cookie_duration"]
  }

  tags = each.value.tags

}




####################################################
## Application Load Balancer: New Security Groups ##
####################################################

resource "aws_security_group" "new_security_groups" {
for_each = var.load_balancer_type == "application" && var.create_new_security_groups == true ? var.new_security_groups : {}

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
    description      = ingress.value.description == "" ? null : ingress.value.description
    from_port        = ingress.value.from_port  
    to_port          = ingress.value.to_port
    protocol         = ingress.value.protocol
    cidr_blocks      = ingress.value.cidr_blocks == [] ? null : ingress.value.cidr_blocks
    ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks == [] ? null : ingress.value.ipv6_cidr_blocks
    self = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
    description      = egress.value.description == "" ? null : egress.value.description
    from_port        = egress.value.from_port  
    to_port          = egress.value.to_port
    protocol         = egress.value.protocol
    cidr_blocks      = egress.value.cidr_blocks == [] ? null : egress.value.cidr_blocks
    ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks == [] ? null : egress.value.ipv6_cidr_blocks
    self = egress.value.self
    }
  }

  tags = each.value.tags
}

#####################################################
## Application Load Balancer: Listener Certificate ##
#####################################################

resource "aws_lb_listener_certificate" "https_cert" {
  for_each = { for o in local.ssl_cert: o.module_key => o } 

  listener_arn    = aws_lb_listener.lb_listener[each.value.listener_key].arn 
  certificate_arn = each.value.certificate_arn
}

##########################################
## Application Load Balancer: Listeners ##
##########################################

resource "aws_lb_listener" "lb_listener" {
for_each = var.create_load_balancer == true && var.create_listeners ? var.listeners : {}

  load_balancer_arn = aws_lb.load_balancer[var.load_balancer_type].arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = each.value.use_ssl_certificate == true ? lookup(each.value.ssl_certificates.default_certificate, "default_ssl_policy", null ) : null
  certificate_arn   = each.value.use_ssl_certificate == true ? lookup(each.value.ssl_certificates.default_certificate, "default_certificate_arn", null ) : null

  ## Listener Rule Actions ##

  dynamic "default_action" {
    for_each = toset( [ for k, v in each.value.default_actions: v if v.type == "forward" ] )
    content {
      type = default_action.value.type

      target_group_arn = default_action.value.type == "forward" && lookup(default_action.value.values, "target_groups", null ) == null ? aws_lb_target_group.lb_target_groups[lookup(default_action.value.values, "target_group_index_key", null )].arn : null 
      
      forward {
          dynamic "target_group" {
            for_each = default_action.value.type == "forward" ? lookup(default_action.value.values, "target_groups", {} ) : {} 
            content {
              arn = aws_lb_target_group.lb_target_groups[target_group.value.target_group_index_key].arn
              weight = target_group.value.weight
            }
          }
        stickiness {
            enabled = lookup(default_action.value.values, "stickiness", {} ) != {} ? lookup(default_action.value.values.stickiness, "enabled", null ) : null
            duration = lookup(default_action.value.values, "stickiness", {} ) != {} ? lookup(default_action.value.values.stickiness, "duration", null ) : 1
        }
      }
    }
  }

  dynamic "default_action" {
    for_each = toset( [ for k, v in each.value.default_actions: v if v.type == "redirect" ] )
    content {
      type = default_action.value.type
      redirect {
        status_code = default_action.value.values.status_code
        host = lookup(default_action.value.values, "host", null )
        path = lookup(default_action.value.values, "path", null )
        port = lookup(default_action.value.values, "port", null )
        protocol = lookup(default_action.value.values, "protocol", null )
        query = lookup(default_action.value.values, "query", null )
      }
    }
  }

  dynamic "default_action" {
    for_each = toset( [ for k, v in each.value.default_actions: v if v.type == "fixed-response" ] )
    content {
      type = default_action.value.type
      fixed_response {
        content_type = default_action.value.values.content_type
        message_body = lookup(default_action.value.values, "message_body", null )
        status_code = lookup(default_action.value.values, "status_code", null )
      }
    }
  }

  dynamic "default_action" {
    for_each = toset( [ for k, v in each.value.default_actions: v if v.type == "authenticate-cognito" ] )
    content {
      type = default_action.value.type
      authenticate_cognito {
        user_pool_arn       = default_action.value.values.user_pool_arn
        user_pool_client_id = default_action.value.values.user_pool_client_id
        user_pool_domain    = default_action.value.values.user_pool_domain
        session_timeout = lookup(default_action.value.values, "session_timeout", null )
        session_cookie_name = lookup(default_action.value.values, "session_cookie_name", null )
        scope = lookup(default_action.value.values, "scope", null )
        on_unauthenticated_request = lookup(default_action.value.values, "on_unauthenticated_request", null )
        authentication_request_extra_params = lookup(default_action.value.values, "authentication_request_extra_params", null )
      }
    }
  }

  dynamic "default_action" {
    for_each = toset( [ for k, v in each.value.default_actions: v if v.type == "authenticate-oidc" ] )
    content {
      type = default_action.value.type
      authenticate_oidc {
        authorization_endpoint = default_action.value.values.authorization_endpoint
        client_id              = default_action.value.values.client_id
        client_secret          = default_action.value.values.client_secret
        issuer                 = default_action.value.values.issuer
        token_endpoint         = default_action.value.values.token_endpoint
        user_info_endpoint     = default_action.value.values.user_info_endpoint
        authentication_request_extra_params = lookup(default_action.value.values, "authentication_request_extra_params", null )
        on_unauthenticated_request = lookup(default_action.value.values, "on_unauthenticated_request", null )
        scope = lookup(default_action.value.values, "scope", null )
        session_cookie_name = lookup(default_action.value.values, "session_cookie_name", null )
        session_timeout = lookup(default_action.value.values, "session_timeout", null )
      }
    }
  }
}

###############################################
## Application Load Balancer: Listener Rules ##
###############################################

resource "aws_lb_listener_rule" "this_rule" {
for_each = var.create_load_balancer == true && var.create_listeners && var.create_listener_rules == true ? var.listener_rules : {}

  listener_arn = aws_lb_listener.lb_listener[each.value.listener_map_key_name].arn
  priority     = each.value.priority

  ## Listener Rule Actions ##

  dynamic "action" {
    for_each = toset( [ for k, v in each.value.actions: v if v.type == "forward" ] )
    content {
      type = action.value.type

      target_group_arn = action.value.type == "forward" && lookup(default_action.value.values, "target_groups", null ) == null ? aws_lb_target_group.lb_target_groups[lookup(default_action.value.values, "target_group_index_key", null )].arn : null
      
      forward {
          dynamic "target_group" {
            for_each = action.value.type == "forward" ? lookup(action.value.values, "target_groups", {} ) : {}
            content {
              arn = aws_lb_target_group.lb_target_groups[target_group.value.target_group_index_key].arn
              weight = target_group.value.weight
            }
          }
        stickiness {
            enabled = lookup(action.value.values, "stickiness", {} ) != {} ? lookup(action.value.values.stickiness, "enabled", null ) : null
            duration = lookup(action.value.values, "stickiness", {} ) != {} ? lookup(action.value.values.stickiness, "duration", null ) : 1
        }
      }
    }
  }

  dynamic "action" {
    for_each = toset( [ for k, v in each.value.actions: v if v.type == "redirect" ] )
    content {
      type = action.value.type
      redirect {
        status_code = action.value.values.status_code
        host = lookup(action.value.values, "host", null )
        path = lookup(action.value.values, "path", null )
        port = lookup(action.value.values, "port", null )
        protocol = lookup(action.value.values, "protocol", null )
        query = lookup(action.value.values, "query", null )
      }
    }
  }

  dynamic "action" {
    for_each = toset( [ for k, v in each.value.actions: v if v.type == "fixed-response" ] )
    content {
      type = action.value.type
      fixed_response {
        content_type = action.value.values.content_type
        message_body = lookup(action.value.values, "message_body", null )
        status_code = lookup(action.value.values, "status_code", null )
      }
    }
  }

  dynamic "action" {
    for_each = toset( [ for k, v in each.value.actions: v if v.type == "authenticate-cognito" ] )
    content {
      type = action.value.type
      authenticate_cognito {
        user_pool_arn       = action.value.values.user_pool_arn
        user_pool_client_id = action.value.values.user_pool_client_id
        user_pool_domain    = action.value.values.user_pool_domain
        session_timeout = lookup(action.value.values, "session_timeout", null )
        session_cookie_name = lookup(action.value.values, "session_cookie_name", null )
        scope = lookup(action.value.values, "scope", null )
        on_unauthenticated_request = lookup(action.value.values, "on_unauthenticated_request", null )
        authentication_request_extra_params = lookup(action.value.values, "authentication_request_extra_params", null )
      }
    }
  }

  dynamic "action" {
    for_each = toset( [ for k, v in each.value.actions: v if v.type == "authenticate-oidc" ] )
    content {
      type = action.value.type
      authenticate_oidc {
        authorization_endpoint = action.value.values.authorization_endpoint
        client_id              = action.value.values.client_id
        client_secret          = action.value.values.client_secret
        issuer                 = action.value.values.issuer
        token_endpoint         = action.value.values.token_endpoint
        user_info_endpoint     = action.value.values.user_info_endpoint
        authentication_request_extra_params = lookup(action.value.values, "authentication_request_extra_params", null )
        on_unauthenticated_request = lookup(action.value.values, "on_unauthenticated_request", null )
        scope = lookup(action.value.values, "scope", null )
        session_cookie_name = lookup(action.value.values, "session_cookie_name", null )
        session_timeout = lookup(action.value.values, "session_timeout", null )
      }
    }
  }

  ## Listener Rule Conditions ##
 
  dynamic "condition" {
    for_each = lookup(each.value.conditions, "host_header", {} )
    content {
      dynamic "host_header" {
        for_each = each.value.conditions.host_header
        content { 
          values = host_header.value.values
        }
      }
    }
  }
    dynamic "condition" {
    for_each = lookup(each.value.conditions, "http_header", {} )
    content {
      http_header {
          http_header_name = condition.value.http_header_name
          values           = condition.value.values
      }
    }
  }
    dynamic "condition" {
      for_each = lookup(each.value.conditions, "query_string", {} )
      content {
        query_string {
            key = condition.value.key
            value = condition.value.value
        }
      }
    }
    dynamic "condition" {
    for_each = lookup(each.value.conditions, "http_request_method", {} )
    content {
      dynamic "http_request_method" {
        for_each = each.value.conditions.http_request_method
        content { 
          values = http_request_method.value.values
        }
      }
    }
  }
  dynamic "condition" {
    for_each = lookup(each.value.conditions, "path_pattern", {} )
    content {
      dynamic "path_pattern" {
        for_each = each.value.conditions.path_pattern
        content { 
          values = path_pattern.value.values
        }
      }
    }
  }
  dynamic "condition" {
    for_each = lookup(each.value.conditions, "source_ip", {} )
    content {
      dynamic "source_ip" {
        for_each = each.value.conditions.source_ip
        content { 
          values = source_ip.value.values
        }
      }
    }
  }

  

  
}


      


      
      



