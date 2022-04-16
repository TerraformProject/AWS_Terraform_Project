# What is Amazon VPC?

A virtual network hosted on AWS to launch resources that are defined. Closely resembles that of a datacenter.

Within a VPC you are able to provision the following networking resources.   
• **Route Tables**   
• **Subnets**   
• **DHCP Options sets**   
• **Gateways**   
• **Endpoint Services**   
• **VPC Peerinh Connections**   
• **Firewall Management**   
• **Network Analytics**

** A VPC spans all Availability Zones within an AWS region.   

## VPC Route Table Concepts

The following are the key concepts route tables   
• **Main Route Table:** The route table that automatically comes with your VPC. It controls initialy the routing for all subnets that are not explicitly associated to a route table.    
• **Custom Route Table:** A route table that is created in addition to the main route table.   
• **Destination:** The range of IP addresses where you want traffic to go (destination CIDR).    
• **Target:** The gateway, network interface, or connection through which to send traffic to.
• **Route Table Association:** The association between a route table and a subnet, internet gateway, or virtual private gateway.   
• **Local Route:** A default route for communication within the VPC.
• **Propogation:** Route propagation allows a virtual private gateway to automatically propogate routes to the route tables. This means that manually entering VPN routes into your route table is not needed.    
• **Gateway Route Table:** A gateway route table that is assocaited with an internet gateway or virtual private gateway.   
• **Edge Association:** A route table that you use to route inbound VPC traffic to an appliance. You associate a route a table with the internet gateway or virtual private gateway, and specify the network interface of your appliance as the target for VPC traffic.   
• **Transit gateway route table:** A route table that is associated with a transit gateway.    
• **Local Gateway Route table:** A route table that is associated with an Outpost local gateway.   

## VPC Subnet Basics   
A subnet is a range of IP addresses in your VPC. You can launch AWS resources, into specific subnet. When you create a subnet you specify the IPv4 CIDR block for the subnet, which is a subset of the VPC CIDR block.  

Each subnet must reside entirely withn one Availability Zone and cannot span multiple zones. One subnet per availability zone allows for protection of applications that fail within a single Availability Zone.  

You can optionally add subnets in a Local Zone, which is an AWS infrastructure deployment that places compute, storage, database, and other selected services closer to you end users. This enables applications to meet their requirement of single-digit millisecond latencies.

## Subnet Types   
• **IPv4 only**  
• **IPv4 and IPv6 (Dualstack)**  
• **IPv6-only**     
• **Public Subnet**  
• **Private Subnet**   
• **VPN-Only Subnet**
