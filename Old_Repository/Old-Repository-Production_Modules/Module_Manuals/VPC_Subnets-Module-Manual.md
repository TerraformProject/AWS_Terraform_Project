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