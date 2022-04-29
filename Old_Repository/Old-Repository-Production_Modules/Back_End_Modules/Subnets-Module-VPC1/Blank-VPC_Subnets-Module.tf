module "Blank_SUBNETS_MODULE" {
source = ""

#################
## VPC SUBNETS ##
#################
subnets = {
    #####################################################   
    Example_Subnet = {
        ## VPC SUBNET SETTINGS ##
        subnet_name = ""
        vpc_id = ""
        cidr_block = ""
        availability_zone = ""
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""
        ## VPC SUBNET ASSOCIATIONS ##
        route_table_association = ""
        ## VPC SUBNET TAGS ##
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