locals {

    # Get Origin to iterate #
    origins = flatten( [ for origin, origin_vals in var.cloudfront_origins: origin_vals ]  )

    # Get new origin access identity #
    access_id = flatten( [ for origins, origin_vals in var.cloudfront_origins: origin_vals.s3_origin_config.s3_values if origin_vals.use_s3_origin_config == true ] )

    # Get S3 Origin config to iterate #
    s3_origins = flatten( [ for origins, origin_vals in var.cloudfront_origins: origin_vals.s3_origin_config if origin_vals.use_s3_origin_config == true ] )

    # Get Custom Origins to iterate #
    custom_origins = flatten( [ for origins, origin_vals in var.cloudfront_origins: origin_vals.custom_origin_config if origin_vals.use_custom_origin_config == true ] )

    # Get Default Behavior Lambda Function #
    default_behavior_new_lambda_function = flatten( [ for lambda_function, function_vals in var.default_cache_behavior_config["lambda_function_associations"]: function_vals.new_lambda_function if var.default_cache_behavior_config["create_lambda_function_associations"] == true && function_vals.new_lambda_function.enabled == true ] )

    # Get Default Behavior New Cloudfront Function to iterate #
    default_behavior_new_function = flatten( [ for functions, function_vals in var.default_cache_behavior_config["cloudfront_function_associations"]: function_vals.new_cloudfront_function if var.default_cache_behavior_config["create_cloudfront_function_associations"] == true && function_vals.new_cloudfront_function.enabled == true ] )

    # Get Ordered Behavior New Lambda Function to iterate #
    ordered_behavior_new_lambda = flatten( [ for behaviors, behavior_vals in var.ordered_cache_behaviors: 
                                                [ for function, function_vals in behavior_vals.lambda_function_associations: function_vals.new_lambda_function if function_vals.new_lambda_function.enabled == true ]
                                                 if behavior_vals.create_lambda_function_associations == true ] )

    # Get ordered Behavior New Cloudfront Function to iterate #
    ordered_behavior_new_function = flatten( [ for behavior, behavior_vals in var.ordered_cache_behaviors: 
                                                [ for function, function_vals in behavior_vals.function_associations: function_vals.new_cloudfront_function if function_vals.new_cloudfront_function.enabled == true ] 
                                            if behavior_vals.create_function_associations == true ] )
}


#############################
## Cloudfront Distribution ##
#############################

resource "aws_cloudfront_origin_access_identity" "access_id" {
  for_each = { for o in local.access_id: o.new_origin_access_identity.comment => o if o.new_origin_access_identity.enabled == true }

  comment = each.value.new_origin_access_identity.comment
}

