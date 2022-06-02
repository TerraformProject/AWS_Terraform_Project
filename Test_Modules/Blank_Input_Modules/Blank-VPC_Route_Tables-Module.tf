module "BLANK_ROUTE_TABLE" {
source = ""

######################
## VPC ROUTE TABLES ##
######################
create_route_tables = false

vpc_id = ""

route_tables = {       
    #---------------------------------------------------#        
    Blank_Route_Table = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = ""
        ## ASSOCIATED SUBNETS ##
        subnet_ids = []
        ## ASSOCIATED ROUTES ##
        propagating_vgws = []
        associated_routes = {
            #---------------------------------------#
            Existing_Internet_Gateway_0 =  {
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
            New_Internet_Gateway_0 =  {
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
            Existing_Egress_Only_Gateway_0 =  {
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
            New_Egress_Only_Gateway_0 =  {
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
            Existing_NAT_Gateway_0 =  {
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
            New_NAT_Gateway_0  =  {
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
            Existing_VPC_Endpoint_0 =  {
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
            New_VPC_Endpoint_0 =  {
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
                            private_dns_enabled = false 
                            policy = "" 
                            security_group_ids = "" 
                    } }   
            }
            #---------------------------------------#
            #---------------------------------------#
            Existing_Network_Interface_0 =  {
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
            New_Network_Interface_0 =  {
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
            Existing_Transit_Gateway_0 =  {
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
            New_Transit_Gateway_Attachment_0 =  {
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
                            subnet_ids = "" # 
                            appliance_mode_support = "" 
                            dns_support = "" 
                            ipv6_support = ""
                    }  }   
            }
            #---------------------------------------#
            #---------------------------------------#
            Existing_Local_Gateway_0 =  {
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
            Existing_VPC_Peering_Connection_0 =  {
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
            New_VPC_Peering_Connection_0 =  {
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
            Existing_Global_Core_Network_0 =  {
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