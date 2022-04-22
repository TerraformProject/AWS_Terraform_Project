module "Blank_VPC" {
source = ""

##################
## VPC GROUPING ##
########################################################
create_vpc_group = false
vpc_group = {
    #--------------------------------------------------#
    Example_VPC = {
        vpc_name = ""
        #- VPC CIDR BLOCKS ----------------------------#
        cidr_block       = ""
        assign_generated_ipv6_cidr_block = false
        associate_cidr_blocks = false
        cidr_blocks_associated = []
        #- DNS SETTINGS -------------------------------#
        enable_dns_support = false
        enable_dns_hostnames = false
        #- DHCP SETTINGS ------------------------------# 

        #- VPC ROUTE TABLE SETTINGS -------------------#
        vpc_route_tables = {
                #--------------------------------------#
                Example_Route_Table = {
                route_table_name = ""
                associated_routes = {
                        #------------------------------#
                        Example_Route_1 = {
                            cidr_block = ""
                            gateway_id = ""
                        }
                        #------------------------------#
                }}
                #--------------------------------------#
        }
        #- VPC SUBNET SETTINGS ------------------------#
        vpc_subnets = {
                #--------------------------------------#
                Example_Subnet = {
                    availability_zone = ""
                    cidr_block = ""
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = ""
                    route_table_association = ""
                }
                #--------------------------------------#
        }
    }
    #--------------------------------------------------#      
}
########################################################











###################
## END OF MODULE ##
###################
}