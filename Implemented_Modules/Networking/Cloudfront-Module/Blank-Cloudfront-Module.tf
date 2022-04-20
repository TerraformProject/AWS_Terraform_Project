module "Blank_CLOUDFRONT" {
    source = ""
    
#############################
## CLOUDFRONT DISTRIBUTION ##
####################################################
#- Cloudfront Settings----------------------#
create_cloudfront_distribution = false
enable_distribution = false
distribution_comment = ""
price_class = ""
aliases = []
default_root_object = ""
http_version = ""
is_ipv6_enabled = false
retain_on_delete = false
wait_for_deployment = false
#-------------------------------------------#

#- Cloudfront Tags -------------------------#
cloudfront_tags = {
    "key" = "value"
}
#-------------------------------------------#
####################################################


########################
## CLOUDFRONT ORIGINS ##
####################################################
#- Origin Group Config ---------------------#
create_origin_group = false
origin_group_config = {
  config = {
    origin_group_id = ""
    failover_status_codes = []
    member_origin_ids = [""] # First ID is primary origin
}}
#-------------------------------------------#
  

#- Create New Origins ----------------------#
cloudfront_origins = {
    #---------------------------------------#
    origin_1 = {
        # Origin Settings #
        domain_name = ""
        origin_id = ""
        origin_path = ""
        connection_attempts = 0
        connection_timeout = 0
        # Origin Shield Config #
        enable_origin_shield = false
        origin_shield = {origin_shield_region = ""}
        # S3 Origin Config #
        use_s3_origin_config = false
        s3_origin_config = {
          s3_values = {
            origin_access_identity = ""
            new_origin_access_identity = {
                enabled = false
                comment = "" # Required, must be unique
        } } }
        # Custom Origin Config #
        use_custom_origin_config = false
        custom_origin_config = {
          custom_values = {
            http_port = 0
            https_port = 0
            origin_protocol_policy = ""
            origin_ssl_protocols = [""]
            origin_read_timeout = 0
            origin_keepalive_timeout = 0
        } } }
    #---------------------------------------#
}
#-------------------------------------------#

####################################################


###############################
## CLOUDFRONT CACHE BEHAVIOR ##
####################################################
#- Ordered Cache Behaviors -----------------#
create_ordered_cache_behaviors = false
ordered_cache_behaviors = { 
    #---------------------------------------#
    # Precedence based on top-bottom order
    behavior_1 = {
        # General #
        target_origin_id = ""
        path_pattern = ""
        allowed_methods = []
        cached_methods = []
        compress = false
        smooth_streaming = false
        default_ttl = 0
        max_ttl = 0
        min_ttl = 0
        # Forwarded Values #
        create_forwarded_values = false
        forwarded_values = {
          values = {
            query_string = false
            query_string_cache_keys = [""]
            headers = []            
            cookies = {
                forward = ""
                whitelist_names = []
        } } }
        # Security #
        cache_policy_id = ""
        viewer_protocol_policy = ""
        field_level_encryption_id = ""
        origin_request_policy_id = ""
        trusted_signers = [""]
        trusted_key_groups = []
        # Real Time Logging #
        realtime_log_config_arn = ""
        # Lambda Function Associations # (Max 4) 
        create_lambda_function_associations = false
        lambda_function_associations = {
            #-------------------------------#
            function_1 = {
                event_type = ""
                include_body = false
                lambda_arn = ""
                new_lambda_function = {
                    enabled = false
                    function_name = "" # Required
                    role_arn = ""
                    handler = ""
                    runtime = ""
                    function_local_path = ""
                    tags = { "" = "" }
            } }
            #-------------------------------#
        }
        # Function Associations # (Max 2)
        create_function_associations = false
        function_associations = { 
            #-------------------------------#
            function_1 = {
                event_type = ""
                function_arn = ""
                new_cloudfront_function = {
                    enabled = false
                    name = "" # Required
                    runtime = ""
                    comment = ""
                    function_local_path = ""
            } }
            #-------------------------------#
        }
    }
    #---------------------------------------#
}
#-------------------------------------------#

#- Default Cache Behabior-------------------#
default_cache_behavior_config = {
    # General #
    target_origin_id = "" 
    allowed_methods = []
    cached_methods = []
    compress = false
    smooth_streaming = false
    default_ttl = 0
    max_ttl = 0
    min_ttl = 0
    # Forwarded Values #
    create_forwarded_values = false
    forwarded_values = {
      values = {
        query_string = false
        query_string_cache_keys = [""]
        headers = []            
        cookies = {
            forward = ""
            whitelist_names = []
    }}}
    # Security #
    cache_policy_id = ""
    viewer_protocol_policy = ""
    field_level_encryption_id = ""
    origin_request_policy_id = ""
    trusted_signers = [""]
    trusted_key_groups = []
    # Real Time Logging #
    realtime_log_config_arn = ""
    # Lambda Function Associations # (Max 4) 
    create_lambda_function_associations = false
    lambda_function_associations = {
        #-----------------------------------#
        lambda_function_1 = {
            event_type = ""
            include_body = false
            lambda_arn = ""
            new_lambda_function = {
                enabled = false
                function_name = "" # Required
                role_arn = ""
                handler = ""
                runtime = ""
                function_local_path = ""
                tags = { "" = "" }
        }}
        #-----------------------------------#
    }
    # Function Associations # (Max 2) 
    create_cloudfront_function_associations = false
    cloudfront_function_associations = {
        #-----------------------------------#
        function_1 = {
            event_type = ""
            function_arn = "" 
            new_cloudfront_function = {
                enabled = false
                name = "" # Required
                runtime = ""
                comment = ""
                function_local_path = ""
        }}
        #-----------------------------------#
}}
#-------------------------------------------#


#- Cache/Cookie Logging --------------------#
enable_logging_config = false
logging_config = {
config = {
    bucket = ""
    included_cache_prefix = ""
    include_cookies = false
    }
}
#-------------------------------------------#
####################################################


#######################################
## CLOUDFRONT CUSTOM ERROR RESPONSES ##
####################################################
create_custom_error_responses = false
custom_error_responses = {
    #---------------------------------------#
    error_response_1 = {
        error_code = ""
        error_caching_min_ttl = 0
        response_code = ""
        response_page_path = ""
    }
    #---------------------------------------#
}
####################################################


#########################
## CLOUDFRONT SECURITY ##
####################################################
#- Web ACL ---------------------------------#
  wafv2_web_acl_arn = "" 
  waf_web_acl_id = "" # WAF Classic Only 
#-------------------------------------------#

#- Viewer Certificates ---------------------#
  viewer_https_cert = {
    cert = {
      cloudfront_default_certificate = false
      acm_certificate_arn = ""
      iam_certificate_id = ""
      minimum_protocol_version = ""
      ssl_support_method = ""
  } }
#-------------------------------------------#

#- Restrictions ----------------------------#
  geo_restrictions = {
    value = {
      locations = []
      restriction_type = "" 
  }}
#-------------------------------------------#
####################################################


###################
## END OF MODULE ##
###################
}