resource "aws_cloudfront_distribution" "s3_distribution" {
count = var.create_cloudfront_distribution == true ? 1 : 0

  ## Cloudfront Settings ##
  enabled = var.enable_distribution
  price_class = var.price_class
  aliases = var.aliases
  http_version = var.http_version
  is_ipv6_enabled = var.is_ipv6_enabled
  retain_on_delete = var.retain_on_delete
  wait_for_deployment = var.wait_for_deployment

  ## Origin Settings ##
  dynamic "origin" {
      for_each = { for o in local.origins: o.origin_id => o }
      content {
        domain_name = origin.value.domain_name
        origin_id   = origin.value.origin_id
        connection_attempts = origin.value.connection_attempts
        connection_timeout = origin.value.connection_timeout
        origin_path = origin.value.origin_path

        # Origin Shield Config #
        dynamic "origin_shield" {
            for_each = origin.value.enable_origin_shield == true ? origin.value.origin_shield : {}
            content {
                enabled = origin.value.enable_origin_shield
                origin_shield_region = origin.value.origin_shield.origin_shield_region
            }
        }

        # S3 Origin Config #
        dynamic "s3_origin_config" {
        for_each = origin.value.use_s3_origin_config == true ? origin.value.s3_origin_config : {}
            content {
                origin_access_identity = s3_origin_config.value.new_origin_access_identity.enabled == true ? aws_cloudfront_origin_access_identity.access_id[s3_origin_config.value.new_origin_access_identity.comment].cloudfront_access_identity_path : s3_origin_config.value.origin_access_identity
            }
        }

        # Custom Origin Config #
        dynamic "custom_origin_config" {
            for_each = origin.value.use_custom_origin_config == true ? origin.value.custom_origin_config : {}
                content {
                    http_port = custom_origin_config.value.http_port
                    https_port = custom_origin_config.value.https_port
                    origin_protocol_policy = custom_origin_config.value.origin_protocol_policy
                    origin_ssl_protocols = custom_origin_config.value.origin_ssl_protocols
                    origin_read_timeout = custom_origin_config.value.origin_read_timeout
                    origin_keepalive_timeout = custom_origin_config.value.origin_keepalive_timeout
                }
            }
        }
    }

    ## Origin Group Config ##
    dynamic "origin_group" {
        for_each = var.create_origin_group == true ? var.origin_group_config : {}
        content {
            origin_id = origin_group.value.origin_group_id
            failover_criteria {
                status_codes = origin_group.value.failover_status_codes
            }
            dynamic "member" {
                for_each = origin_group.value.member_origin_ids
                content {
                    origin_id = member.value
                }
            }
        }
    }

    ## Default Cache Behavior ##
    default_cache_behavior {
            # Forwarding Rules #
            target_origin_id = var.default_cache_behavior_config["target_origin_id"]
            allowed_methods = var.default_cache_behavior_config["allowed_methods"]
            cached_methods = var.default_cache_behavior_config["cached_methods"]
            compress = var.default_cache_behavior_config["compress"]
            smooth_streaming = var.default_cache_behavior_config["smooth_streaming"]
            default_ttl = var.default_cache_behavior_config["default_ttl"]
            max_ttl = var.default_cache_behavior_config["max_ttl"]
            min_ttl = var.default_cache_behavior_config["min_ttl"]

            dynamic "forwarded_values" {
                for_each = var.default_cache_behavior_config["create_forwarded_values"] == true ? var.default_cache_behavior_config["forwarded_values"] : {}
                content {
                    query_string = forwarded_values.value.query_string
                    query_string_cache_keys = forwarded_values.value.query_string_cache_keys
                    headers = forwarded_values.value.headers
                    cookies {
                        forward = forwarded_values.value.cookies.forward
                        whitelisted_names = forwarded_values.value.cookies.whitelist_names
                    }
                }
            }

            # Security #
            cache_policy_id = var.default_cache_behavior_config["cache_policy_id"]
            viewer_protocol_policy = var.default_cache_behavior_config["viewer_protocol_policy"]
            field_level_encryption_id = var.default_cache_behavior_config["field_level_encryption_id"]
            origin_request_policy_id = var.default_cache_behavior_config["origin_request_policy_id"]
            trusted_signers = var.default_cache_behavior_config["trusted_signers"]
            trusted_key_groups = var.default_cache_behavior_config["trusted_key_groups"]
            # Real Time Logging #
            realtime_log_config_arn = var.default_cache_behavior_config["realtime_log_config_arn"]
            # Lambda Function Associations #
            dynamic "lambda_function_association" {
                for_each = var.default_cache_behavior_config["create_lambda_function_associations"] == true ? var.default_cache_behavior_config["lambda_function_associations"] : {}
                content {
                    event_type = lambda_function_association.value.event_type
                    include_body = lambda_function_association.value.include_body
                    lambda_arn = lambda_function_association.value.new_lambda_function.enabled == true ? aws_lambda_function.default_behavior_cloudfront_lambda[lambda_function_association.value.new_lambda_function.function_name].arn : lambda_function_association.value.lambda_arn
                }
            }
            # Function Associations #
            dynamic "function_association" {
                for_each = var.default_cache_behavior_config["create_cloudfront_function_associations"] == true ? var.default_cache_behavior_config["cloudfront_function_associations"] : {}
                content {
                    event_type = function_association.value.event_type
                    function_arn = function_association.value.new_cloudfront_function.enabled == true ? aws_cloudfront_function.default_behavior_function[function_association.value.new_cloudfront_function.name].arn : function_association.value.function_arn
                }
            }
        
    }

    # Ordered Cache Behavior #
    dynamic "ordered_cache_behavior" {
        for_each = var.create_ordered_cache_behaviors == true ? var.ordered_cache_behaviors : {}
        content {
            # Path Pattern #
            path_pattern = ordered_cache_behavior.value.path_pattern
            # Forwarding Rules #
            target_origin_id = ordered_cache_behavior.value.target_origin_id
            allowed_methods = ordered_cache_behavior.value.allowed_methods
            cached_methods = ordered_cache_behavior.value.cached_methods
            compress = ordered_cache_behavior.value.compress
            smooth_streaming = ordered_cache_behavior.value.smooth_streaming
            default_ttl = ordered_cache_behavior.value.default_ttl
            max_ttl = ordered_cache_behavior.value.max_ttl
            min_ttl = ordered_cache_behavior.value.min_ttl

            dynamic "forwarded_values" {
                for_each = ordered_cache_behavior.value.create_forwarded_values == true ? ordered_cache_behavior.value.forwarded_values : {}
                content {
                    query_string = forwarded_values.value.query_string
                    query_string_cache_keys = forwarded_values.value.query_string_cache_keys
                    headers = forwarded_values.value.headers
                    cookies {
                        forward = forwarded_values.value.cookies.forward
                        whitelisted_names = forwarded_values.value.cookies.whitelist_names
                    }
                }
            }

            # Security #
            cache_policy_id = ordered_cache_behavior.value.cache_policy_id
            viewer_protocol_policy = ordered_cache_behavior.value.viewer_protocol_policy
            field_level_encryption_id = ordered_cache_behavior.value.field_level_encryption_id
            origin_request_policy_id = ordered_cache_behavior.value.origin_request_policy_id
            trusted_signers = ordered_cache_behavior.value.trusted_signers
            trusted_key_groups = ordered_cache_behavior.value.trusted_key_groups
            # Real Time Logging #
            realtime_log_config_arn = ordered_cache_behavior.value.realtime_log_config_arn
            # Lambda Function Associations #
            dynamic "lambda_function_association" {
                for_each = ordered_cache_behavior.value.create_lambda_function_associations == true ? ordered_cache_behavior.value.lambda_function_associations : {}
                content {
                    event_type = lambda_function_association.value.event_type
                    include_body = lambda_function_association.value.include_body
                    lambda_arn = lambda_function_association.value.new_lambda_function.enabled == true ? aws_lambda_function.ordered_behavior_cloudfront_lambda[lambda_function_association.value.new_lambda_function.function_name].arn : lambda_function_association.value.lambda_arn
                }
            }
            # Function Associations #
            dynamic "function_association" {
                for_each = ordered_cache_behavior.value.create_function_associations == true ? ordered_cache_behavior.value.function_associations : {}
                content {
                    event_type = function_association.value.event_type
                    function_arn = function_association.value.new_cloudfront_function.enabled == true ? aws_cloudfront_function.ordered_behavior_function[function_association.value.new_cloudfront_function.name].arn : function_association.value.function_arn
                }
            }
        }
    }

    ## Custom Error Responses ##
    dynamic "custom_error_response" {
        for_each = var.create_custom_error_responses == true ? var.custom_error_responses : {}
        content {
            error_code = custom_error_response.value.error_code
            error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
            response_code = custom_error_response.value.response_code
            response_page_path = custom_error_response.value.response_page_path
        }
    }

    ## Cache/Cookie Logging ##
    dynamic "logging_config" {
        for_each = var.enable_logging_config == true ? var.logging_config : {}
        content {
            bucket = logging_config.value.bucket
            prefix = logging_config.value.included_cache_prefix
            include_cookies = logging_config.value.include_cookies
        }
    }

    ## Security ##

        # Web ACL #
        web_acl_id = var.wafv2_web_acl_arn == "" ? var.waf_web_acl_id : var.wafv2_web_acl_arn

        # Viewer Certificates #
        dynamic "viewer_certificate" {
            for_each = var.viewer_https_cert 
            content {
                cloudfront_default_certificate = viewer_certificate.value.cloudfront_default_certificate
                acm_certificate_arn = viewer_certificate.value.acm_certificate_arn
                iam_certificate_id = viewer_certificate.value.iam_certificate_id
                minimum_protocol_version = viewer_certificate.value.minimum_protocol_version
                ssl_support_method = viewer_certificate.value.ssl_support_method
            }
        }

        ## Restricitions ##
        dynamic "restrictions" {
            for_each = var.geo_restrictions 
            content {
                geo_restriction {
                    locations = restrictions.value.locations
                    restriction_type = restrictions.value.restriction_type
                }
            }
        }

    ## Cloudfront Tags ##
    tags = var.cloudfront_tags

  }

