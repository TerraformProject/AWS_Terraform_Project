module "Blank_ACL" {
source = ""

##################
## ACL: Default ##
##################
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
acl_group_example = {

    ##################
    ## ACL: Example ##
    ##################
    Example_ACL = {
        ## ACL SETTINGS ##
        public_network_acl_name = ""
        vpc_id = ""
        public_acl_subnet_ids = []
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
        ## ACL TAGS ##
        tags = {
            "public_network_acls" = "VPC1_Public_ACL_1"
        }
    }
}

###################
## END OF MODULE ##
###################
}