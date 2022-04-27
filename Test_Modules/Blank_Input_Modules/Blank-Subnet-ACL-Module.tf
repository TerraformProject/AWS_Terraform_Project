module "Blank_SUBNETS_MODULE" {
source = ""

#################
## VPC SUBNETS ##
#################
create_new_vpc_subnets = true

vpc_id = ""

vpc_subnets = {
    #####################################################   
    Example_Subnet = {
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = ""
            cidr_block = ""
            availability_zone = ""
            customer_owned_ipv4_pool = "" 
            assign_ipv6_address_on_creation = false
            ipv6_cidr_block = ""
            map_customer_owned_ip_on_launch = false
            map_public_ip_on_launch = false
            outpost_arn = ""
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = ""
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false
            get_existing_acl = {
                # vpc_id = 
                # vpc_acl_tag_key =
                # vpc_acl_tag_value = 
            }
            create_new_acl = true
            new_acl_name = ""
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            ]
            #- VPC SUBNET TAGS -------------------------#
            tags = {
                "" = "",
                }
            }
    #####################################################
}

###################
## END OF MODULE ##
###################  
}