###########################################
## Cloudfront Functions Default Behavior ##
###########################################
resource "aws_cloudfront_function" "default_behavior_function" {
for_each = { for o in local.default_behavior_new_function: o.name => o }

  name    = each.value.name
  runtime = each.value.runtime
  comment = each.value.comment
  publish = true
  code    = file(each.value.function_local_path)
}

#################################################
## Cloudfront Lambda Function Default Behavior ##
#################################################
resource "aws_lambda_function" "default_behavior_cloudfront_lambda" {
    for_each = { for o in local.default_behavior_new_lambda_function: o.function_name => o }

    function_name = each.value.function_name
    role = each.value.role_arn
    handler = each.value.handler
    runtime = each.value.runtime
    filename = each.value.function_local_path

    tags = each.value.tags
}
  
##########################################
## Cloudfront Function Ordered Behavior ##
##########################################
resource "aws_cloudfront_function" "ordered_behavior_function" {
for_each = { for o in local.ordered_behavior_new_function: o.name => o }

  name    = each.value.name
  runtime = each.value.runtime
  comment = each.value.comment
  publish = true
  code    = file(each.value.function_local_path)
}



#################################################
## Cloudfront Lambda Function Ordered Behavior ##
################################################# 
resource "aws_lambda_function" "ordered_behavior_cloudfront_lambda" {
    for_each = { for o in local.ordered_behavior_new_lambda: o.function_name => o }

    function_name = each.value.function_name
    role = each.value.role_arn
    handler = each.value.handler
    runtime = each.value.runtime
    filename = each.value.function_local_path

    tags = each.value.tags
}