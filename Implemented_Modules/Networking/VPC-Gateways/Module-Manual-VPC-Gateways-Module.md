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
                "Key = "Value" # Tags to associate with the Egress only IGW
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
