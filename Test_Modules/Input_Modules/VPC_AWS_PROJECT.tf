module "VPC_AWS_PROJECT" {
source = "../Back_End_Modules/VPC-Module"

##################
## VPC GROUPING ##
############################################################
create_vpc_group = true
vpc_group = {
        #--------------------------------------------------#
        Example_VPC = {
            vpc_name = "VPC_ONE"
            #- VPC CIDR BLOCKS ----------------------------#
            cidr_block       = "172.16.0.0"
            secondary_ipv4_cidr_blocks = []
            assign_generated_ipv6_cidr_block = false
            #- DNS SETTINGS -------------------------------#
            enable_dns_support = true
            enable_dns_hostnames = true
            #- INTERNET GATEWAY SETTINGS ------------------#
            internet_gateway_names = ["IGW_One"]
            #- VPC ROUTE TABLE SETTINGS -------------------#
            vpc_route_tables = {
                    #--------------------------------------#
                    Example_Route_Table = {
                        route_table_name = "Route_Table_One"
                        associated_routes = {
                            #------------------------------#
                            Example_Route_1 = {
                                cidr_block = "0.0.0.0"
                                gateway_id = "IGW_One"
                            }
                            #------------------------------#
                    }   }
                    #--------------------------------------#
            }
            #- VPC SUBNET SETTINGS ------------------------#
            vpc_subnets = {
                    #--------------------------------------#
                    Example_Subnet = {
                        subnet_name = "Subnet_One"
                        availability_zone = "us-east-1"
                        cidr_block = "192.168.0.0/24"
                        ipv6_cidr_block = ""
                        assign_ipv6_address_on_creation = false
                        map_public_ip_on_launch = false
                        route_table_name = "Example_Route_Table"
                    }
                    #-------------------------------------#
            }
        }
        #-------------------------------------------------#      
}
###########################################################

###################
## END OF MODULE ##
###################
}