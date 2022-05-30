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
                        } }   
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
                        } }   
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
                        } }   
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
                        } }   
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
                                network_interface_name = "test"
                                description = ""
                                interface_type = "efa"
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
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_5 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "transit_gateway"
                            new_target = true
                            target_values = {
                                tgw_attachment_name = "test_tgw"
                                tgw_id = "tgw_id"
                                tgw_default_route_table_association = false
                                tgw_default_route_table_propogation = false
                                tgw_route_table_id = "tgw_route_table_id"
                                subnet_ids = "subnet1, subnet2, subnet3"
                                appliance_mode_support = "disable"
                                dns_support = "disable"
                                ipv6_support = "disable"
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "local_gateway"
                            new_target = true
                            target_values = {
                                new_local_gateway_route_table_vpc_association = false
                                local_gateway_route_table_id = "yup"
                                new_local_gateway_route = true
                                local_gateway_destination_cidr_block = "0.0.0.0/0"
                                local_gateway_virtual_interface_group_id = "yup" 
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "vpc_peering_connection"
                            new_target = true
                            target_values = {
                                vpc_peering_connection_name = "test_peer_connection"
                                peer_owner_id = "yuh"
                                peer_vpc_id = "yuh"
                                peer_region = "duh"
                                auto_accept = false
                                requester_accepter = "accepter"
                                allow_remote_vpc_dns_resolution = "accepter/requester"
                                allow_classic_link_to_remote_vpc = "accepter"
                                allow_vpc_to_remote_classic_link = "requester"
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_7 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "vpc_peering_connection"
                            new_target = true
                            target_values = {
                                vpc_peering_connection_name = "test_peer_connection_v2"
                                peer_owner_id = "yuh2"
                                peer_vpc_id = "yuh2"
                                peer_region = "duh2"
                                auto_accept = false
                                allow_remote_vpc_dns_resolution = "requester/accepter"
                                allow_classic_link_to_remote_vpc = "requester"
                                allow_vpc_to_remote_classic_link = "accepter"
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_8 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "core_network"
                            new_target = true
                            target_values = {
                                core_network_arn = "test_core_network_arn"
                        }  }   
                }
                #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "test" = "test"
        }
    }
    #---------------------------------------------------#
    #---------------------------------------------------#        
    Example_Route_Table_V2 = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = "test_route_table_V2"
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
                            new_target = false
                            target_values = {
                                internet_gateway_id = "test_IGW_ID"
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_2 =  {
                        destination = {
                            ipv6_cidr_block = "::/0"
                        }
                        target = {
                            type = "egress_only_gateway"
                            new_target = false
                            target_values = {
                                egress_only_gateway_id = "test_egress_only_gtwy_id"
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_3 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "nat_gateway"
                            new_target = false
                            target_values = {
                                nat_gateway_id = "nat_gateway_ID_test_V2"
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_4 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "vpc_endpoint"
                            new_target = false
                            target_values = {
                                vpc_endpoint_id = "vpc_endpoint_ID_test_V2"
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_5 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "network_interface"
                            new_target = false
                            target_values = {
                                network_interface_id = "test_network_interface_ID_V2"
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_5 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "transit_gateway"
                            new_target = false
                            target_values = {
                                existing_tgw_id = "tgw_id"
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "local_gateway"
                            new_target = false
                            target_values = {
                                local_gateway_id = "test_local_gateway_id"
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "vpc_peering_connection"
                            new_target = false
                            target_values = {
                                vpc_peering_connection_id = "test_peer_connection_v3"
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_8 =  {
                        destination = {
                            ipv4_cidr_block = "0.0.0.0/0"
                        }
                        target = {
                            type = "core_network"
                            new_target = false
                            target_values = {
                                core_network_arn = "test_core_network_arn_V2"
                        }  }   
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