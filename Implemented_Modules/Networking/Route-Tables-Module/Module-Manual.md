# AWS Route Tables    
 
## Default Route Table 

Use the following example to create a default route table and routes for the VPC:

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

## Route Tables 

# VPC Route Tabeles    

## Use the following example to create multiple instances of route tables and routes:

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