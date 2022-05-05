module "VPC_AWS_PROJECT" {
source = "../Back_End_Modules/VPC-Module"

##################
## VPC GROUPING ##
############################################################
create_vpc_group = true
vpc_group = {
    #------------------------------------------------------#
    vpc_aws_terraform = {
            vpc_name = "VPC_MAIN"
            #- VPC CIDR BLOCKS ----------------------------#
            cidr_block       = "192.168.0.0/16"
            secondary_ipv4_cidr_blocks = []
            assign_generated_ipv6_cidr_block = false
            #- DNS SETTINGS -------------------------------#
            enable_dns_support = true
            enable_dns_hostnames = true
            #- GATEWAY/ENDPOINT SETTINGS ------------------#
            internet_gateway_name = "IGW_One"
            egress_only_internet_gateway_names = [] 
            nat_gateway_names = ["NATGW1:Public_Subnet_One", "NATGW2:Public_Subnet_Two"]
            #- VPC ROUTE TABLE SETTINGS -------------------#
            vpc_default_route_table_name = "Route_Table_Default"
            vpc_route_tables = {
                #------------------------------------------#
                Main_Route_Table = {
                route_table_name = "Route_Table_Default"
                route_table_tags = { "Public_Route_table" = "One"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                gateway_id = "IGW_One"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Public_Route_Table_1 = {
                route_table_name = "Public_Route_Table_One"
                route_table_tags = { "Public_Route_table" = "One"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                gateway_id = "IGW_One"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Public_Route_Table_2 = {
                route_table_name = "Public_Route_Table_Two"
                route_table_tags = { "Public_Route_table" = "Two"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                gateway_id = "IGW_One"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Private_Route_Table_1 = {
                route_table_name = "Private_Route_Table_One"
                route_table_tags = { "Private_Route_table" = "One"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                nat_gateway_id = "NATGW1"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Private_Route_Table_2 = {
                route_table_name = "Private_Route_Table_Two"
                route_table_tags = { "Private_Route_table" = "Two"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                nat_gateway_id = "NATGW2"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Database_Route_Table_1 = {
                route_table_name = "Database_Route_Table_One"
                route_table_tags = { "Database_Route_table" = "One"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                nat_gateway_id = "NATGW1"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Database_Route_Table_2 = {
                route_table_name = "Database_Route_Table_Two"
                route_table_tags = { "Database_Route_table" = "Two"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                nat_gateway_id = "NATGW2"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
                #------------------------------------------#
                Database_Route_Table_3 = {
                route_table_name = "Database_Route_Table_Three"
                route_table_tags = { "Database_Route_table" = "Three"}
                associated_routes = {
                            #------------------------------#
                            Route_1 = {
                                cidr_block = "0.0.0.0/0"
                                nat_gateway_id = "NATGW2"
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
            }
            #- VPC SUBNET SETTINGS ------------------------#
            vpc_subnets = {
                #------------------------------------------#
                Public_Subnet_1 = {
                    subnet_name = "Public_Subnet_One"
                    availability_zone = "us-east-1a"
                    cidr_block = "192.168.5.0/24"
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = false
                    route_table_name = "Public_Route_Table_One"
                    subnet_tags = { "Public_Subnets" = "One" }
                }
                #-----------------------------------------#
                #------------------------------------------#
                Public_Subnet_2 = {
                    subnet_name = "Public_Subnet_Two"
                    availability_zone = "us-east-1b"
                    cidr_block = "192.168.10.0/24"
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = false
                    route_table_name = "Public_Route_Table_Two"
                    subnet_tags = { "Public_Subnets" = "Two" }
                }
                #-----------------------------------------#
                #------------------------------------------#
                Private_Subnet_1 = {
                    subnet_name = "Private_Subnet_One"
                    availability_zone = "us-east-1a"
                    cidr_block = "192.168.15.0/24"
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = false
                    route_table_name = "Private_Route_Table_One"
                    subnet_tags = { "Private_Subnets" = "One" }
                }
                #-----------------------------------------#
                #------------------------------------------#
                Private_Subnet_2 = {
                    subnet_name = "Private_Subnet_Two"
                    availability_zone = "us-east-1b"
                    cidr_block = "192.168.20.0/24"
                    ipv6_cidr_block = ""
                    assign_ipv6_address_on_creation = false
                    map_public_ip_on_launch = false
                    route_table_name = "Private_Route_Table_Two"
                    subnet_tags = { "Private_Subnets" = "Two" }
                }
                #-----------------------------------------#
            }
            #- DEFAULT ACL SETTINGS ----------------------#
            default_acl = {
                #-----------------------------------------#
                acl_name = "Default_ACL"
                acl_rules = [
                # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
                ] 
                #-----------------------------------------#
            }
            #- DEFAULT SECURITY GROUP SETTINGS -----------#
            default_security_group = {
                #-----------------------------------------#
                security_group_name = "Default_Security_Group"
                security_group_rules = [
                # "Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
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