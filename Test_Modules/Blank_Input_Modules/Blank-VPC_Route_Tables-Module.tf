module "BLANK_ROUTE_TABLE" {
source = ""

######################
## VPC ROUTE TABLES ##
######################
create_route_tables = false

vpc_id = false

route_tables = {       
    #---------------------------------------------------#        
    Example_Route_Table = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = ""
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
                #---------------------------------------#
                Route_1 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "internet_gateway"
                            new_target = true
                            target_values = {
                                internet_gateway_name = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_2 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "egress_only_gateway"
                            new_target = true
                            target_values = {
                                egress_only_gateway_name = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_3 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "nat_gateway"
                            new_target = true
                            target_values = {
                                nat_gateway_name = ""
                                subnet_id = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_4 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "vpc_endpoint"
                            new_target = true
                            target_values = {
                                vpc_endpoint_name = ""
                                vpc_endpoint_type = ""
                                service_name = ""
                                auto_accept = false
                                route_table_ids = ""
                                subnet_ids = ""
                                private_dns_enabled = false
                                policy = ""
                                security_group_ids = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_5 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "network_interface"
                            new_target = true
                            target_values = {
                                network_interface_name = ""
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
                            destination_key = ""
                        }
                        target = {
                            type = "transit_gateway"
                            new_target = true
                            target_values = {
                                tgw_attachment_name = ""
                                tgw_id = ""
                                tgw_default_route_table_association = false
                                tgw_default_route_table_propogation = false
                                tgw_route_table_id = ""
                                subnet_ids = ""
                                appliance_mode_support = ""
                                dns_support = ""
                                ipv6_support = ""
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "local_gateway"
                            new_target = true
                            target_values = {
                                new_local_gateway_route_table_vpc_association = false
                                local_gateway_route_table_id = ""
                                new_local_gateway_route = true
                                local_gateway_destination_cidr_block = ""
                                local_gateway_virtual_interface_group_id = "" 
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "vpc_peering_connection"
                            new_target = true
                            target_values = {
                                vpc_peering_connection_name = ""
                                peer_owner_id = ""
                                peer_vpc_id = ""
                                peer_region = ""
                                auto_accept = false
                                requester_accepter = ""
                                allow_remote_vpc_dns_resolution = ""
                                allow_classic_link_to_remote_vpc = ""
                                allow_vpc_to_remote_classic_link = ""
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_7 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "vpc_peering_connection"
                            new_target = true
                            target_values = {
                                vpc_peering_connection_name = ""
                                peer_owner_id = ""
                                peer_vpc_id = ""
                                peer_region = ""
                                auto_accept = false
                                allow_remote_vpc_dns_resolution = ""
                                allow_classic_link_to_remote_vpc = ""
                                allow_vpc_to_remote_classic_link = ""
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_8 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "core_network"
                            new_target = true
                            target_values = {
                                core_network_arn = ""
                        }  }   
                }
                #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "" = ""
        }
    }
    #---------------------------------------------------#
    #---------------------------------------------------#        
    Example_Route_Table_V2 = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = ""
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
                #---------------------------------------#
                Route_1 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "internet_gateway"
                            new_target = false
                            target_values = {
                                internet_gateway_id = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_2 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "egress_only_gateway"
                            new_target = false
                            target_values = {
                                egress_only_gateway_id = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_3 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "nat_gateway"
                            new_target = false
                            target_values = {
                                nat_gateway_id = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_4 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "vpc_endpoint"
                            new_target = false
                            target_values = {
                                vpc_endpoint_id = ""
                        } }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_5 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "network_interface"
                            new_target = false
                            target_values = {
                                network_interface_id = ""
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_5 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "transit_gateway"
                            new_target = false
                            target_values = {
                                existing_tgw_id = ""
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "local_gateway"
                            new_target = false
                            target_values = {
                                local_gateway_id = ""
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_6 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "vpc_peering_connection"
                            new_target = false
                            target_values = {
                                vpc_peering_connection_id = ""
                        }  }   
                }
                #---------------------------------------#
                #---------------------------------------#
                Route_8 =  {
                        destination = {
                            destination_key = ""
                        }
                        target = {
                            type = "core_network"
                            new_target = false
                            target_values = {
                                core_network_arn = ""
                        }  }   
                }
                #---------------------------------------#
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "" = ""
        }
    }
    #---------------------------------------------------#
    
}

###################
## END OF MODULE ##
###################
}