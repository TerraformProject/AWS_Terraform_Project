module "Blank_ROUTE53" {
    source = ""

###########################
## Route53: Hosted Zones ##
###########################
hosted_zones = {

    ####################################################
        Example_Zone = {
            ## HOSTED ZONE SETTINGS ##
            name = ""
            comment = ""
            force_destroy = false
            delegation_set_id = ""
            ### PRIVATE HOSTED ZONE DECLARATION ## 
            private_zone = false
            private_zone_settings = {
                vpc_id = ""
                vpc_region = ""
            }
            ## HOSTED ZONE TAGS ##
            tags = {
            "" = ""
            }
        }
    ####################################################
        
}

###########################
## Route53: Zone Records ##
###########################
route53_records = {

    ####################################################
    Example_Record = {
        ## RECORD SETTINGS ##
        zone_key = ""
        name = ""
        type = "" 
        ttl = 0 # Null if create_alias == true
        multivalue_answer_routing_policy = false
        records = [] # null if create_alias == true
        health_check_id = ""
        set_identifier = ""
        policy = {}
        ## ALIAS SETTINGS ##
        create_alias = false 
        alias = {
            values = {
                name = ""
                zone_key = ""
                evaluate_target_health = false
            }
        }
        ## OVERWITE SETTINGS ##
        allow_overwrite = false
    }
    ####################################################

}

###################
## END OF MODULE ##
###################
}