# VPC Route Tables Module    
   
## Route Table Template    

```Terraform

#---------------------------------------------------#        
    Route_Table_Template = {
        ## VPC ROUTE TABLE SETTIINGS ##
        route_table_name = "" # Name of the Route Table to be merged with the tags
        ## ASSOCIATED ROUTES ##
        propagating_vgws = [] # A list of virtual gateways for propagation
        associated_routes = {
            ## NOTE: Able to specify more than one route. The route key must be unique.
            ## NOTE: The destination key and value must be specfied by on of the following.
                    cidr_block | ipv6_cidr_block | destination_prefix_list_id
        }
        ## ROUTE TABLE TAGS ##
        route_table_tags = {
            "" = "" # Tags to associate with the route table 
        }
    }
    #---------------------------------------------------#     

```

## Route Table Routes    
   
### Internet Gateway    

```Terraform
    #---------------------------------------#
    [0]_Existing_Internet_Gateway =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "internet_gateway" # Specify "internet_gateway" to associate the route to an internet gateway
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    internet_gateway_id = "" # The ID of the existing internet gateway to associate with the route
            } }   
    }
    #---------------------------------------#
    #---------------------------------------#
    [0]_New_Internet_Gateway =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "internet_gateway" # Specify "internet_gateway" to create an internet gateway resource and associate it with the route
                new_target = true # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    internet_gateway_name = "" # Name of the new internet gateway resource to be associated with the route
            } }   
    }
    #---------------------------------------#

```

### Egress-Only Internet Gateway    

```Terraform
    #---------------------------------------#
    [0]_Existing_Egress_Only_Gateway =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "egress_only_gateway" # Specify "egress_only_gateway" to associate the route to an egress only gateway
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    egress_only_gateway_id = "" # The ID of the existing egress only gateway to associate with the route
            } }   
    }
    #---------------------------------------#
    #---------------------------------------#
    [0]_New_Egress_Only_Gateway =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "egress_only_gateway" # Specify "egress_only_gateway" to create an egress only gateway resource and associate it with the route
                new_target = true # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    egress_only_gateway_name = "" # Name of the new egress only internet gateway resource to be associated with the route
            } }   
    }
    #---------------------------------------#
```
### NAT Gateway

```Terraform
    #---------------------------------------#
    [0]_Existing_NAT_Gateway =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "nat_gateway" # Specify "nat_gateway" to associate the route to a nat gateway
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    nat_gateway_id = "" # The ID of the existing nat gateway to associate with the route
            } }   
    }
    #---------------------------------------#
    #---------------------------------------#
    [0]_New_NAT_Gateway  =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "nat_gateway" # Specify "nat_gateway" to create a NAT gateway resource and associate it with the route
                new_target = true # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    nat_gateway_name = "" # Name of the new NAT Gateway resource to be associated with the route
                    subnet_id = "" # The subnet ID for the new NAT Gateway resource to be placed in
            } }   
    }
    #---------------------------------------#
```

### VPC Endpoint

```Terraform
    #---------------------------------------#
    [0]_Existing_VPC_Endpoint =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "vpc_endpoint" # Specify "vpc_endpoint" to associate the route to a vpc endpoint
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    vpc_endpoint_id = "" # The ID of the existing vpc endpoint to associate with the route
            } }   
    }
    #---------------------------------------#
    #---------------------------------------#
    [0]_New_VPC_Endpoint =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "vpc_endpoint" # Specify "vpc_endpoint" to create a VPC Endpoint resource and associate it with the route
                new_target = true # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    vpc_endpoint_name = "" # Name of the new VPC endpoint interface to be associated with the route
                    vpc_endpoint_type = "" # The VPC endpoint type. Gateway | GatewayLoadBalancer | Interface
                    service_name = "" # The name of the service to route traffic to
                    auto_accept = false # Whether or not to auto-accept the VPC endpoint. Must be in the same AWS account
                    private_dns_enabled = false # Whether or not to associate a private hosted zone with the specified VPC. Applicable on to type "Interface" amd AWS Services/Marketplace only
                    policy = "" # Policy to attach to the endpoint that controls access to the service. All Gateway and some Interface endpoints support policies. This is a JSON formatted string for the value
                    security_group_ids = "" # The ID of one or more security groups to associate with the endpoint. Interface type only

            NOTE: The following attributes have been specified with these elements for the creation of this resource.
                route_table_ids = ""
                subnet_ids = ""
            
            } }   
    }
    #---------------------------------------#
```

### Network Interface

