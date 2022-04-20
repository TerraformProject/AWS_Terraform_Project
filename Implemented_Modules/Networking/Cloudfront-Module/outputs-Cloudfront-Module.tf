##########################
## Cloudfront Variables ##
##########################

## Distribution Settings ##

variable "create_cloudfront_distribution" {
    description = "Whether to create a Cloudfront distribution"
    type = bool
    default = false
}

variable "enable_distribution" {
    description = "Whether to enable the distribution"
    type = bool
    default = false
}

variable "distribution_comment" {
    description = "A comment for the distribution"
    type = string
    default = null
}
variable "price_class" {
    description = "The price class for the distribution"
    type = string
    default = null
}

variable "aliases" {
    description = "CNAMEs for the cloudfornt domain"
    type = list(string)
    default = null
}

variable "default_root_object" {
    description = "Default root object to return from the origin"
    type = string
    default = null
}

variable "http_version" {
    description = "leading up to http version that the distribution will accept"
    type = string
    default = null
}

variable "is_ipv6_enabled" {
    description = "Whether traffic from ipv6 is accepted"
    type = bool
    default = false
}

variable "retain_on_delete" {
    description = "When resource is deleted by terraform the distribution is disabled instead of deleted"
    type = bool
    default = false
}

variable "wait_for_deployment" {
    description = "Whether to wait before all of distribution is provisioned before enabling it"
    type = bool
    default = false
}

## Origin Settings ##

variable "cloudfront_origins" {
    description = "Settings for creating cloudfront origins"
    type = map(object({
        domain_name = string
        origin_id = string
        origin_path = string
        connection_attempts = number
        connection_timeout = number
        enable_origin_shield = bool
        origin_shield = map(string)
        use_s3_origin_config = bool
        s3_origin_config = map(object({
            origin_access_identity = string
            new_origin_access_identity = object({
                enabled = bool
                comment = string
            })
        }))
        use_custom_origin_config = bool
        custom_origin_config = map(object({
            http_port = number
            https_port = number
            origin_protocol_policy = string
            origin_ssl_protocols = list(string)
            origin_read_timeout = number
            origin_keepalive_timeout = number
        }))
    }))
    default = {}
}

## Origin Group Config ##

variable "create_origin_group" {
    description = "Whether to create an origin group"
    type = bool
    default = false
}

variable "origin_group_config" {
    description = "settings for the origin group"
    type = map(object({
        origin_group_id = string
        failover_status_codes = list(string)
        member_origin_ids = list(string)
    }))
    default = {}
}

## Default Cache Behavior Config ##
variable "default_cache_behavior_config" {
    description = "Settings for the default cache behavior"
    type = object({
        target_origin_id = string
        allowed_methods = list(string)
        cached_methods = list(string)
        compress = bool
        smooth_streaming = bool
        default_ttl = number
        max_ttl = number
        min_ttl = number
        create_forwarded_values = bool
        forwarded_values = map(object({
            query_string = bool
            query_string_cache_keys = list(string)
            headers = list(string)
            cookies = object({
                forward = string
                whitelist_names = list(string)
            })
        }))
        cache_policy_id = string
        viewer_protocol_policy = string
        field_level_encryption_id = string
        origin_request_policy_id = string
        trusted_signers = list(string)
        trusted_key_groups = list(string)
        realtime_log_config_arn = string
        create_lambda_function_associations = bool
        lambda_function_associations = map(object({
            event_type = string
            include_body = bool
            lambda_arn = string
            new_lambda_function = object({
                enabled = bool
                function_name = string
                role_arn = string
                handler = string
                runtime = string
                function_local_path = string
                tags = map(string)
            })
        }))
        create_cloudfront_function_associations = bool
        cloudfront_function_associations = map(object({
            event_type = string
            function_arn = string
            new_cloudfront_function = object({
                enabled = bool
                name = string
                runtime = string
                comment = string
                function_local_path = string
            })
        }))
    })
    default = null
}

## Ordered Cache Behavior ##

variable "create_ordered_cache_behaviors" {
    description = "Whether to create an ordered cache behavior"
    type = bool 
    default = false
}

variable "ordered_cache_behaviors" {
    description = "Whether to create ordered cache behaviors"
    type = map(object({
        path_pattern = string
        target_origin_id = string
        allowed_methods = list(string)
        cached_methods = list(string)
        compress = bool
        smooth_streaming = bool
        default_ttl = number
        max_ttl = number
        min_ttl = number
        create_forwarded_values = bool
        forwarded_values = map(object({
            query_string = bool
            query_string_cache_keys = list(string)
            headers = list(string)
            cookies = object({
                forward = string
                whitelist_names = list(string)
            })
        }))
        cache_policy_id = string
        viewer_protocol_policy = string
        field_level_encryption_id = string
        origin_request_policy_id = string
        trusted_signers = list(string)
        trusted_key_groups = list(string)
        realtime_log_config_arn = string
        create_lambda_function_associations = bool
        lambda_function_associations = map(object({
            event_type = string
            include_body = bool
            lambda_arn = string
            new_lambda_function = object({
                enabled = bool
                function_name = string
                role_arn = string
                handler = string
                runtime = string
                function_local_path = string
                tags = map(string)
            })
        }))
        create_function_associations = bool
        function_associations = map(object({
            event_type = string
            function_arn = string
            new_cloudfront_function = object({
                enabled = bool
                name = string
                runtime = string
                comment = string
                function_local_path = string
            })
        }))
    }))
    default = {}
}

## Custom Error Responses ##

variable "create_custom_error_responses" {
    description = "Whether to create custom error responses"
    type = bool
    default = false
}

variable "custom_error_responses" {
    description = "Settings for creating custom error responses"
    type = map(object({
        error_code = string
        error_caching_min_ttl = number
        response_code = string
        response_page_path = string
    }))
}

## Cache/Cookie Logging ##

variable "enable_logging_config" {
    description = "Whether to enable cache/cookie logging for the distribution"
    type = bool
    default = false
}

variable "logging_config" {
    description = "Settings for the logging config"
    type = map(object({
        bucket = string
        included_cache_prefix = string
        include_cookies = bool
    }))
    default = null
}

# Security #

variable "wafv2_web_acl_arn" {
    description = "WAFv2 ACL ARN toapply to the distribution"
    type = string
    default = null
}

variable "waf_web_acl_id" {
    description = "WAF Web ACL ID to apply to distriution. Classic Only"
    type = string
    default = null
}

variable "viewer_https_cert" {
    description = "HTTPS Certifcates to apply to distribution"
    type = map(object({
        cloudfront_default_certificate = bool
        acm_certificate_arn = string
        iam_certificate_id = string
        minimum_protocol_version = string
        ssl_support_method = string
    }))
    default = {}
}

## Restrictions ##

variable "geo_restrictions" {
    description = "Settings for creating geo restrictions"
    type = map(object({
        locations = list(string)
        restriction_type = string
    }))
}

## Cloudfront Tags ##
variable "cloudfront_tags" {
    description = "Tags to associate with the cloudfront distribution"
    type = map(string)
    default = {}
}