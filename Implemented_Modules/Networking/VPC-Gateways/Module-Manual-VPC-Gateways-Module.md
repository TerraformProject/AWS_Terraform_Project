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
    #####################################################
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