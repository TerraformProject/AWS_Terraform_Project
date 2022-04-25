module "VPC_AWS_PROJECT" {
source = "../Back_End_Modules/VPC-Module"

##################
## VPC GROUPING ##
############################################################
create_vpc_group = true
vpc_group = {
    #------------------------------------------------------#
    Example1_VPC = {
            vpc_name = "VPC_ONE"
            #- VPC CIDR BLOCKS ----------------------------#
            cidr_block       = "172.16.0.0/16"
            secondary_ipv4_cidr_blocks = []
            assign_generated_ipv6_cidr_block = false
            #- DNS SETTINGS -------------------------------#
            enable_dns_support = true
            enable_dns_hostnames = true
            #- VPC ROUTE TABLE SETTINGS -------------------#
            vpc_default_route_table_name = "Route_Table_Default"
            vpc_route_tables = {
                #------------------------------------------#
                Example_Route_Table = {
                route_table_name = "Route_Table_Default"
                associated_routes = {
                            #------------------------------#
                            Route_1 = {}
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Example2_Route_Table = {
                route_table_name = "Route_Table_One"
                associated_routes = {
                            #------------------------------#
                            Example_Route_1 = {
                                cidr_block = "0.0.0.0"
                                gateway_id = "IGW_One"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
            }
            #- GATEWAY/ENDPOINT SETTINGS ------------------#
            internet_gateway_names = ["IGW_One"]
            egress_only_internet_gateway_names = ["Egress-IGW1"] 
            nat_gateway_names = ["NATGW1:Subnet_One"]
            #- VPC SUBNET SETTINGS ------------------------#
            vpc_subnets = {
                #------------------------------------------#
                Example1_Subnet = {
                    subnet_name = "Subnet_One"
                    availability_zone = "us-east-1"
                    cidr_block = "192.168.5.0/24"
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = false
                    route_table_name = "Route_Table_One"
                }
                #-----------------------------------------#
                #-----------------------------------------#
                Example2_Subnet = {
                    subnet_name = "Subnet_2"
                    availability_zone = "us-east-1"
                    cidr_block = "192.168.10.0/24"
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = false
                    route_table_name = "Route_Table_One"
                }
                #-----------------------------------------#
            }
            #- DEFAULT ACL SETTINGS ----------------------#
            default_acl = {
                #-----------------------------------------#
                acl_name = "Default_ACL"
                acl_rules = [
                # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
                "Ingress|Deny|IPv4|0.0.0.0/0|-1|0|0|10",
                "Egress|Deny|IPv4|0.0.0.0/0|-1|0|0|10",
                ] 
                #-----------------------------------------#
            }
            #- DEFAULT SECURITY GROUP SETTINGS -----------#
            default_security_group = {
                #-----------------------------------------#
                security_group_name = "Default_Security_Group"
                security_group_rules = [
                # "Direction|Type|[Type_Value]|Protocol|FromPort|ToPort|RuleName"
                "Ingress|IPv4|0.0.0.0/0|tcp|80|80|InIPv4_HTTP_port_80",
                "Egress|IPv4|0.0.0.0/0|tcp|80|80|OutIPv4_HTTP_port_80"
                ]
                #-----------------------------------------#
            }
        }
    #-----------------------------------------------------#      
}
###########################################################


###################
## END OF MODULE ##
###################
}