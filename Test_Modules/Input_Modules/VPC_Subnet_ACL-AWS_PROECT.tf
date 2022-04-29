module "SUBNETS_ACLS_AWS_PROJECT" {
source = "../Back_End_Modules/VPC_Subnet_ACL-Module"

#################
## VPC SUBNETS ##
#################
create_new_vpc_subnets = true

vpc_id = module.VPC_AWS_PROJECT.vpc_aws_terraform_id

vpc_subnets = {
    #---------------------------------------------------#   
    Database_Subnet_1 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "Database_Subnet_1"
            cidr_block = "192.168.25.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.VPC_AWS_PROJECT.Database_Route_Table_One_id
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false
            get_existing_acl = {
                # vpc_id = 
                # vpc_acl_tag_key =
                # vpc_acl_tag_value = 
            }
            create_new_acl = true
            new_acl_name = "Database_Subnet_One_acl"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            "Ingress|Allow|IPv4|0.0.0.0/0|tcp|3306|3306|30",
            "Egress|Allow|IPv4|0.0.0.0/0|tcp|3306|3306|30"
            ]
            #- VPC SUBNET TAGS -------------------------#
            tags = {
                "Database_Subnet" = "One",
                }
            }
    #---------------------------------------------------#
    #---------------------------------------------------#   
    Database_Subnet_2 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "Database_Subnet_2"
            cidr_block = "192.168.30.0/24"
            availability_zone = "us-east-1b"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.VPC_AWS_PROJECT.Database_Route_Table_Two_id
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = true
            get_existing_acl = {
                vpc_id = module.VPC_AWS_PROJECT.vpc_aws_terraform_id
                vpc_acl_tag_key = "Database_Subnet"
                vpc_acl_tag_value = "One"
            }
            create_new_acl = false
            new_acl_name = "Database_Subnet_Two_acl"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
           # "Ingress|Allow|IPv4|0.0.0.0/0|udp|80|80|30"
            ]
            #- VPC SUBNET TAGS -------------------------#
            tags = {
                "Database_Subnet" = "Two",
                }
            }
    #---------------------------------------------------#
    Database_Subnet_3 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "Database_Subnet_3"
            cidr_block = "192.168.35.0/24"
            availability_zone = "us-east-1c"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.VPC_AWS_PROJECT.Database_Route_Table_Three_id
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = true
            get_existing_acl = {
                vpc_id = module.VPC_AWS_PROJECT.vpc_aws_terraform_id
                vpc_acl_tag_key = "Database_Subnet"
                vpc_acl_tag_value = "One"
            }
            create_new_acl = false
            new_acl_name = "Database_Subnet_Three"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            # "Ingress|Allow|IPv4|0.0.0.0/0|udp|80|80|30"
            ]
            #- VPC SUBNET TAGS -------------------------#
            tags = {
                "Database_Subnet" = "Three",
                }
            }
    #---------------------------------------------------#
}

###################
## END OF MODULE ##
###################  
}