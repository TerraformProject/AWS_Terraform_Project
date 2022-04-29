# AWS VPC QuickStart module

## VPC SETTINGS 

**Use the below portion of the module for the VPC to be created.**

[VPC Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

```Terraform
##################
## VPC GROUPING ##
############################################################
create_vpc_group = false # Whether or not to create a VPC group
vpc_group = {
# ABLE TO CREATE MORE THAN ONE#
    #------------------------------------------------------#
    example_vpc = { <- If creating more than one vpc, this module key must be unique
            vpc_name = "" # Name of the VPC to be merged with resource tags
            #- VPC CIDR BLOCKS ----------------------------#
            cidr_block       = "" # Valid IPv4 CIDR block to assign to the VPC
            secondary_ipv4_cidr_blocks = [] # Valid sub-IPv4 CIDR blocks to associate with the VPC 
            assign_generated_ipv6_cidr_block = false # Whether or not to assign an IPv6 CIDR block
            #- DNS SETTINGS -------------------------------#
            enable_dns_support = false # Whether or not DNS resolution is performed with the Amazon provided DNS
            enable_dns_hostnames = false # Whether or not instances with public IP addresses are assigned a DNS hostname
```

## VPC GATEWAY SETTINGS

**Use the below portion of the module to specify the gateways to be created in the new VPC.**

[AWS Documentation: Internet Gateway Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)   

[AWS Documentation: Egress-Only Internet Gateway Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/egress-only-internet-gateway.html)    

[AWS Documentation: NAT Gateway Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)

```Terraform
            #- GATEWAY SETTINGS ---------------------------#
            internet_gateway_name = "" # If specified, name of the internet gateway to be created. Name is merged with tags
            egress_only_internet_gateway_names = [] # If specified, name of the internet gateway to be created. Name is merged with tags
            nat_gateway_names = [] # If specified, example: "nat_gateway_name:associated_subnet_name". Name is merged with tags
```

## VPC ROUTE TABLE SETTINGS

**Use the below portion of the module to specify the route tables to be created in the new VPC.**

[AWS Documentation: Default Route Table Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)    

[AWS Documentation: Route Table Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)   

```Terraform
            #- VPC ROUTE TABLE SETTINGS -------------------#
            vpc_default_route_table_name = "" # Name of route table stated below to be the desginated main route table
            vpc_route_tables = {
            # ABLE TO CREATE MORE THAN ONE #
                #------------------------------------------#
                Example_Route_Table = { <- If creating more than one route table, this module key must be unique
                route_table_name = "" # Name of the route table to merged with tags
                associated_routes = {
                            # ABLE TO CREATE MORE THAN ONE #
                            #------------------------------#
                            Route_1 = { <- If creating more than one route, this module key must be unique
                                Target_Attribute : Target_Value  
                                Destingation_Attribute : Destination_Value  
                            }
                            #------------------------------#
                }   }
                #------------------------------------------#
            }
```
**Use the below reference to specify the routes in the route tables to be created above.**    

```Terraform
                       # Target #   
                cidr_block : value
           ipv6_cidr_block : value
destination_prefix_list_id : value

                      # Destination #
                gateway_id : value
    egress_only_gateway_id : value
            nat_gateway_id : value
```

## VPC SUBNET SETTINGS  

**Use the below portion of the module to specify the subnets to be created in the new VPC.**

[AWS Documentation: Subnet Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)

```Terraform
            #- VPC SUBNET SETTINGS ------------------------#
            vpc_subnets = {
            # ABLE TO CREATE MORE THAN ONE #
                #------------------------------------------#
                Example_Subnet = { <- If creating more than one subnet, this module key must be unique
                    subnet_name = "" # Name of the subnet to be merged with tags
                    availability_zone = "" # Availability Zone for the subnet to take place in
                    cidr_block = "" # Valid IPv4 CIDR block to assign to the subnet
                    ipv6_cidr_block = "" # Valid IPv6 CIDR block to assign to the subnet
                    assign_ipv6_address_on_creation = false # Whether or not to auto-assign IPv6 addresses to instances created in subnet
                    map_public_ip_on_launch = false # Whether or not to auto-assign public ipv4 addresses to instances created in subnet
                    route_table_name = "" # Route table name from above for this subnet to associated to
                }
                #-----------------------------------------#
            }
```

## VPC DEFAULT ACL SETTINGS   

**Use the below portion of the module to specify the rules to be assigned to the default ACL in the new VPC.**   

[AWS Documentation: Default Network ACL Resource Reference](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#custom-network-acl)

```Terraform
            #- DEFAULT ACL SETTINGS ----------------------#
            default_acl = {
                #-----------------------------------------#
                acl_name = "" # Name for the default acl to be merged with tags
                acl_rules = [
                # "Direction|Action|IP_Type|CIDRblock|Protocol|FromPort|ToPort|RuleNo"
                ] 
                #-----------------------------------------#
            }
```
## VPC DEFAULT SECURITY GROUP SETTINGS   

**Use the portion of the module below to specify rules to assign to the default security group in the new VPC**     

[AWS Documentation: Default Security Group Resource Reference](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/default-custom-security-groups.html)

```Terraform
            #- DEFAULT SECURITY GROUP SETTINGS -----------#
            default_security_group = {
                #-----------------------------------------#
                security_group_name = "" # Name for the default security group to be merged with tags
                security_group_rules = [
                # "Direction|Type|Type_Value|Protocol|FromPort|ToPort|RuleName"
                ]
                #-----------------------------------------#
            }
        }
    #-----------------------------------------------------#      
}
###########################################################
```

# VPC QuickStart Output Value Examples

**Use the example below to assist in specifying output values from this module.**    

```Terraform
################
## VPC OUTPUT ##
################
#- Sample -------------------------------------------#
# output "module_key_export_attribute" {
#   value = aws_vpc.vpc["module_key"].export_attribute
# }
#----------------------------------------------------#
###############################
## VPC IPv4 CIDR Association ##
###############################
#- Sample -------------------------------------------#
# output "module_key_export_attribute" {
#   value = aws_vpc_ipv4_cidr_block_association.this["module_key"].export_attribute
# }
#----------------------------------------------------#
##########################
## VPC Internet Gateway ##
##########################
#- Sample -------------------------------------------#
# output "igw_name_export_attribute" {
#   value = aws_internet_gateway.igw["igw_name"].export_attribute
# }
#----------------------------------------------------#
######################################
## VPC Egress Only Internet Gateway ##
######################################
#- Sample -------------------------------------------#
# output "egress_only_igw_name_export_attribute" {
#   value = aws_egress_only_internet_gateway.egress_only_igw["egress_only_igw_name"].export_attribute
# }
#----------------------------------------------------#
#####################
## VPC NAT Gateway ##
#####################
#- Sample -------------------------------------------#
# output "nat_gateway_name_export_attribute" {
#   value = aws_nat_gateway.nat_gateway["nat_gateway_name"].export_attribute
# }
#----------------------------------------------------#
#############################
## VPC Default Route Table ##
#############################
#- Sample -------------------------------------------#
# output "default_route_table_name_export_attribute" {
#   value = aws_default_route_table.default_route_table["default_route_table_name"].export_attribute
# }
#----------------------------------------------------#
######################
## VPC Route Tables ##
######################
#- Sample -------------------------------------------#
# output "route_table_name_export_attribute" {
#   value = aws_route_table.route_tables["default_route_table_name"].export_attribute
# }
#----------------------------------------------------#
#################
## VPC Subnets ##
#################
#- Sample -------------------------------------------#
# output "subnet_name_export_attribute" {
#   value = aws_subnet.subnets["subnet_name"].export_attribute
# }
#----------------------------------------------------#
#####################
## VPC Default ACL ##
#####################
#- Sample -------------------------------------------#
# output "default_acl_name_export_attribute" {
#   value = aws_default_network_acl.default_acl["module_key"].export_attribute
# }
#----------------------------------------------------#
################################
## VPC Default Security Group ##
################################
#- Sample -------------------------------------------#
# output "default_security_group_name_export_attribute" {
#   value = aws_default_security_group.default_security_group["module_key"].export_attribute
# }
#----------------------------------------------------#
```