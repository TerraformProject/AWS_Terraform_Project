  # VPC1

resource "aws_vpc" "VPC1" {
  cidr_block       = "192.168.0.0/16"// Address range for the Virtual Network.
  instance_tenancy = "default"// Keep this as default. Dedicated or host charges $2 per hr.
  enable_dns_support = true //Instead of using Route 53 for now.
  enable_dns_hostnames = true // AWS dns will also use hostnames of connected devices.

  tags = {
    Name = "VPC1"
  }
}
 
 # Internet Gateway associated with VPC1

resource "aws_internet_gateway" "gw1_VPC" {
  vpc_id = aws_vpc.VPC1.id
  
  tags = {
    Name = "VPC1_Internet_Gateway"
  }
}


resource "aws_nat_gateway" "natgw_useast1a" {
  allocation_id = aws_internet_gateway.gw1_VPC.id
  subnet_id = aws_subnet.subnet1_VPC1.id

  depends_on = [aws_internet_gateway,gw1_VPC]
}

resource "aws_nat_gateway" "natgw_useast_1b" {
  allocation_id = aws_internet_gateway.gw1_VPC.id
  subnet_id = aws_subnet.subnet4_VPC1

  depends_on = [aws_internet_gateway.gw1_VPC]
}








# Public Subnets:

    # US-East-1a Public Subnets:

        resource "aws_subnet" "subnet1_VPC1" {
            vpc_id     = aws_vpc.VPC1.id
            cidr_block = "192.168.1.0/24"
            availability_zone = "us-east-1a"

            tags = {
                Name = "subnet1_VPC1"
            }
        }

    # US-East-1b Public Subnets:

        resource "aws_subnet" "subnet4_VPC1" {
            vpc_id     = aws_vpc.VPC1.id
            cidr_block = "192.168.4.0/24"
            availability_zone = "us-east-1b"

            tags = {
                Name = "subnet1_VPC1"
            }
        }



# Private Subnets:

    # US-East-1a Private Subnets:
    
        resource "aws_subnet" "subnet3_VPC1" {
            vpc_id     = aws_vpc.VPC1.id
            cidr_block = "192.168.3.0/24"
            availability_zone = "us-east-1a"

            tags = {
                Name = "DB_subnet3_VPC1"
            }
        }
    
    # US-East-1b Private Subnets:

        resource "aws_subnet" "subnet6_VPC1" {
            vpc_id     = aws_vpc.VPC1.id
            cidr_block = "192.168.6.0/24"
            availability_zone = "us-east-1b"

            tags = {
                Name = "DB_subnet6_VPC1"
            }
        }
   

    # US-East-1c Private DB Subnet:

        resource "aws_subnet" "subnet7_VPC1" {
        #Located in DB Subnet
            vpc_id     = aws_vpc.VPC1.id
            cidr_block = "192.168.7.0/24"
            availability_zone = "us-east-1c"

            tags = {
                Name = "DB_subnet7_VPC1"
            }
        }   






# Route Tables:

    
  # US-East-1a Route Tables
  
    resource "aws_route_table" "private_route_table_1_useast1a" {
        vpc_id = aws_vpc.VPC1.id
        
        route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.natgw_useast1a.id
        }

        route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.natgw_useast1b.id
        }
        
        tags = {
            Name = "Private1-USeast1a"
        }
    }
        # Associations:
            resource "aws_route_table_association" "subnet_2_priv_route_useast1a_association" {
            subnet_id      = aws_subnet.subnet2_VPC1.id
            route_table_id = aws_route_table.private_route_table_1_useast1a.id
            }
            resource "aws_route_table_association" "subnet_3_priv_route_useast1a_association" {
            subnet_id      = aws_subnet.subnet3_VPC1.id
            route_table_id = aws_route_table.private_route_table_2_useast1a.id
            }

  # US-East-1b Route Tables

resource "aws_route_table" "private_route_table_1_useast1b" {
  vpc_id = aws_vpc.VPC1.id
  
        route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.natgw_useast1a.id
        }

        route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.natgw_useast1b.id
        }
    }
    # Associations:
            resource "aws_route_table_association" "subnet_5_priv_route_table_1_useast1b_association" {
            subnet_id      = aws_subnet.subnet5_VPC1.id
            route_table_id = aws_route_table.private_route_table_1_useast1b.id
            }
            resource "aws_route_table_association" "subnet_6_priv_route_2_useast1b_association" {
            subnet_id      = aws_subnet.subnet6_VPC1.id
            route_table_id = aws_route_table.private_route_table_2_useast1b.id
            }

resource "aws_route_table" "private_route_table_3_useast1b" {
  vpc_id = aws_vpc.VPC1.id

        route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.natgw_useast1a.id
        }

        route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.natgw_useast1b.id
        }
    }
    #Associations:
            resource "aws_route_table_association" "subnet_6_priv_route_2_useast1b_association" {
            subnet_id      = aws_subnet.subnet7_VPC1.id
            route_table_id = aws_route_table.private_route_table_2_useast1b.id
            }








