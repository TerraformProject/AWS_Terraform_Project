module "Blank_ROUTE53" {
source = ""

###########################
## Route53: Hosted Zones ##
###########################

hosted_zones = {

        Zone1 = {
            name = "test_private_zone_1"
            comment = "This is a hosted zone"
            force_destroy = true
            delegation_set_id = ""

            private_zone = true
            private_zone_settings = {
                vpc_id = module.VPC_VPC1.vpc.id
                vpc_region = "us-east-1"
            }
        tags = {
            "HostedZone" = "One"
            }
        }
        
}

###########################
## Route53: Zone Records ##
###########################

route53_records = {

    record_1 = {
        zone_key = "Zone1"
        name = "ElasticacheConfigurationEndpoint"
        type = "A" 
        ttl = 40 # Null if create_alias == true
        multivalue_answer_routing_policy = false
        records = [] # null if create_alias == true
        health_check_id = ""

        set_identifier = "failover"
        policy = {}

        create_alias = true 
        alias = {
            values = {
                name = module.ELASTICACHE.cluster_1.configuration_endpoint
                zone_key = "Zone1"
                evaluate_target_health = true
            }
        }

        allow_overwrite = true
    }

    

    
}



    







}