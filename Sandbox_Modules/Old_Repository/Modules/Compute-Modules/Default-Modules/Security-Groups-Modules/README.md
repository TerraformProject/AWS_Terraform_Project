## Security Groups: Public | Private | Database

Use the example below to create as many public, private, database security groups as desired:

[Security Group Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

```terraform

    # One example is being used to represent three identical variables:
    # public_security_groups | private_security_groups | database_security_groups

( public | private | database )_security_groups = {

        Public_Security_Group_1 = { # Able to create more than one security group. Each key must be unique. Terraform does not process dublicate keys
            name        = string # Name of security group. If "", Terraform will assign a random unigue name to the security group
            description = string # Description of the security group. If "", Terraform will auto assign the description "Managed by Terraform
            vpc_id      = string # The VPC ID where the security group will be located in

            ingress_rules = { # Able to create multiple ingress rules. Each key must be unique. Terraform does not process duplicate keys
                rule_1 = {
                    description      = string # Description of the ingress rule
                    from_port        = number # Starting port of the ingress rule
                    to_port          = number # Ending port of the ingress rule
                    protocol         = string # Protocol for the ingress rule. If "-1" (all), from/to ports must == 0
                    cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the ingress rule. If [], then cidr_blocks == null
                    ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the ingress rule. If [], then ipv6_cidr_blocks == null  
                    self = false  # Whether the security group itself will be added as a source to this ingress rule
                }
            }

            egress_rules = {  # Able to create multiple egress rules. Each key must be unique. Terraform does not process duplicate keys
                rule_1 = {
                    description      = string # Description of the egress rule
                    from_port        = number # Starting port of the egress rule
                    to_port          = number # Ending port of the egress rule
                    protocol         = string # Protocol for the egress rule. If "-1" (all), from/to ports must == 0
                    cidr_blocks      = list(string) # IPv4 CIDR blocks to associate with the egress rule. If [], then cidr_blocks == null
                    ipv6_cidr_blocks = list(string) # IPv6 CIDR blocks to associate with the egress rule. If [], then ipv6_cidr_blocks == null  
                    self = false  # Whether the security group itself will be added as a source to this egress rule
                }
            }

            tags = {
                "key" = "value" # Tags to associate with security group
            }
        }
        
    }
```
 