```Terraform
    #---------------------------------------#
    [0]_Existing_Network_Interface =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "network_interface" # Specify "network_interface" to associate the route to a network interface
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    network_interface_id = "" # The ID of the existing network interface to associate with the route
            }  }   
    }
    #---------------------------------------#
    #---------------------------------------#
    [0]_New_Network_Interface =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "network_interface" # Specify "network_interface" to create a network interface resource and associate it with the route
                new_target = true # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    network_interface_name = "" # Name of the new network interface resource to be associate with the route
                    description = "" # Description of the network interface
                    interface_type = "efa" # Interface type. Changing this will cause interface to be desstroyed then re-created
                    source_dest_check = false # Whether to enable source destination checking for the interface
                    subnet_id       = "" # The subnet ID for the Interface to be created in
                    ipv4_prefix_count = 0 # Number of IPV4 prefixes that AWS auto-assigns to the interface. Conflicts with "ipv4_prefixes"
                    ipv4_prefixes = "" # One or more IPv4 prefixes assigned to the interface. List is specfied as string. Ex- "Prefix1, Prefix2, Prefix3"
                    private_ip_list_enabled = false # Whether "private_ip_list" is allowed and controls the IPs to assign to the ENI and "private_ips" and "private_ips_count" become read-only
                    private_ip_list = "" # List of private IPs to assign to the ENI in sequential order. "private_ip_list_enable" must be true, List is specfied as string. Ex- "IP 1, IP 2, IP 3"
                    private_ips = "" # List of private IPs to assign to the ENI without regard to order. List is specfied as string. Ex- "IP 1, IP 2, IP 3"
                    private_ips_count = 0 # Number of secondary private IPs to assign to the ENI
                    ipv6_address_list_enabled = false # Whether "ipv6_address_list" is allowed and controls the IPs to assign to the ENI and "ipv6_addresses" and "ipv6_addresses_count" become read-only
                    ipv6_prefixes = "" # One or more IPv6 prefixes that assigned to the ENI. List is specfied as string. Ex- "Prefix1, Prefix2, Prefix3"
                    ipv6_address_list = "" # List of private IPs to assign to the ENI in sequestial order. List is specfied as string. Ex- "IP 1, IP 2, IP 3"
                    ipv6_addresses = "" # One or more specific IPv6 addresses for IPv6 CIDR block range of your subnet. Assigned without regard to order. Conflicts with "ipv6_address_count". List is specfied as string. Ex- "IP 1, IP 2, IP 3"
                    ipv6_prefix_count = 0 # Number of IPv6 prefixes that AWS auto-assigns to the ENI
                    security_groups = "" # One or security group IDs to assign to the ENI. List is specified as string. Ex - "SecGrp1, SecGrp2, SecGrp3"
                    instance_id = "" # The ID of the instance to assign this ENI to
                    device_index = 0 # The index of the ENI upon being assigned to an instance
            }  }   
    }
    #---------------------------------------#
```

### Transit Gateway

```Terraform
    #---------------------------------------#
    [0]_Existing_Transit_Gateway =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "transit_gateway" # Specify "transit_gateway" to associate the route to a transit gateway
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    existing_tgw_id = "" # The ID of the existing transit gateway to associate with the route
            }  }   
    }
    #---------------------------------------#
    #---------------------------------------#
    [0]_New_Transit_Gateway_Attachment =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "transit_gateway" # Specify "transit_gateway" to create a Transit Gateway Attachment resource and associate it with the route
                new_target = true # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    tgw_attachment_name = "" # Name of the new transit gateway attachment to be associated with the route
                    tgw_id = "" # The transit gateway ID to associate this route to
                    tgw_default_route_table_association = false # Whether or not if this attachement should be associated with the default transit gateway route table
                    tgw_default_route_table_propogation = false # Whether or not if this attachement should be associated with the default transit gateway propagation route table
                    tgw_route_table_id = "" # ID of the specific route table for this route to be associate with
                    subnet_ids = "" # 
                    appliance_mode_support = "" # Whether or not appliance mode support is enabled
                    dns_support = "" # Whether DNS support is enabled
                    ipv6_support = ""Whether IPv6 support is enabled
            }  }   
    }
    #---------------------------------------#
```

### Local Gateway

```Terraform
    #---------------------------------------#
    [0]_Existing_Local_Gateway =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "local_gateway" # Specify "local_gateway" to associate the route to a local gateway
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    local_gateway_id = "" # The ID of the existing local gateway to associate with the route
            }  }   
    }
    #---------------------------------------#
```

### VPC Peering Connection Attachment

```Terraform
    #---------------------------------------#
    [0]_Existing_VPC_Peering_Connection =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "vpc_peering_connection" # Specify "vpc_peering_connection" to associate the route to a vpc peering connection 
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    vpc_peering_connection_id = "" # The ID of the existing VPC Peering connection to associate with the route
            }  }   
    }
    #---------------------------------------#
    #---------------------------------------#
    [0]_New_VPC_Peering_Connection =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "vpc_peering_connection" # Specify "vpc_peering_connection" to create a VPC Peering Connection resource and associate it with the route
                new_target = true # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    vpc_peering_connection_name = "" # Name of the new VPC Peering Connection to associate with the route
                    peer_owner_id = "" # ID of the account owner for the peer account
                    peer_vpc_id = "" # ID of the peer VPC
                    peer_region = "" # Region the peer VPC is located in. "auto_accept must = false and the "aws_vpc_peering_connection_accepter" must be used
                    auto_accept = false # Whether or not to auto-accept the VPC peering. VPCs must be in the same region and account to apply
                    allow_remote_vpc_dns_resolution = "" # Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried/ Can specify requester | requester/accepter | accepter
                    allow_classic_link_to_remote_vpc = "" # Allow a local linked EC2-Classic instance to communicate with instances in the peer VPC. Enables an outbound communication from the local ClasicLink connection to the remote VPC. Can specify requester | requester/accepter | accepter
                    allow_vpc_to_remote_classic_link = "" # Allow a local VPC to communicate with a linked EC3-Classic instance in a peer VPC. This enableds an outbound communication from the local VPC to the remote ClassicLink connection. Can specify requester | requester/accepter | accepter
            }  }   
    }
    #---------------------------------------#
```

### Global Core Network 

```Terraform
    #---------------------------------------#
    [0]_Existing_Global_Core_Network =  {
            destination = {
                destination_key = ""
            }
            target = {
                type = "core_network" # Specify "core_network" to associate the route to a global core network
                new_target = false # Whether or not a new target resource should be created and associated with the route
                target_values = {
                    core_network_arn = "" The ARN of the existing core network to associate with the route
            }  }   
    }
    #---------------------------------------#
```