module "ACLS_SUBNETS_AWS_PROECT" {
source = "../Back_End_Modules/VPC_ACL_Subnet-Module"

#################
## Network ACL ##
#################
create_new_acls = true

vpc_id = module.VPC_AWS_PROJECT.vpc_aws_terraform_id

acl_group = {
    #------------------------------------------#
    Public_Subnet_ACL = {
        ## ACL SETTINGS ##
        acl_name = "Public_Subnets_ACL"
        acl_subnet_names = [
            "Public_Subnet_One",
            "Public_Subnet_Two"
        ]
        acl_subnet_tags = {}
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = {
            #----------------------------------#
            ingress_rule_1 = {
                action = "Allow"
                cidr_block = "0.0.0.0/0"
                ipv6_cidr_block = null
                protocol = "udp"
                from_port = 80
                to_port = 80
                icmp_code       = null
                icmp_type       = null
                rule_no = 10
            }
            ingress_rule_2 = {
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
            #----------------------------------#
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_egress_rules = {
            #----------------------------------#
            egress_rule_1 = {
                action = "Allow"
                cidr_block = "0.0.0.0/0"
                ipv6_cidr_block = null
                protocol = "udp"
                from_port = 80
                to_port = 80
                icmp_code       = null
                icmp_type       = null
                rule_no = 10
            }
            egress_rule_2 = {
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
            #----------------------------------#
        }
        ## ACL TAGS ##
        tags = {
            "Public_Subnets" = "External_Network"
        }   }
    #------------------------------------------#
    #------------------------------------------#
    Private_Subnet_ACL = {
        ## ACL SETTINGS ##
        acl_name = "Private_Subnets_ACL"
        acl_subnet_names = [
            "Private_Subnet_One",
            "Private_Subnet_Two"
        ]
        acl_subnet_tags = {}
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = {
            #----------------------------------#
            ingress_rule_1 = {
                action = "Allow"
                cidr_block = "0.0.0.0/0"
                ipv6_cidr_block = null
                protocol = "udp"
                from_port = 80
                to_port = 80
                icmp_code       = null
                icmp_type       = null
                rule_no = 10
            }
            ingress_rule_2 = {
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
            #----------------------------------#
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_egress_rules = {
            #----------------------------------#
            egress_rule_1 = {
                action = "Allow"
                cidr_block = "0.0.0.0/0"
                ipv6_cidr_block = null
                protocol = "udp"
                from_port = 80
                to_port = 80
                icmp_code       = null
                icmp_type       = null
                rule_no = 10
            }
            egress_rule_2 = {
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
            #----------------------------------#
        }
        ## ACL TAGS ##
        tags = {
            "Private_Subnets" = "Application"
        }   }
    #------------------------------------------#
}

###################
## END OF MODULE ##
###################
}