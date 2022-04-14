
# VPC Overview   

Use the following example to use as reference to create a VPC:

[VPC Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

```terraform
    create_vpc = bool # Whether or not to create the VPC
    vpc_name = string # VPC name to be mreged with the tags below
    cidr_block       = string # CIDR block for the VPC
    assign_generated_ipv6_cidr_block = string # Whether or not to assign IPv6 CIDR block to the VPC
    instance_tenancy = string # "default" || "dedicated". Unless big $$$, use default
    enable_dns_support = bool # If DNS resolution is supported. If true DNS servers are @ 169.254.169.253 || base VPC CIDR Block + 2
    enable_dns_hostnames = bool # automaticaly assigns resolvable public DNS hostnames to Public IP addresses
    enable_classiclink = bool # Whether or not allow the creation of a classic link for EC2 classic instances
    enable_classiclink_dns_support = bool # Whether to enable classic link dns support
    
    vpc_tags = {
        "Key" = "Value" # Tags for the VPC
    }
```

# VPC: Associated CIDR Block Overview

Use the example below as reference to associate extra CIDR block for the newly created VPC:

[VPC IPv4 CIDR Block Association Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association)

```terraform
    associate_cidr_blocks = bool # Whether or not to associate the CIDR blocks below with the VPC
    cidr_blocks_associated = list(string) # The CIDR blocks to associate with the VPC
```

# DHCP Options Set Overview 

Use the example below as reference to create a DHCP options set for the VPC:

[DHCP Options Set Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options)

```terraform
    enable_dhcp_options = bool # Whether or not to create a DHCP options set for the VPC
    dhcp_options_set_name = string # Name of DHCP options set to be merged with the tags below
    dhcp_options_domain_name = string # Valid domain name for the DHCP options set
    dhcp_options_domain_name_servers = list(string) # DNS servers to use for DHCP options set
    dhcp_options_ntp_servers = list(string) # NTP servers to use for DHCP Options set
    dhcp_options_netbios_name_servers = list(string)  # netbios name servers to be used for the dhcp options set
    dhcp_options_netbios_node_type = number # Netbios node type to be used for the dhcp options set

    dhcp_options_tags = {
        "Key" = "Value" # Tags to associate with the DHCP options set
    }
```

# Default Route Table / Route Table Overview
 
## Default Route Table 

Use the following example to create a default route table and routes for the VPC:

[Default Route Table Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table)

```terraform
    manage_default_route_table = bool # Whether or not to create a default route table.
    default_route_table_name = string # To be merged with tags below
    default_route_table_id = string # The VPC default route table id to be used
    default_route_table_propagating_vgws = list(string) # List of virtual gateways for propogation
    default_route_table_routes = { # Mapping of map(string) to declare routes
        route_example = {
            DestinationArgumnet(string) = DestinationValue(string)
            TargetArgument(string) = TargetValue(string)
        }
    }

    default_route_table_tags = {
        "Key" = "Value" string # Tags to associate with the default route table
    }
```

## Route Tables 

Use the following example to to create multiple instances of route tables and routes:

[Route Table Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)

```terraform
route_tables = {

        Example_Route_Table = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = string # Name of the Route Table to be merged with the tags below
            vpc_id = striing # VPC ID to place the route table in
            propagating_vgws = list(string) # Specify virtual gateways for automatic routing to VPN connections

            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Route_1 =  {
                    DestinationArgumnet(string) = DestinationValue(string)
                    TargetArgument(string) = TargetValue(string)
                    }
            }

            ## ROUTE TABLE TAGS ##
            tags = {
                "Key" = "Value" # Tags to associate with the route table
                }
        }
}

     # Notes: 
     #    - When specifyiing TargetArguments in the "associated routes" map. Use the KEY from one of the desired entries in the TARGET ROUTES section below to use for a TargetArgument.
     #    - If specifying, network interface or instance as a TargetArgument, input the id of the desired TargetArgument using traditonal ways of referencing resource: module output || direct resource ref || direct id input
     #    - You are able to create multiple instances of route tables, just copy and paste the format for desired number of times.
     #    - Keys for route tables must be unique or else Terraform will process only one route table instance if there are duplicates.
     #    - Use the following format to output specific attributes for a given route table instance:
     #
     #        output "output_value_name" {
     #           value = aws_route_table.route_tables["route_table_key"].attribute
     #       }
```


# Destination Routes Overview 

## VPC Peering Connection 

Use the follwoing example to create as many VPC peering connections as desired:

[ VPC Peering Connection Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection)

```terraform
vpc_peering_connections = {

    Example_Peering_Connetion = {
            peer_owner_id = string # The AWS account ID of the owner for which the peering connection will connect with
            peer_vpc_id = string # ID of the VPC for which you will be creating the peering connection with
            vpc_id = string # The ID of this VPC
            auto_accept = bool # Auto accept peering connection. **Both VPCs must be in the same account for this to be true
            peer_region = bool # The region for which the VPC resides in
            acceptor = {
                allow_remote_vpc_dns_resolution = bool # Allow public to private DNS resolution in the peering connection
                allow_classic_link_to_remote_vpc = bool # Allows outbound communication from local ClassicLink to the remote VPC
                allow_vpc_to_remote_classic_link = bool # Allows for outbound communication from the local VPC to the remote ClassicLink connection
            }
            requester = {
                allow_remote_vpc_dns_resolution = bool # Allow public to private DNS resolution in the peering connection
                allow_classic_link_to_remote_vpc = bool # Allows outbound communication from local ClassicLink to the remote VPC
                allow_vpc_to_remote_classic_link = bool # Allows for outbound communication from the local VPC to the remote ClassicLink connection
            }
            tags = { 
                "key" = "value" # Tags to be assocaited with the VPC peering connection
            }
        }

}
```
## Internet Gateway 

Use the follwoing example to create as many Internet Gateways as desired:

[Internet Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)

```terraform
internet_gateways = {

    Example_Internet_Gateway = {
            igw_name = string # IGW name to be merged with the tags below

            vpc_id = string # VPC ID for where the IGW will reside in

            tags = {
                "Key" = "Value" # Tags to associate with the IGW
            }
        }
    
}
```

## Egress Only Internet Gateways 

Use the follwoing example to create as many Egress Only Internet Gateways as desired:

[Egress Only Internet Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway)

```terraform
egress_internet_gateways = {

    Example_Egress_Only_Internet_Gateway = {
            egress_igw_name = string # Egress only IGW name to be merged with the tags below

            vpc_id = string # VPC ID for where the Egress only IGW will reside in
            
            tags = {
                "Key = "Value" # Tags to associate with the Egress only IGW
            }
        }

}
```

## NAT Gateways 

 Use the follwoing example to create as many NAT Gateways as desired:

[NAT Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)

```terraform
nat_gateways = {

     Example_NAT_Gateway = {
            nat_gateway_name = string # Name of NAT Gateway to be merged with the tags below
            subnet_id =  string # Key of created subnet from section below to associate NAT gateway with. ** Use a Public Subnet 
            create_new_eip = bool # Whether or not to create and associate a new EIP with the NAT Gateway
            new_eip_index = number # Index number of the newly created EIP. See Note below for me clarification...
            eip_allocation_id = string # Specify the ID of an existing EIP to associate with the NAT Gateway. create_new_eip must == false
            
            tags = { "Key" = "Value" } # Tags to associate with the NAT Gateway
            }

}

    # Notes:
    #    new_eip_index - A list of new EIPs is created base upon the number of NAT gateways that specified true for creating a new EIP.
    #                    The index number tells Terraform which EIP amongst that list to associate with each NAT Gateway.
    #                    ** Index starts from 0 not 1!
    #                    Example:
    #
    #                    Example_NAT_Gateway_1 = {
    #                        nat_gateway_name = "" 
    #                        subnet_id =  ""  
    #                        create_new_eip = true 
    #                        new_eip_index = 0 
    #                        eip_allocation_id = ""
    #                        
    #                        tags = { "Key" = "Value" } 
    #                        }
    #
    #                    Example_NAT_Gateway_2 = {
    #                        nat_gateway_name = "" 
    #                        subnet_id =  ""  
    #                        create_new_eip = false 
    #                        new_eip_index = null 
    #                        eip_allocation_id = "Some EIP allocation ID"
    #                        
    #                        tags = { "Key" = "Value" } 
    #                        }
    #                     Example_NAT_Gateway_3 = {
    #                        nat_gateway_name = "" 
    #                        subnet_id =  ""  
    #                        create_new_eip = true 
    #                        new_eip_index = 1 
    #                        eip_allocation_id = ""
    #                        
    #                        tags = { "Key" = "Value" } 
    #                        }
    #
    #                    ** Since there are two NAT Gateway instances that are creating a new EIP "Example_NAT_Gateway_1" will receive the first new EIP. "Example_NAT_Gateway_2" 
    #                       will receive the second new EIP
```
## VPC Endpoints 

Use the follwoing example to create as many VPC Endpoints as desired:

[VPC Endpoint Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)

```terraform
vpc_endpoints = {

        Example_VPC_Endpoint = {
            vpc_endpoint_type = string # Type of VPC Endpoint
            service_name = string # Service name for the VPC Endpoint
            vpc_id = string # VPC ID for where the endpoint will reside in
            auto_accept = bool # Whether or not to auto accept the VPC endpoint. Endpoint & Endpoint Service must be in the same account
            policy = string # Permissions policy to attach to the VPC endpoint. Type must == Interface || Gateway
            private_dns_enabled = bool # Whether or not assocaite a private hosted zone with the specified VPC. Type must == Interface
            route_table_ids = list(string) # One ore more route table IDs to associate with the endpoint. Type must == Gateway
            subnet_ids = list(string) # One or more Subnet IDs to associate with the endpoint. Type must == GatewayLoadBalancer || Interface
            security_group_ids = list(string) # One ore security groups to assocaite with the endpoint. Type muss == Interface

            tags = {
                "key" = "value" # Tags to associate with the VPC Endpoint.
            }
        }

}
```

## Transit Gateways 

Use the follwoing example to create as many Transit Gateways as desired:

[Transit Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway)

```terraform
transit_gateways = {

        Example_Transit_Gateway = {
            description = string # Description of Transit Gateway
            amazon_side_asn = number # ASN for the Amazon side BGP session.  
            auto_accept_shared_attachments = string # Whether resource attachment requests are automatically accepted
            default_route_table_association = string # Whether resource attachments are automatically assocaited with the default route table
            default_route_table_propagation = string # Whether resoure attachments automatically propagate routes to the default propagation route table
            dns_support = string # Whether DNS support is enabled or not
            vpn_ecmp_support = string # Whether VPN Equal Cost Multipath Protocol support is enabled

            tags = {
                "key" = "value" # Tags to associate with the Transit Gateway
            }
        }
    
}
```


# Subnets Overview
 
Use the follwoing example to create as many Subnets with route table associations as desired:

[Subnet Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

```terraform
subnets = {

        Example_Subnet = {
            subnet_name = string # Name of subnet to be merged with the tags below
            vpc_id = string # The VPC ID for which the subnet will reside in
            cidr_block = string # Valid CIDR block for the subnet
            availability_zone = string # Availability Zone for the subnet to be located in
            customer_owned_ipv4_pool = string # Customer owned IPv4 address pool. Must be used with outpost_arn attribute. 
            assign_ipv6_address_on_creation = bool # Whether interfaces provisioned in the subnet should receive an IPv6 address
            ipv6_cidr_block = string # The IPv6 range for the subnet. Must use at least /64 prefix length
            map_customer_owned_ip_on_launch = bool # Whether interface in the subnet should be associated with a customer owner IPv4 address
            map_public_ip_on_launch = bool # Whether interfaces in the subnet shoul automatically receive public IP addresses
            outpost_arn = string # The ARN of the outpost

            route_table_association = string # The route table key from route tables above to associate subnet with the route table 

            tags = {
                "Key" = "Value", # The tags to associate with the subnet
            }
        }

}
```