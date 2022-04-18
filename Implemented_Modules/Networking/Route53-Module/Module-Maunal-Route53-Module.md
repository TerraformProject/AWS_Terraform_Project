# AWS Route53

### Route53 Hosted Zones   

**Use the below example to create as many Route53 Hosted Zones as desired.**

[AWS Documentation Route53: Hosted Zone Resource Reference](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)

[HashiCorp Terraform Route53: Hosted Zone Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone)

```terraform
###########################
## Route53: Hosted Zones ##
###########################
hosted_zones = {

        # Able to create multiple hosted zones. Each key for a hosted zone must be unique.
        ####################################################
            Example_Zone = { 
                ## HOSTED ZONE SETTINGS ##
                name = string # Name of the hosted zone 
                comment = string # A comment describing the hosted zone 
                force_destroy = bool # Whether to destroy all records inside the when destroying the zone
                delegation_set_id = string # Conflicts with private_zone_settings. The reusable delegation set whose NS you want to assign to the hosted zone
                ### PRIVATE HOSTED ZONE DECLARATION ##
                private_zone = bool # Whether to declare this hosted zone as a private hosted zone
                private_zone_settings = {
                    vpc_id = string # The VPC ID where the private hosted zone will be associated with
                    vpc_region = string # The AWS region of which the private hosted zone will be located in
                }
                ## HOSTED ZONE TAGS ##
                tags = {
                "Key" = "Value" # Tags to associate with the hosted zone
                }
            }
        ####################################################
}

```

### Route53 DNS Records

**Use the below example to create as many Route53 DNS Records as desired**

[AWS Documentation Route53: DNS Record Resource Reference](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html)

[Route53: DNS Record Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)

```terraform 
###########################
## Route53: Zone Records ##
###########################
route53_records = {

    # Able to create multiple DNS records. Each key for a DNS records must be unique.
    ####################################################
    Example_Record = {
        ## RECORD SETTINGS ##
        zone_key = string # The key for the desired hosted zone declared above
        name = string # Name for the DNS record. Hosted Zone name is automatically appended
        type = string # Type of DNS record 
        ttl = number # Time to live value for DNS record. Value is Null if create_alias == true
        multivalue_answer_routing_policy = bool # Whether this DNS record accepts multivalue responses
        records = list(string) # Resource values for the DNS record. Value is Null if create_alias == true
        health_check_id = string # The health check ID to associate this DNS record with
        set_identifier = string # "faliover" # "failover" || "latency" || "geolocation" || "weighted"
        policy = {
            # Policy is null if multivalue_answer_routing_policy == true
            # Depending on the set identifier value will determine what attribute this block will accept
            # Please refer to the DNS Record Resource Reference to specify the appropriate attributes and values
        }
        ## ALIAS SETTINGS ##
        create_alias = bool # Whether to create an Alias record 
        alias = {
            values = {
                name = string # Name for the Alias record 
                zone_key = string # The key for the desired hosted zone declared above
                evaluate_target_health = bool # If Route 53 should respond to DNS queries using this resource record set by checking the health of the resource record set
            }
        }
        ## OVERWITE SETTINGS ##
        allow_overwrite = bool # Leave false, Not recommended for most environments. Whether Terraform should overwrite an existing record, if any.
    }
    ####################################################
}
```