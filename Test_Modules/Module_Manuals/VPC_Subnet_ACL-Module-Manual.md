module "Blank_SUBNET_ACL_MODULE" {
source = ""

#################
## VPC SUBNETS ##
#################
create_new_vpc_subnets = false # Whether or not to create new VPC subnets and associated ACLs

vpc_id = "" # The VPC where these subnets and ACLs will be located in

vpc_subnets = {
# ABLE TO CREATE MORE THAN ONE #
    #---------------------------------------------------#   
    Example_Subnet = { <- If creating more than one subnet, this index key must be unique
            #- VPC SUBNET SETTINGS ---------------------#
            subnet_name = "" # Name of the subnet to be merged with tags
            cidr_block = "" # The Valid CIDR block to assign to the subnet 
            availability_zone = "" # Name of the availability zone to create this subnet in
            customer_owned_ipv4_pool = "" # The customer owned IPv4 pool to use. "outpost_arn" must be specified. Usually used with "map_customer_owned_ip_on_launch" 
            assign_ipv6_address_on_creation = false # Whether or not to assign ipv6 addresses to instances created in the subnets
            ipv6_cidr_block = "" # The ipv6 CIDR block to assign to the subnet
            map_customer_owned_ip_on_launch = false # Whether or not map the customer owned IP addresses to the subnet
            map_public_ip_on_launch = false # Whether or not a map a public IP address to instances created in the subnet
            outpost_arn = "" # The ARN of the Outpost to apply to this subnet
            #- VPC SUBNET ASSOCIATIONS -----------------#
            route_table_association = "" # The ID of the route table to associate to this subnet.
            #- VPC SUBNET ACL --------------------------#
            use_existing_acl = false # Whether or not to apply an exsiting ACL to the subnet
            get_existing_acl = { 
                vpc_id = "" # The VPC ID where the ACL is located to apply to the subnet
                vpc_acl_tag_key = ""
                vpc_acl_tag_value = "" 
            }
            create_new_acl = false
            new_acl_name = ""
            new_acl_rules = [
            # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
            ]
            new_acl_tags = { "" = "" }
            #- VPC SUBNET TAGS -------------------------#
            new_subnet_tags = { "" = "" }
            }
    #---------------------------------------------------#
}

###################
## END OF MODULE ##
###################  
}