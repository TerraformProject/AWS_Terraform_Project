module "SUBNETS_ACLS_AWS_PROJECT" {
source = "../Back_End_Modules/VPC_Subnet_ACL-Module"

#########################
## Private VPC SUBNETS ##
#########################
create_new_vpc_subnets = true

vpc_id = module.VPC_AWS_PROJECT.vpc_001_id

vpc_subnets = {
    #---------------------------------------------------#   
    Private_Subnet_1 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "PrivSub_001_VPC_001"
            cidr_block = "172.32.5.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.ROUTE_TABLE_MODULE.Private_Route_Table_1_id 
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false
            get_existing_acl = {
                # vpc_id = 
                # vpc_acl_tag_key =
                # vpc_acl_tag_value = 
            }
            create_new_acl = true
            new_acl_name = "ACL_002_VPC_001"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            #Ingress#
            "Ingress|Allow|IPv4|172.16.5.0/24|tcp|443|443|10",
            "Ingress|Allow|IPv4|172.16.10.0/24|tcp|443|443|30",
            "Ingress|Allow|IPv4|172.16.5.0/24|udp|80|80|50",
            "Ingress|Allow|IPv4|172.16.10.0/24|udp|80|80|70",
            "Ingress|Allow|IPv4|172.48.5.0/24|tcp|3306|3306|90",
            "Ingress|Allow|IPv4|172.48.10.0/24|tcp|3306|3306|110",
            "Ingress|Allow|IPv4|172.48.15.0/24|tcp|3306|3306|130"
            #Egress#
            ]
            new_acl_tags = {"ACLs_VPC_001" = "ACL_002_VPC_001"}
            #- VPC SUBNET TAGS -------------------------#
            new_subnet_tags = { "Private_Subnets_VPC_001" = "PrivSub_001_VPC_001" }
            }
    #---------------------------------------------------#
    #---------------------------------------------------#   
    Private_Subnet_2 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "PrivSub_002_VPC_001"
            cidr_block = "172.32.10.0/24"
            availability_zone = "us-east-1b"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.ROUTE_TABLE_MODULE.Private_Route_Table_2_id 
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = true
            get_existing_acl = {
            # Since the above ACL is created for PrivSub_001_VPC_001, we will that ACL to associate it with this subnet.
                vpc_id = module.VPC_AWS_PROJECT.vpc_001_id
                vpc_acl_tag_key = "ACLs_VPC_001" 
                vpc_acl_tag_value = "ACL_002_VPC_001" 
            }
            create_new_acl = false
            new_acl_name = ""
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            ]
            new_acl_tags = {"" = ""}
            #- VPC SUBNET TAGS -------------------------#
            new_subnet_tags = { "Private_Subnets_VPC_001" = "PrivSub_002_VPC_001" }
            }
    #---------------------------------------------------#

####################################################################################################################################################################################################################

    #---------------------------------------------------#   
    Database_Subnet_1 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "DBSub_001_VPC_001"
            cidr_block = "172.48.5.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.ROUTE_TABLE_MODULE.Database_Route_Table_1_id 
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false
            get_existing_acl = {
                # vpc_id = 
                # vpc_acl_tag_key =
                # vpc_acl_tag_value = 
            }
            create_new_acl = true
            new_acl_name = "ACL_003_VPC_001"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            #Ingress#
            "Ingress|Allow|IPv4|172.32.5.0/24|tcp|3306|3306|10",
            "Ingress|Allow|IPv4|172.32.10.0/24|tcp|3306|3306|30"
            #Egress#
            ]
            new_acl_tags = {"ACLs_VPC_001" = "ACL_003_VPC_001"}
            #- VPC SUBNET TAGS -------------------------#
            new_subnet_tags = { "Database_Subnets_VPC_001" = "DBSub_001_VPC_001" }
    }
    #---------------------------------------------------#
    #---------------------------------------------------#   
    Database_Subnet_2 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "DBSub_002_VPC_001"
            cidr_block = "172.48.10.0/24"
            availability_zone = "us-east-1b"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.ROUTE_TABLE_MODULE.Database_Route_Table_2_id 
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = true
            get_existing_acl = {
            # Since the above ACL is created for PrivSub_001_VPC_001, we will that ACL to associate it with this subnet.
                vpc_id = module.VPC_AWS_PROJECT.vpc_001_id
                vpc_acl_tag_key = "ACLs_VPC_001"
                vpc_acl_tag_value = "ACL_003_VPC_001"
            }
            create_new_acl = false
            new_acl_name = ""
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            ]
            new_acl_tags = {"" = ""}
            #- VPC SUBNET TAGS -------------------------#
            new_subnet_tags = { "Database_Subnets_VPC_001" = "DBSub_002_VPC_001" }
    }
    #---------------------------------------------------#
    #---------------------------------------------------#   
    Database_Subnet_3 = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "DBSub_003_VPC_001"
            cidr_block = "172.48.15.0/24"
            availability_zone = "us-east-1c"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = module.ROUTE_TABLE_MODULE.Database_Route_Table_2_id 
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = true
            get_existing_acl = {
            # Since the above ACL is created for PrivSub_001_VPC_001, we will that ACL to associate it with this subnet.
                vpc_id = module.VPC_AWS_PROJECT.vpc_001_id
                vpc_acl_tag_key = "ACLs_VPC_001"
                vpc_acl_tag_value = "ACL_003_VPC_001"
            }
            create_new_acl = false
            new_acl_name = ""
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            ]
            new_acl_tags = {"" = ""}
            #- VPC SUBNET TAGS -------------------------#
            new_subnet_tags = { "Database_Subnets_VPC_001" = "DBSub_003_VPC_001" }
    }
    #---------------------------------------------------#

}
###################
## END OF MODULE ##
###################
}




