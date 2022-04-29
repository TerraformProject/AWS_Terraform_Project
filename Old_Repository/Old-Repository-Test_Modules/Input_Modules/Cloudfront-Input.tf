module "CLOUDFRONT" {
    source = "../../Modules/Network-Modules/Default-modules/Cloudfront-Modules"
    
#############################
## CloudFront Distribution ##
#############################
create_cloudfront_distribution = true

## Distribution Settings ##
enable_distribution = true
distribution_comment = ""
price_class = ""
aliases = []
default_root_object = "index.html"
http_version = "http2"
is_ipv6_enabled = false
retain_on_delete = false
wait_for_deployment = true

## Origin Settings ##
cloudfront_origins = {
    origin_1 = {
        # Origin Settings #
        domain_name = "yuh2.com"
        origin_id = "aaaaa"
        origin_path = "/var/www/html"
        connection_attempts = 3
        connection_timeout = 3
        # Origin Shield Config #
        enable_origin_shield = false
        origin_shield = {origin_shield_region = "us-west-2"}
        # S3 Origin Config #
        use_s3_origin_config = true
        s3_origin_config = {
          s3_values = {
            origin_access_identity = ""
            new_origin_access_identity = {
                enabled = true
                comment = "origin_access_id" # Required, must be unique
            }
          }
        }
        # Custom Origin Config #
        use_custom_origin_config = false
        custom_origin_config = {
          custom_values = {
            http_port = 8080
            https_port = 8443
            origin_protocol_policy = "https-only"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
            origin_read_timeout = 60
            origin_keepalive_timeout = 60
            }
        }
    }
    origin_2 = {
        # Origin Settings #
        domain_name = "yuh7.com"
        origin_id = "yuha"
        origin_path = "/var/www/html"
        connection_attempts = 3
        connection_timeout = 3
        # Origin Shield Config #
        enable_origin_shield = false
        origin_shield = {origin_shield_region = "us-east-1a"}
        # S3 Origin Config #
        use_s3_origin_config = true
        s3_origin_config = {
          s3_values = {
            origin_access_identity = ""
            new_origin_access_identity = {
                enabled = true
                comment = "origin_access_id_2" # Required, must be unique
            }
          }
        }
        # Custom Origin Config #
        use_custom_origin_config = false
        custom_origin_config = {
          custom_values = {
            http_port = 8080
            https_port = 8443
            origin_protocol_policy = "https-only"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
            origin_read_timeout = 60
            origin_keepalive_timeout = 60
            }
        }
    }
}

## Origin Group Config ##
create_origin_group = false
origin_group_config = {
  config = {
    origin_group_id = "group_yuh"
    failover_status_codes = []
    member_origin_ids = ["yuhdh","dddd"] # First ID is primary origin
  }
}

## Default Cache Behavior Config ##
default_cache_behavior_config = {
    # General #
    target_origin_id = "" 
    allowed_methods = []
    cached_methods = []
    compress = true
    smooth_streaming = false
    default_ttl = 60
    max_ttl = 60
    min_ttl = 60
    # Forwarded Values #
    create_forwarded_values = false
    forwarded_values = {
      values = {
        query_string = true
        query_string_cache_keys = ["asdfasdfasdf"]
        headers = []            
        cookies = {
            forward = "none"
            whitelist_names = []
        }
      }
    }
    # Security #
    cache_policy_id = ""
    viewer_protocol_policy = ""
    field_level_encryption_id = ""
    origin_request_policy_id = ""
    trusted_signers = ["self"]
    trusted_key_groups = []
    # Real Time Logging #
    realtime_log_config_arn = ""
    # Lambda Function Associations # (Max 4) 
    create_lambda_function_associations = true
    lambda_function_associations = {
        lambda_function_1 = {
            event_type = "aaa"
            include_body = false
            lambda_arn = ""
            new_lambda_function = {
                enabled = true
                function_name = "44444" # Required
                role_arn = "/role"
                handler = "handeler"
                runtime = "python2.7"
                function_local_path = ""
                tags = { "key" = "value" }
        } }
    }
    # Function Associations # (Max 2) 
    create_cloudfront_function_associations = true
    cloudfront_function_associations = {
        function_1 = {
            event_type = "asdf"
            function_arn = "" 
            new_cloudfront_function = {
                enabled = true
                name = "22222" # Required
                runtime = "cloudfront-js-1.0"
                comment = "yuh"
                function_local_path = "Input-Values\\Testing-Input\\efs-test-policy.json"
        }}
    }
}

## Ordered Cache Behaviors ##
create_ordered_cache_behaviors = true
ordered_cache_behaviors = {
    # Precedence based on top-bottom order # 
    behavior_1 = {
        # General #
        target_origin_id = ""
        path_pattern = "/indexyuh"
        allowed_methods = []
        cached_methods = []
        compress = true
        smooth_streaming = false
        default_ttl = 60
        max_ttl = 60
        min_ttl = 60
        # Forwarded Values #
        create_forwarded_values = true
        forwarded_values = {
          values = {
            query_string = true
            query_string_cache_keys = ["sdfsf"]
            headers = []            
            cookies = {
                forward = "none"
                whitelist_names = []
        } } }
        # Security #
        cache_policy_id = ""
        viewer_protocol_policy = ""
        field_level_encryption_id = ""
        origin_request_policy_id = ""
        trusted_signers = ["self"]
        trusted_key_groups = []
        # Real Time Logging #
        realtime_log_config_arn = ""
        # Lambda Function Associations # (Max 4) 
        create_lambda_function_associations = true
        lambda_function_associations = {
            function_1 = {
                event_type = "ttt"
                include_body = true
                lambda_arn = ""
                new_lambda_function = {
                  enabled = true
                  function_name = "55555" # Required
                  role_arn = "/role"
                  handler = "handeler"
                  runtime = "python2.7"
                  function_local_path = "Input-Values\\Testing-Input\\efs-test-policy.json"
                  tags = { "key" = "value" }
            } }
        }
        # Function Associations # (Max 2)
        create_function_associations = true
        function_associations = { 
            function_1 = {
                event_type = "hhh"
                function_arn = ""
                new_cloudfront_function = {
                  enabled = true
                  name = "11111" # Required
                  runtime = "cloudfront-js-1.0"
                  comment = "yuh"
                  function_local_path = "Input-Values\\Testing-Input\\efs-test-policy.json"
            }}
        }
    }
}

## Custom Error Responses ##
create_custom_error_responses = true
custom_error_responses = {
    error_response_1 = {
        error_code = "404"
        error_caching_min_ttl = 0
        response_code = "404"
        response_page_path = "/custom_404.html"
    }
}

## Cache/Cookie Logging ##
enable_logging_config = true
logging_config = {
config = {
    bucket = "bucket-the-yuh"
    included_cache_prefix = "...yuh"
    include_cookies = true
    }
}

## Security ##

    # Web ACL #
    wafv2_web_acl_arn = "" 
    waf_web_acl_id = "" # WAF Classic Only 

    ## Viewer Certificates ##
    viewer_https_cert = {
      cert = {
        cloudfront_default_certificate = false
        acm_certificate_arn = ""
        iam_certificate_id = ""
        minimum_protocol_version = ""
        ssl_support_method = ""
      }
    }

    ## Restrictions ##
    geo_restrictions = {
      value = {
        locations = []
        restriction_type = "whitelist" 
      }
    }

## Cloudfront Tags ##
cloudfront_tags = {
    "key" = "value"
}

}