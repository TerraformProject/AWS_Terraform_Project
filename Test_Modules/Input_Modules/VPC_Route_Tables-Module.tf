module "ROUTE_TABLE_MODULE" {
source = "../Back_End_Modules/VPC_Route_Tables-Module"

######################
## VPC ROUTE TABLES ##
######################
create_route_tables = true

vpc_id = module.VPC_AWS_PROJECT.vpc_aws_terraform_id

route_tables = {       
    #---------------------------------------------------#        
    Example_Route_Table = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = "test_route_table"
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
                #---------------------------------------#
                Route_1 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "internet_gateway"
                            new_target = true
                            target_values = {
                                internet_gateway_name = "internet_gateway_1"
                            }
                        }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_2 =  {
                            destination = {
                                ipv6_cidr_block = "::/0"
                            }
                            target = {
                                type = "egress_only_gateway"
                                new_target = true
                                target_values = {
                                    egress_only_gateway_name = "egress_gatewat_v1"
                                }
                            }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_3 =  {
                            destination = {
                                ipv4_cidr_block = "0.0.0.0/0"
                            }
                            target = {
                                type = "nat_gateway"
                                new_target = true
                                target_values = {
                                    nat_gateway_name = "nat_gateway_test"
                                    subnet_id = module.VPC_AWS_PROJECT.Public_Subnet_One_id
                                }
                            }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_4 =  {
                            destination = {
                                ipv4_cidr_block = "0.0.0.0/0"
                            }
                            target = {
                                type = "vpc_endpoint"
                                new_target = true
                                target_values = {
                                    vpc_endpoint_name = "vpc_endpoint_test"
                                    vpc_endpoint_type = "Gateway"
                                    service_name = "test"
                                    auto_accept = false
                                    route_table_ids = "test"
                                    subnet_ids = "test"
                                    private_dns_enabled = false
                                    policy = ""
                                    security_group_ids = "test"
                                }
                            }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_5 =  {
                            destination = {
                                ipv4_cidr_block = "0.0.0.0/0"
                            }
                            target = {
                                type = "network_interface"
                                new_target = true
                                target_values = {
                                    network_interface_name = ""
                                    description = ""
                                    interface_type = ""
                                    source_dest_check = false
                                    subnet_id       = ""
                                    ipv4_prefix_count = 0
                                    ipv4_prefixes = ""
                                    private_ip_list_enabled = false
                                    private_ip_list = ""
                                    private_ips = ""
                                    private_ips_count = 0
                                    ipv6_address_list_enabled = false
                                    ipv6_prefixes = ""
                                    ipv6_address_list = ""
                                    ipv6_addresses = ""
                                    ipv6_prefix_count = 0
                                    security_groups = ""
                                    instance_id = ""
                                    device_index = 0
                                }
                            }   
                }
                #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "test" = "test"
        }
    }
    #---------------------------------------------------#
    
}

###################
## END OF MODULE ##
###################
}