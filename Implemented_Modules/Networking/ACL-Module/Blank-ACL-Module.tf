module "Blank_ACL" {
source = ""

##################
## ACL: Default ##
##################
create_default_network_acl = false
default_network_acl = {

    Default_Network_ACL = {
        ## DEFAULT ACL SETTINGS ##
        default_network_acl_name = ""
        default_network_acl_id = ""
        default_acl_subnet_ids = []
        ## INGRESS RULE DECLARATIONS ##
        default_network_acl_ingress = {
            ####################################
                ingress_rule_1 = {
                    action = "Deny"
                    cidr_block = "0.0.0.0/0"
                    from_port = 0
                    icmp_code       = null
                    icmp_type       = null
                    ipv6_cidr_block = null
                    protocol = -1
                    rule_no = 10
                    to_port = 0
                }
            ####################################
        }
        ## INGRESS RULE DECLARATIONS ##
        default_network_acl_egress = {
            ####################################
                egress_rule_1 = {
                    action = "Deny"
                    cidr_block = "0.0.0.0/0"
                    from_port = 0
                    icmp_code       = null
                    icmp_type       = null
                    ipv6_cidr_block = null
                    protocol = -1
                    rule_no = 10
                    to_port = 0
                }
            ####################################
        }
        ## DEFAULT ACL SETTINGS ##
        tags = {
            "" = ""
        }
    }
}

########################
## ACL GROUP: EXAMPLE ##
########################
acl_group = {

    ##################
    ## ACL: Example ##
    ##################
    Example_ACL = {
        ## ACL SETTINGS ##
        acl_name = ""
        vpc_id = ""
        acl_subnet_ids = []
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = {
            ####################################
                ingress_rule_1 = {
                    action = "Deny"
                    cidr_block = "0.0.0.0/0"
                    from_port = 0
                    icmp_code       = null
                    icmp_type       = null
                    ipv6_cidr_block = null
                    protocol = -1
                    rule_no = 10
                    to_port = 0
                }
            ####################################
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_ingress_rules = {
            ####################################
                egress_rule_1 = {
                    action = "Deny"
                    cidr_block = "0.0.0.0/0"
                    from_port = 0
                    icmp_code       = null
                    icmp_type       = null
                    ipv6_cidr_block = null
                    protocol = -1
                    rule_no = 10
                    to_port = 0
                }
            ####################################
        }
        ## ACL TAGS ##
        tags = {
            "" = ""
        }
    }
    
}

###################
## END OF MODULE ##
###################
}