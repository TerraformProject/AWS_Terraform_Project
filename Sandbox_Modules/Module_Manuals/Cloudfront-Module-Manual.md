# AWS Cloudfront

### AWS Cloudfront Distribution

[AWS Documentation: Cloudfront Resource Reference](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)    

[HashiCorp Terraform Documentation: Cloudfront Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)

**Use the example below to create an Amazon Cloudfront distribution.**

```Terraform
#############################
## CLOUDFRONT DISTRIBUTION ##
####################################################
#- Cloudfront Settings----------------------#
create_cloudfront_distribution = false # Whether or not a Cloudfront distribution will be created
enable_distribution = false # Whether or not a Cloudfront distrution should be enabled
distribution_comment = "" # Any comments to include for this distribution
price_class = "" # The price class for this distribution
aliases = [] # Additonal CNAMES (Alternate domain names), to include on this distribution
default_root_object = "" # Object returned when a user requests the root URL
http_version = "" # The maximum HTTP version ti support on this distribution
is_ipv6_enabled = false # Whether or not IPv6 is enabled for this distibution
retain_on_delete = false # Disables the distribution instead of deleting when destroying resource through Terraform
wait_for_deployment = false # Whether or not the resource will wait for the distribution status to change from "InProgress" to "Deployed"

cloudfront_tags = { "key" = "value" } # Tags to associate with this distribution
#-------------------------------------------#
####################################################
```

### AWS CloudFront Origins   

[AWS Documentation: Cloudfront Origins Reference](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)  

[HashiCorp Terraform Documentation: Cloudfront Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)   

**Use the example below to configure the origins within the Amazon Cloudfront distribution.**

```Terraform
########################
## CLOUDFRONT ORIGINS ##
####################################################
#- Origin Group Config ---------------------#
create_origin_group = false
origin_group_config = {
  config = {
    origin_group_id = "" # A unique identifier for the origin group
    failover_status_codes = [] # A list of HTTP status codes for the origin group
    member_origin_ids = [""] # First ID is primary origin. The unique origin IDs of other origins to be listed as members of this origin group
}}
#-------------------------------------------#
  
#- Create New Origins ----------------------#
cloudfront_origins = {
# ABLE TO CREATE MORE THAN ONE
    #---------------------------------------#
    origin_1 = {
        # Origin Settings #
        domain_name = "" # The DNS domain name of the S3 Bucket, or web site of your custom origin
        origin_id = "" # A unique identifier for the origin
        origin_path = "" # Optional element that causes Cloudfront to request your content from a directory in you Amazon S3 bucket or custom origin
        connection_attempts = 0 # Number of times that Cloudfront attempts to connect to the origin. Must be between 1-3
        connection_timeout = 0 # Number of seconds Cloudfront wait when attempting to establish a connection to the origin
        # Origin Shield Config #
        enable_origin_shield = false # Whether or not Amazon Cloudfron Origin Shield should be enabled for this origin
        origin_shield = {origin_shield_region = ""} # The AWS region for the origin shield to take place in
        # S3 Origin Config #
        use_s3_origin_config = false # Whether or not to use an S3 Bucket as an origin
        s3_origin_config = {
          s3_values = {
            origin_access_identity = "" # The Cloudfront origin access identity to associate with the origin
            new_origin_access_identity = {
                enabled = false # Whether or not a new origin access identity should be enabled
                comment = "" # Required, must be unique. Used as a module key. Additional details on the origin access identity
        } } }
        # Custom Origin Config #
        use_custom_origin_config = false # Whether or not to use a custom origin configuration
        custom_origin_config = {
          custom_values = {
            http_port = 0 # The HTTP port the custom origin listens on
            https_port = 0 # The HTTPS port the custom origin listens on
            origin_protocol_policy = "" # The origin protocol policy to apply to this origin
            origin_ssl_protocols = [""] # The SSL/TLS protocols to be used when communicating over HTTPS
            origin_read_timeout = 0 # The custom read timeout (In seconds)
            origin_keepalive_timeout = 0 # The custom KeepAlive timeout (In Seconds)
        } } }
    #---------------------------------------#
}
#-------------------------------------------#
####################################################
```

### AWS CloudFront Cache Behaviors  

