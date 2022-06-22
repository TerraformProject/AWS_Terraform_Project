module "ACLS_SUBNETS_AWS_PROECT" {
source = "../Back_End_Modules/VPC_ACL_Subnet-Module"

#################
## Network ACL ##
#################
create_new_acls = true

vpc_id = module.VPC_AWS_PROJECT.vpc_001_id

acl_group = {
    #------------------------------------------#
    Public_Subnet_ACL = {
        ## ACL SETTINGS ##
        acl_name = "ACL_001_VPC_001"
        subnet_ids = [
            module.VPC_AWS_PROJECT.PubSub_001_VPC_001_id,
            module.VPC_AWS_PROJECT.PubSub_002_VPC_001_id
        ]
        subnet_tags = {}
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = {
            #----------------------------------#
            ingress_rule_1 = {
                action = "Allow"
                cidr_block = "0.0.0.0/0"
                ipv6_cidr_block = null
                protocol = "tcp"
                from_port = 443
                to_port = 443
                icmp_code       = null
                icmp_type       = null
                rule_no = 20
            }
            ingress_rule_2 = {
                action = "Allow"
                cidr_block = "0.0.0.0/0"
                ipv6_cidr_block = null
                protocol = "udp"
                from_port = 80
                to_port = 80
                icmp_code       = null
                icmp_type       = null
                rule_no = 40
            }
            ingress_rule_3 = {
                action = "Allow"
                cidr_block = "0.0.0.0/0"
                ipv6_cidr_block = null
                protocol = "tcp"
                from_port = 1024
                to_port = 65535
                icmp_code       = null
                icmp_type       = null
                rule_no = 1000
            }
            #----------------------------------#
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_egress_rules = {
            
        }
        ## ACL TAGS ##
        tags = {
            "ACLs_VPC_001" = "ACL_001_VPC_001"
        }   }
    #------------------------------------------#
}

###################
## END OF MODULE ##
###################
}