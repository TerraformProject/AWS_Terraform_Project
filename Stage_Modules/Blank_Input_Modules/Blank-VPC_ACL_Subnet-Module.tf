module "Blank_ACL" {
source = ""

#################
## Network ACL ##
#################
create_new_acls = false

vpc_id = ""

acl_group = {
    #------------------------------------------#
    Example_Subnet_ACL = {
        ## ACL SETTINGS ##
        acl_name = ""
        subnet_ids = []
        subnet_tags = {}
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = {
            #----------------------------------#
            Example_Ingress_Rule = {
                action = ""
                cidr_block = ""
                ipv6_cidr_block = null
                protocol = ""
                from_port = 0
                to_port = 0
                icmp_code = null
                icmp_type = null
                rule_no = 0
            }
            #----------------------------------#
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_egress_rules = {
            #----------------------------------#
            example_egress_rule = {
                action = ""
                cidr_block = ""
                ipv6_cidr_block = null
                protocol = ""
                from_port = 0
                to_port = 0
                icmp_code = null
                icmp_type = null
                rule_no = 0
            }
            #----------------------------------#
        }
        ## ACL TAGS ##
        tags = {
            "" = ""
        }   }
    #------------------------------------------#
}


###################
## END OF MODULE ##
###################
}