[AWS Documentation: Cloudfront Cache Behaviors Reference](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesCacheBehavior)    

[HashiCorp Terraform Documentation: Cloudfront Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)      

**Use the example below to configure the cache behaviors within the Amazon Cloudfront distribution.**

```Terraform
###############################
## CLOUDFRONT CACHE BEHAVIOR ##
####################################################
#- Ordered Cache Behaviors -----------------#
create_ordered_cache_behaviors = false # Whether or not to create an orderd cache behavior for the distribution
ordered_cache_behaviors = { 
# ABLE TO CREATE MORE THAN ONE
# Precedence based on top-bottom order
    #---------------------------------------#
    behavior_1 = {
        # General #
        target_origin_id = "" # The value of ID for the origin that you Cloudfront to route requests to when a request matches the path pattern either for a cache behavior or default cache behavior
        path_pattern = "" # The pattern that specifies which requests you want this cache behavior to apply to. Example: images/*.jpg
        allowed_methods = [] # Controls wich HTTp methods Cloudfront processes and forwards to your Amazon S3 bucket or custom origin
        cached_methods = [] # Controls whether Cloudfront caches the response to requests using the specified HTTP methods
        compress = false # Whether or not you would like Cloudfront to auto-compress content for web requests that include "Accept-Encoding: gzip" in the request header
        smooth_streaming = false # Whether or not you would like to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior
        default_ttl = 0 # The default amount of time (in seconds) that an object is in a Cloudfront cache before Cloudfron forwards another request in absensce of a "Cache-Control max-age" or "Expires" header
        max_ttl = 0 # The maximum amount of time (in seconds) that an object is in a Cloudfront cache before Cloudfront forwards another request to the origin to detirmine whether the object has been update. Only effective in the presence of "Cache-Control max-age, Cache-Control s-maxage, and Expires" header
        min_ttl = 0 # The minimum amount of time that you want objects to stay in Cloudfron caches before Cloudfront queries your origin to see whether the object has been updated. Defaults to 0 seconds
        # Forwarded Values #
        create_forwarded_values = false # Whether or not to create forwarded values for this behavior
        forwarded_values = {
          values = {
            query_string = false # Whether or not you would like Cloudfront to forward query strings to the origin that is associated with this cache behavior
            query_string_cache_keys = [""] # Although all query strings are forwarded, the query string keys listed here are cached. When "query_string" = false, all query string keys are cached
            headers = [] # Specifies the headers, if any, that you would like Cloudfront to vary upon for this cache behavior. Specify * to unclude all headers            
            cookies = {
                forward = "" # Specifies if you would like Cloudfront to forward the cookies to the origin that is associated with this cache behavior. Whitelisted names are required here if "whitelist" is specified
                whitelist_names = [] # The whitelisted cookies you would like Cloudfront to forward to your origin
        } } }
        # Security #
        cache_policy_id = "" # The unique identifier of the cache policy that is attached to the cache behavior
        viewer_protocol_policy = "" # Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginid when a request matches the path pattern in PathPattern
        field_level_encryption_id = "" # Field level encryption configuration ID
        origin_request_policy_id = "" # The unique identifier of the origin reqest policy that is attached to the behavior
        trusted_signers = [""] # List of AWS accoun IDs (or "self") that you will allow to create signed URLS for private content
        trusted_key_groups = [] # A list of key group IDs that Cloudfront can use to validate signed URLS or signed cookies
        # Real Time Logging #
        realtime_log_config_arn = "" # The ARN of the real-time log configuration that is attached to this cache behavior
        # Lambda Function Associations # (Max 4) 
        create_lambda_function_associations = false # Whether or not to create a Lambda function association
        lambda_function_associations = {
            #-------------------------------#
            function_1 = {
                event_type = "" # The specific event to trigger this function
                include_body = false # Whether or not to expose the request body to the Lambda function
                lambda_arn = "" # The ARN of the existing Lambda funtion to associate
                new_lambda_function = {
                    enabled = false # Whether or not to create a new Lambda function to associate
                    function_name = "" # Required, name of the function
                    role_arn = "" # ARN of IAM policy to attach to the Lambda function
                    handler = "" # Function Entrypoint in your code
                    runtime = "" # Identifier of the function runtime
                    function_local_path = "" # Local path to assign to the Lambda function
                    tags = { "" = "" } # Tags to associate with the Lambda function
            } }
            #-------------------------------#
        }
        # Function Associations # (Max 2)
        create_function_associations = false
        function_associations = { 
            #-------------------------------#
            function_1 = {
                event_type = "" # The specific event to trigger this function
                function_arn = "" # The ARN of the existing funtion to associate
                new_cloudfront_function = {
                    enabled = false # Whether or not to create a new function to associate
                    name = "" # Required, name of the function
                    runtime = "" # Identifier of the function runtime
                    comment = "" # Additional description of the function
                    function_local_path = "" # Local path the assign to the functin
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
        target_origin_id = "" # The value of ID for the origin that you Cloudfront to route requests to when a request matches the path pattern either for a cache behavior or default cache behavior
        path_pattern = "" # The pattern that specifies which requests you want this cache behavior to apply to. Example: images/*.jpg
        allowed_methods = [] # Controls wich HTTp methods Cloudfront processes and forwards to your Amazon S3 bucket or custom origin
        cached_methods = [] # Controls whether Cloudfront caches the response to requests using the specified HTTP methods
        compress = false # Whether or not you would like Cloudfront to auto-compress content for web requests that include "Accept-Encoding: gzip" in the request header
        smooth_streaming = false # Whether or not you would like to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior
        default_ttl = 0 # The default amount of time (in seconds) that an object is in a Cloudfront cache before Cloudfron forwards another request in absensce of a "Cache-Control max-age" or "Expires" header
        max_ttl = 0 # The maximum amount of time (in seconds) that an object is in a Cloudfront cache before Cloudfront forwards another request to the origin to detirmine whether the object has been update. Only effective in the presence of "Cache-Control max-age, Cache-Control s-maxage, and Expires" header
        min_ttl = 0 # The minimum amount of time that you want objects to stay in Cloudfron caches before Cloudfront queries your origin to see whether the object has been updated. Defaults to 0 seconds
        # Forwarded Values #
        create_forwarded_values = false # Whether or not to create forwarded values for this behavior
        forwarded_values = {
          values = {
            query_string = false # Whether or not you would like Cloudfront to forward query strings to the origin that is associated with this cache behavior
            query_string_cache_keys = [""] # Although all query strings are forwarded, the query string keys listed here are cached. When "query_string" = false, all query string keys are cached
            headers = [] # Specifies the headers, if any, that you would like Cloudfront to vary upon for this cache behavior. Specify * to unclude all headers            
            cookies = {
                forward = "" # Specifies if you would like Cloudfront to forward the cookies to the origin that is associated with this cache behavior. Whitelisted names are required here if "whitelist" is specified
                whitelist_names = [] # The whitelisted cookies you would like Cloudfront to forward to your origin
        } } }
        # Security #
        cache_policy_id = "" # The unique identifier of the cache policy that is attached to the cache behavior
        viewer_protocol_policy = "" # Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginid when a request matches the path pattern in PathPattern
        field_level_encryption_id = "" # Field level encryption configuration ID
        origin_request_policy_id = "" # The unique identifier of the origin reqest policy that is attached to the behavior
        trusted_signers = [""] # List of AWS accoun IDs (or "self") that you will allow to create signed URLS for private content
        trusted_key_groups = [] # A list of key group IDs that Cloudfront can use to validate signed URLS or signed cookies
        # Real Time Logging #
        realtime_log_config_arn = "" # The ARN of the real-time log configuration that is attached to this cache behavior
        # Lambda Function Associations # (Max 4) 
        create_lambda_function_associations = false # Whether or not to create a Lambda function association
        lambda_function_associations = {
            #-------------------------------#
            function_1 = {
                event_type = "" # The specific event to trigger this function
                include_body = false # Whether or not to expose the request body to the Lambda function
                lambda_arn = "" # The ARN of the existing Lambda funtion to associate
                new_lambda_function = {
                    enabled = false # Whether or not to create a new Lambda function to associate
                    function_name = "" # Required, name of the function
                    role_arn = "" # ARN of IAM policy to attach to the Lambda function
                    handler = "" # Function Entrypoint in your code
                    runtime = "" # Identifier of the function runtime
                    function_local_path = "" # Local path to assign to the Lambda function
                    tags = { "" = "" } # Tags to associate with the Lambda function
            } }
            #-------------------------------#
        }
        # Function Associations # (Max 2)
        create_function_associations = false
        function_associations = { 
            #-------------------------------#
            function_1 = {
                event_type = "" # The specific event to trigger this function
                function_arn = "" # The ARN of the existing funtion to associate
                new_cloudfront_function = {
                    enabled = false # Whether or not to create a new function to associate
                    name = "" # Required, name of the function
                    runtime = "" # Identifier of the function runtime
                    comment = "" # Additional description of the function
                    function_local_path = "" # Local path the assign to the functin
            } }
        #-----------------------------------#
}}
#-------------------------------------------#

#- Cache/Cookie Logging --------------------#
enable_logging_config = false
logging_config = {
config = {
    bucket = "" # The Amazon S3 Bucket to store the access logs in
    included_cache_prefix = "" # Optional string that you want Cloudfront to prefix to the access log filenames for this distribution
    include_cookies = false # Whether or not include cookies in the Cloudfront access logs
    }
}
#-------------------------------------------#
####################################################
```

