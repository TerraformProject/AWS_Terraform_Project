
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

# AWS Route Tables   
 
### Default Route Table 

**Use the following example to create a default route table and routes for the VPC.**

[AWS Documentation: Default Route Table Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)     
      
[HashiCorp Terraform Documentation: Default Route Table Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table)

```terraform
#############################
## VPC DEFAULT ROUTE TABLE ##
#############################

    ## VPC DEFAULT ROUTE TABLE SETTINGS ##
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
    ## VPC DEFAULT ROUTE TABLE TAGS ##
    default_route_table_tags = {
        "Key" = "Value" string # Tags to associate with the default route table
    }
```

### Route Tables 

**Use the following example to to create multiple instances of route tables and routes.**

[AWS Documentation: Route Table Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)   
    
[HashiCorp Terraform Documentation: Route Table Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)

```terraform
######################
## VPC ROUTE TABLES ##
######################
route_tables = {
        #####################################################
        Example_Route_Table = {
            ## VPC ROUTE TABLE SETTIINGS ##
            route_table_name = string # Name of the Route Table to be merged with the tags below
            vpc_id = striing # VPC ID to place the route table in
            propagating_vgws = list(string) # Specify virtual gateways for automatic routing to VPN connections
            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Example_Route_1 =  {
                    DestinationArgumnet(string) = DestinationValue(string)
                    TargetArgument(string) = TargetValue(string)
                }
            }
            ## ROUTE TABLE TAGS ##
            tags = {
                "Key" = "Value" # Tags to associate with the route table
            }
        }
        #####################################################
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

# AWS VPC Subnets
 
**Use the follwoing example to create as many Subnets with route table associations as desired.**

[AWS Documentation: Subnet Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)

[HashiCorp Terraform: Subnet Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

```terraform
#################
## VPC SUBNETS ##
#################
subnets = {
    ##################################################### 
    Example_Subnet = {
        ## VPC SUBNET SETTINGS ##
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
        ## VPC SUBNET ASSOCIATIONS ##
        route_table_association = string # The route table key from route tables above to associate subnet with the route table 
        ## VPC SUBNET TAGS ##
        tags = {
            "Key" = "Value", # The tags to associate with the subnet
            }
        }
    ##################################################### 

}
```

# AWS VPC Gateways   

### AWS Internet Gateways (IGWs)

**Use the follwoing example to create as many Internet Gateways as needed.**   

[AWS Documentation: Internet Gateway Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)

[HashiCorp Terraform Documentation: Internet Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)

```terraform
#######################
## INTERNET GATEWAYS ##
#######################
internet_gateways = {
    #####################################################
    Example_Internet_Gateway = {
            ## INTERNET GATEWAY SETTINGS ##
            igw_name = string # IGW name to be merged with the tags below
            vpc_id = string # VPC ID for where the IGW will reside in
            ## INTERNET GATEWAY TAGS ##
            tags = {
                "Key" = "Value" # Tags to associate with the IGW
                }
            }
    #####################################################
}
```

### AWS Egress-Only Internet Gateways   

**Use the following example to create as many Egress-Only Internet Gateways as needed.**   

[AWS Documentation: Egress-Only Internet Gateway Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/egress-only-internet-gateway.html)

[HashiCorp Terraform Documentation: Egress-Only Internet Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway)   

```terraform 
###################################   
## EGRESS-ONLY INTERNET GATEWAYS ##
###################################
egress_internet_gateways = {
    #####################################################
    Example_Egress_Only_Internet_Gateway = {
            ## EGRESS-ONLY INTERNET GATEWAY SETTINGS ##
            egress_igw_name = string # Egress only IGW name to be merged with the tags below
            vpc_id = string # VPC ID for where the Egress only IGW will reside in
            ## EGRESS-ONLY INTERNET GATEWAY TAGS ##
            tags = {
                "Key" = "Value" # Tags to associate with the Egress only IGW
            }
        }

}
```

### AWS NAT Gateways 

 **Use the follwoing example to create as many NAT Gateways as needed.**

[AWS Documentation: NAT Gateway Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)

[HashiCorp Terraform Documentation: NAT Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)

```terraform 
##################
## NAT GATEWAYS ##
##################
nat_gateways = {
    #####################################################
     Example_NAT_Gateway = {  
            ## NAT GATEWAY SETTINGS ##
            nat_gateway_name = string # Name of NAT Gateway to be merged with the tags below
            subnet_id =  string # Key of created subnet from section below to associate NAT gateway with. ** Use a Public Subnet 
            create_new_eip = bool # Whether or not to create and associate a new EIP with the NAT Gateway
            new_eip_index = number # Index number of the newly created EIP. See Note below for me clarification...
            eip_allocation_id = string # Specify the ID of an existing EIP to associate with the NAT Gateway. create_new_eip must == false
            ## NAT GATEWAY TAGS ##
            tags = { 
                "Key" = "Value" # Tags to associate with the NAT Gateway
                } 
        `}
    #####################################################
}

    # Notes:
    #    new_eip_index - A list of new EIPs is created base upon the number of NAT gateways that specified true for creating a new EIP.
    #                    The index number tells Terraform which EIP amongst that list to associate with each NAT Gateway.
#                    ** Index starts from 0 not 1!
#                    Example:
#
#                    Example_NAT_Gateway_1 = {
#                        ## NAT GATEWAY SETTINGS ##
#                        nat_gateway_name = "" 
#                        subnet_id =  ""  
#                        create_new_eip = true 
#                        new_eip_index = 0 
#                        eip_allocation_id = ""
#                        ## NAT GATEWAY TAGS ##
#                        tags = { "Key" = "Value" } 
#                        }
#
#                    Example_NAT_Gateway_2 = {
#                        ## NAT GATEWAY SETTINGS ##
#                        nat_gateway_name = "" 
#                        subnet_id =  ""  
#                        create_new_eip = false 
#                        new_eip_index = null 
#                        eip_allocation_id = "Some EIP allocation ID"
#                        ## NAT GATEWAY TAGS ##
#                        tags = { "Key" = "Value" } 
#                        }
#                     Example_NAT_Gateway_3 = {
#                         ## NAT GATEWAY SETTINGS ##
#                        nat_gateway_name = "" 
#                        subnet_id =  ""  
#                        create_new_eip = true 
#                        new_eip_index = 1 
#                        eip_allocation_id = ""
#                        ## NAT GATEWAY TAGS ##
#                        tags = { "Key" = "Value" } 
#                        }
#
#                    ** Since there are two NAT Gateway instances that are creating a new EIP "Example_NAT_Gateway_1" will receive the first new EIP. "Example_NAT_Gateway_2" 
#                       will receive the second new EIP
```

### AWS VPC Endpoints 

**Use the follwoing example to create as many VPC Endpoints as needed.**

[AWS Documentation: VPC Endpoint Resource Reference](https://docs.aws.amazon.com/vpc/latest/privatelink/vpc-endpoints.html)

[HashiCorp Terraform Documentation: VPC Endpoint Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)

```terraform
###################    
## VPC ENDPOINTS ##
###################
vpc_endpoints = {
        #####################################################
        Example_VPC_Endpoint = {
            ## VPC ENDPOINT SETTINGS ##
            vpc_endpoint_type = string # Type of VPC Endpoint
            service_name = string # Service name for the VPC Endpoint
            vpc_id = string # VPC ID for where the endpoint will reside in
            auto_accept = bool # Whether or not to auto accept the VPC endpoint. Endpoint & Endpoint Service must be in the same account
            policy = string # Permissions policy to attach to the VPC endpoint. Type must == Interface || Gateway
            private_dns_enabled = bool # Whether or not assocaite a private hosted zone with the specified VPC. Type must == Interface
            route_table_ids = list(string) # One ore more route table IDs to associate with the endpoint. Type must == Gateway
            subnet_ids = list(string) # One or more Subnet IDs to associate with the endpoint. Type must == GatewayLoadBalancer || Interface
            security_group_ids = list(string) # One ore security groups to assocaite with the endpoint. Type muss == Interface
            ## VPC ENDPOINT TAGS ##
            tags = {
                "key" = "value" # Tags to associate with the VPC Endpoint.
                }
            }
        #####################################################
}
```

### AWS Transit Gateways 

**Use the following example to create as many Transit Gateways as desired.**

[AWS Documentation: Transit Gateway Resource Reference](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html)

[HashiCorp Terraform Documentation: Transit Gateway Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway)

```terraform
######################
## TRANSIT GATEWAYS ##
######################
transit_gateways = {
        #####################################################
        Example_Transit_Gateway = {
            ## TRANSIT GATEWAY SETTINGS ##
            description = string # Description of Transit Gateway
            amazon_side_asn = number # ASN for the Amazon side BGP session.  
            auto_accept_shared_attachments = string # Whether resource attachment requests are automatically accepted
            default_route_table_association = string # Whether resource attachments are automatically assocaited with the default route table
            default_route_table_propagation = string # Whether resoure attachments automatically propagate routes to the default propagation route table
            dns_support = string # Whether DNS support is enabled or not
            vpn_ecmp_support = string # Whether VPN Equal Cost Multipath Protocol support is enabled
            ## TRANSIT GATEWAY TAGS ##
            tags = {
                "key" = "value" # Tags to associate with the Transit Gateway
                }
            }
        #####################################################
}
``` 

### AWS VPC Peering Connection 

**Use the follwoing example to create as many VPC peering connections as desired.**

[AWS Documentation: VPC Peering Connection Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection)

[HashiCorp Terraform Documentation: VPC Peering Connection Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection)

```terraform
#############################
## VPC PEERING CONNECTIONS ##
#############################
vpc_peering_connections = {
        #####################################################
        Example_Peering_Connetion = {
            ## VPC PEERING SETTINGS
            peer_owner_id = string # The AWS account ID of the owner for which the peering connection will connect with
            peer_vpc_id = string # ID of the VPC for which you will be creating the peering connection with
            vpc_id = string # The ID of this VPC
            auto_accept = bool # Auto accept peering connection. **Both VPCs must be in the same account for this to be true
            peer_region = bool # The region for which the VPC resides in
            ## VPC PEERING ACCEPTOR SETTINGS ##
            acceptor = {
                allow_remote_vpc_dns_resolution = bool # Allow public to private DNS resolution in the peering connection
                allow_classic_link_to_remote_vpc = bool # Allows outbound communication from local ClassicLink to the remote VPC
                allow_vpc_to_remote_classic_link = bool # Allows for outbound communication from the local VPC to the remote ClassicLink connection
            }
            ## VPC PEERING REQUESTOR SETTINGS ##
            requester = {
                allow_remote_vpc_dns_resolution = bool # Allow public to private DNS resolution in the peering connection
                allow_classic_link_to_remote_vpc = bool # Allows outbound communication from local ClassicLink to the remote VPC
                allow_vpc_to_remote_classic_link = bool # Allows for outbound communication from the local VPC to the remote ClassicLink connection
            }
            ## VPC PEERING TAGS ##
            tags = { 
                "key" = "value" # Tags to be assocaited with the VPC peering connection
                }
            }
        #####################################################
}
```

# AWS Route53

### Route53 Hosted Zones   

**Use the below example to create as many Route53 Hosted Zones as desired.**

[AWS Documentation Route53: Hosted Zone Resource Reference](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)

[HashiCorp Terraform Route53: Hosted Zone Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone)

```terraform
###########################
## Route53: Hosted Zones ##
###########################
hosted_zones = {

        # Able to create multiple hosted zones. Each key for a hosted zone must be unique.
        ####################################################
            Example_Zone = { 
                ## HOSTED ZONE SETTINGS ##
                name = string # Name of the hosted zone 
                comment = string # A comment describing the hosted zone 
                force_destroy = bool # Whether to destroy all records inside the when destroying the zone
                delegation_set_id = string # Conflicts with private_zone_settings. The reusable delegation set whose NS you want to assign to the hosted zone
                ### PRIVATE HOSTED ZONE DECLARATION ##
                private_zone = bool # Whether to declare this hosted zone as a private hosted zone
                private_zone_settings = {
                    vpc_id = string # The VPC ID where the private hosted zone will be associated with
                    vpc_region = string # The AWS region of which the private hosted zone will be located in
                }
                ## HOSTED ZONE TAGS ##
                tags = {
                "Key" = "Value" # Tags to associate with the hosted zone
                }
            }
        ####################################################
}

```

### Route53 DNS Records

**Use the below example to create as many Route53 DNS Records as desired**

[AWS Documentation Route53: DNS Record Resource Reference](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html)

[Route53: DNS Record Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)

```terraform 
###########################
## Route53: Zone Records ##
###########################
route53_records = {

    # Able to create multiple DNS records. Each key for a DNS records must be unique.
    ####################################################
    Example_Record = {
        ## RECORD SETTINGS ##
        zone_key = string # The key for the desired hosted zone declared above
        name = string # Name for the DNS record. Hosted Zone name is automatically appended
        type = string # Type of DNS record 
        ttl = number # Time to live value for DNS record. Value is Null if create_alias == true
        multivalue_answer_routing_policy = bool # Whether this DNS record accepts multivalue responses
        records = list(string) # Resource values for the DNS record. Value is Null if create_alias == true
        health_check_id = string # The health check ID to associate this DNS record with
        set_identifier = string # "faliover" # "failover" || "latency" || "geolocation" || "weighted"
        policy = {
            # Policy is null if multivalue_answer_routing_policy == true
            # Depending on the set identifier value will determine what attribute this block will accept
            # Please refer to the DNS Record Resource Reference to specify the appropriate attributes and values
        }
        ## ALIAS SETTINGS ##
        create_alias = bool # Whether to create an Alias record 
        alias = {
            values = {
                name = string # Name for the Alias record 
                zone_key = string # The key for the desired hosted zone declared above
                evaluate_target_health = bool # If Route 53 should respond to DNS queries using this resource record set by checking the health of the resource record set
            }
        }
        ## OVERWITE SETTINGS ##
        allow_overwrite = bool # Leave false, Not recommended for most environments. Whether Terraform should overwrite an existing record, if any.
    }
    ####################################################
}
```

# AWS Network ACLs

### Default Network ACL 

**Use the example below to create a default network ACL for the associated VPC.**

[AWS Documentation: Default Network ACL Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#custom-network-acl)

[HashiCorp Terraform Documentation: Default Network ACL Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl)

```terraform
##################
## ACL: Default ##
##################
create_default_network_acl = bool # Whether or not to create a default network ACL for the associated VPC
default_network_acl = {

    Default_Network_ACL = {
        ## DEFAULT ACL SETTINGS ##
        default_network_acl_name = string # Name of default ACL to be merged with tags below
        default_network_acl_id = string # ID of default_network_acl attribute exported from the VPC resource 
        default_acl_subnet_ids = list(string) # One or more subnets to associate with the default network ACL
        ## INGRESS RULE DECLARATIONS ##
        default_network_acl_ingress = { # Mapping of objects for the ingress rules to associate with default network ACL
            ####################################
                ingress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## INGRESS RULE DECLARATIONS ##
        default_network_acl_egress = { # Mapping of objects for the egress rules to associate with default network ACL
            ####################################
                egress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type       = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## DEFAULT ACL TAGS ##
        tags = {
            "key" = "value" # Tags to associate with the default ACL
        }
    }
}
```

### Network ACl 

**Use the example below to create as many Network ACLs for the desired VPCs.**

[AWS Documentation: Default Network ACL Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#custom-network-acl)

[HashiCorp Terraform Documentation: Default Network ACL Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl)      

```terrafrom
########################
## ACL GROUP: EXAMPLE ##
########################
acl_group = {

    Example_ACL = {
        ## ACL SETTINGS ##
        acl_name = string # Name of ACL to be merged with tags below
        vpc_id = string # ID of VPC for the Network ACL to reside in
        acl_subnet_ids = list(string) # One or more Subnet IDs to associate with the network ACL 
        ## INGRESS RULE DECLARATIONS ##
        acl_ingress_rules = { # Mapping of objects for the ingress rules to associate with default network ACL
            ####################################
            ingress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## EGRESS RULE DECLARATIONS ##
        acl_egress_rules = { # Mapping of objects for the egress rules to associate with default network ACL
            ####################################
                egress_rule_1 = { # Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                    action = string # Whether to "Allow" || "Deny" access to the ports and protocol below
                    cidr_block = string # Location from where the traffic is coming from
                    from_port = number # Starting port
                    icmp_code = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                    icmp_type = number # Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                    ipv6_cidr_block = string # Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                    protocol = string || -1 # Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                    rule_no = number # The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                    to_port = number # Ending port
                }
            ####################################
        }
        ## ACL TAGS ##
        tags = {
            "key" = "value" # Tags to associate with the Network ACL
        }
    }
}
```

# AWS Security Groups   

[AWS Documentation: Security Group Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

[HashiCorp Terraform: Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)   

**Use the below example to create as many security groups as needed.**

```Terraform
#####################
## SECURITY GROUPS ##
#####################
create_new_security_groups = false
new_security_groups = {
# Able to create more than security group
  #-----------------------------------------#
  security_group = {
    ## Security Group Settings ##
    name        = string # Name of security group. If "", Terraform will assign a random unigue name to the security group
    description = string # Description of the security group. If "", Terraform will auto assign the description "Managed by Terraform
    vpc_id      = string # The VPC ID where the security group will be located in 
    ## Ingress Rule Declarations ##
    ingress_rules = { 
    # Able to create more than one ingress rule
          #---------------------------------#
          rule_1 = {
            description      = string # Description of the ingress rule
            from_port        = number # Starting port of the ingress rule
            to_port          = number # Ending port of the ingress rule
            protocol         = string # Protocol for the ingress rule. If "-1" (all), from/to ports must == 0
            cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the ingress rule. If [], then cidr_blocks == null
            ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the ingress rule. If [], then ipv6_cidr_blocks == null  
            self = false  # Whether the security group itself will be added as a source to this ingress rule
          }
          #---------------------------------#
    }
    ## Egress Rule Declarations ##
    egress_rules = {  
    # Able to create more than one egress rule
          #---------------------------------#
          rule_1 = {
            description      = string # Description of the egress rule
            from_port        = number # Starting port of the egress rule
            to_port          = number # Ending port of the egress rule
            protocol         = string # Protocol for the egress rule. If "-1" (all), from/to ports must == 0
            cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the egress rule. If [], then cidr_blocks == null
            ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the egress rule. If [], then ipv6_cidr_blocks == null  
            self = false  # Whether the security group itself will be added as a source to this egress rule
          }
          #---------------------------------#
    }
    ## Security Group Tags ##
    tags = {
        "" = "" # Tags to associate with security group
      }}
  #-----------------------------------------#
}
########################################################
```