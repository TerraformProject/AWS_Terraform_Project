module "SUBNETS_ACLS_MODULE" {
source = "../Back_End_Modules/VPC-Subnet-ACL-Module"

#################
## VPC SUBNETS ##
#################
create_new_vpc_subnets = true

vpc_id = "vpc-b46da2c9"

vpc_subnets = {
    #---------------------------------------------------#   
    Example_Subnet = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "Test_Subnet"
            cidr_block = "172.31.5.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            #route_table_association = ""
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false
            get_existing_acl = {
                # vpc_id = 
                # vpc_acl_tag_key =
                # vpc_acl_tag_value = 
            }
            create_new_acl = true
            new_acl_name = "test_acl"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            "Ingress|Allow|IPv4|0.0.0.0/0|udp|80|80|30"
            ]
            #- VPC SUBNET TAGS -------------------------#
            tags = {
                "test" = "subnet",
                }
            }
    #---------------------------------------------------#
    #---------------------------------------------------#   
    Example2_Subnet = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "Test2_Subnet"
            cidr_block = "172.31.10.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            #route_table_association = ""
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false
            get_existing_acl = {
                # vpc_id = 
                # vpc_acl_tag_key =
                # vpc_acl_tag_value = 
            }
            create_new_acl = true
            new_acl_name = "test2_acl"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            "Ingress|Allow|IPv4|0.0.0.0/0|udp|80|80|30"
            ]
            #- VPC SUBNET TAGS -------------------------#
            tags = {
                "test2" = "subnet",
                }
            }
    #---------------------------------------------------#
    Example3_Subnet = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "Test3_Subnet"
            cidr_block = "172.31.15.0/24"
            availability_zone = "us-east-1a"
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            #route_table_association = ""
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false
            get_existing_acl = {
                # vpc_id = 
                # vpc_acl_tag_key =
                # vpc_acl_tag_value = 
            }
            create_new_acl = true
            new_acl_name = "test3_acl"
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            "Ingress|Allow|IPv4|0.0.0.0/0|udp|80|80|30"
            ]
            #- VPC SUBNET TAGS -------------------------#
            tags = {
                "test3" = "subnet",
                }
            }
    #---------------------------------------------------#
}

###################
## END OF MODULE ##
###################  
}