### AWS CloudFront Custom Error Responses  

[AWS Documentation: Cloudfront Custom Error Responses Reference](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/GeneratingCustomErrorResponses.html)    

[HashiCorp Terraform Documentation: Cloudfront Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)      

**Use the example below to configure the custom error responses within the Amazon Cloudfront distribution.**

```Terraform
#######################################
## CLOUDFRONT CUSTOM ERROR RESPONSES ##
####################################################
create_custom_error_responses = false # Whether or not to create customr error responses for the Cloudfront distribution
custom_error_responses = {
# ABLE TO CREATE MORE THAN ONE
    #---------------------------------------#
    error_response_1 = {
        error_code = "" # The 4xx or 5xx HTTP status code you would like to customize
        error_caching_min_ttl = 0 # The minimum amount of time you want HTTPS error codes to stay in Cloudfront caches before Cloudfront queries the origin
        response_code = "" # The HTTP response code that you want Cloudfront to return with the custom error page to the viewer
        response_page_path = "" # The path of the custom error page. Example "/custom_404.html"
    }
    #---------------------------------------#
}
####################################################
```

### AWS CloudFront Security Parameters

[AWS Documentation: Cloudfront WAFv2/WAF Web ACL Reference](https://docs.aws.amazon.com/waf/latest/developerguide/cloudfront-features.html)  

[AWS Documentation: Cloudfront SSL/TLS Certificates Reference](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cnames-and-https-requirements.html)  

[AWS Documentation: Cloudfront Restrictions Reference](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/georestrictions.html) 

[HashiCorp Terraform Documentation: Cloudfront Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)      

**Use the example below to configure the security parameters within the Amazon Cloudfront distribution.**

```Terraform
#########################
## CLOUDFRONT SECURITY ##
####################################################
#- Web ACL ---------------------------------#
  wafv2_web_acl_arn = "" # The ARN of the of the AWS WAFv2 web ACL, if any, to associate with this distribution
  waf_web_acl_id = "" # WAF Classic Only, the unique identifier that specifies the AWS WAF web ACL 
#-------------------------------------------#

#- Viewer Certificates ---------------------#
  viewer_https_cert = {
    cert = {
      cloudfront_default_certificate = false # Whether or not if you want viewers to use HTTPS to request objects and you're using Cloudfront domain name in the distribution
      acm_certificate_arn = "" # The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1
      iam_certificate_id = "" # The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain
      minimum_protocol_version = "" # Minimum version of the SSL protocol that you want Cloudfront to use for HTTPS connections. Can only be set if "cloudfront_default_certificate" = false
      ssl_support_method = "" # Specifies how you want Cloudfront to serve HTTPS requests. Required if "acm_certificate_arn" or "iam_certificate_id" is specified
  } }
#-------------------------------------------#

#- Restrictions ----------------------------#
  geo_restrictions = {
    value = {
      locations = [] # The ISO 3166-1-alpha-2-codes for which you want Cloudfront to either distribute content (whitelist) or not distribute content (blacklist)
      restriction_type = "" # The method of which you want to distribute content by country.
  }}
#-------------------------------------------#
####################################################
```

