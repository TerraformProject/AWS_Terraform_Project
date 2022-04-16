# What is Amazon VPC?

A virtual network hosted on AWS to launch resources that are defined. Closely resembles that of a datacenter.

Within a VPC you are able to provision the following networking resources.   
• **Route Tables**   
• **Subnets**   
• **DHCP Options sets**   
• **Amazon Domain Name Resolver**  
• **Gateways**   
• **Endpoint Services**   
• **VPC Peering Connections**   
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

### Subnet Types   
• IPv4 only    
• IPv4 and IPv6 (Dualstack)  
• IPv6-only        
• Public Subnet     
• Private Subnet     
• VPN-Only Subnet  

## VPC DHCP Options Sets

Allows you to specify how devices in your VPC use the Dynamic Host Configuration Protocol (DHCP). The DHCP options set gives you the control over the following aspects with your VPC.   

• Control over the DNS servers, domain names, Network Time Protocol (NTP) servers used by the devices with your VPC.   
• Enable/Disable DNS resolution completely with you VPC.  

### DCHP Options Set Concepts  

Each VPC in a Region uses the same default DHCP option set unless you choose to a create a custom DHCP option set, or if you choose to disassociate all options sets from your VPC.   

#### Default DHCP Option set   
   
Each VPC in a Region uses the same default DHCP option set, which contacins the following network configurations.  
   
**• Domain Name:** The domain name that a client should use when resolving hostnames via the Domain Name System.  
**• Domain Name Servers:** The DNS sers that your network interfaces will use for domain name resolution.   

#### Custom DHCP Option set  

You can create your own DHCP option set in a VPC. This enables you to configure the following network configurations.  

**• Domain Name:** The domain name that a client should use when resolving hostnames via the Domain Name System.   
**• Domain Name Servers:** The DNS servers that your network interfaces will use for domain name resolution.   
**• NTP Servers:** The NTP servers that will provide the time to the instances in your network.  
**• NetBIOS Name Servers:** For EC2 Instances running a Windows OS, the NetBIOS computer name is a friendly name assigned to the instance to identify it on the network. A NetBIOS name server maintains a list of mapping between NetBIOS computer name and network addresses for networks that use NetBIOS as their naming service.  
**• NetBIOS Node Type:** For EC2 Instances running a Windows OS, the method that the instances use to resolve NetBIOS names to IP Addresses. 

**If you use a custom DHCP Option Set, instances launched in your VPC use the network configurations in the following order.**   

1) DHCP Option Set   
2) Interact with Non-Amazon DNS, NTP, and NetBIOS servers (From a corporate data center).    
3) Connect to other devices in the network through you VPC router.   

## Amazon DNS Server  

The Amazon DNS server is an Amazon Route 53 Resolver server. This server enables DNS for instances that need to communicate over the VPC's Internate Gateway.

** The Amazon DNS Server does not reside within a specific subnet or Availability Zone within a VPC. More so, this DNS server is located at the following.**   

• 169.254.169.253   
• A Reserved IP address at the base of the VPC CIDR IPv4 network range + 2. Example: 10.0.0.0/16, DNS Server - 10.0.0.2 *If VPC contains multiple CIDR blocks , the DNS server is located in the primary CIDR block.      
• fd00:ec2::253   

When you launch an instance into a VPC, Amazon provides the instance with a Private DNS hostname. Amazon also provides a public DNS hostname if the instance is configured with a Public IPv4 address and the VPC DNS attributes are enabled.

## VPC Gateways  

**You can connect your VPC to other networks such as VPCs, the internet, or on-premise network in the following ways.**

#### Internet Gateway     

An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communications between your VPC and the internet. An internet gateway enables resources in your public subnets to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 or IPv6 address.

An internet gateway serves two purposes.  
• To provide a target on your VPC route tables for internet-routable traffic.  
• To perform network address translation (NAT) for instances that have been a assigned public IPv4 addresses.   
   
#### Egress-only Internet Gateways     
   
An egress-only internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows for outbound only communications over IPv6 from instances in your VPC to the internet and prevents the internet from initiating an IPv6 connection with your instances.    
     
An egress-only internet gateway is **stateful**: It forwards traffic from the instances in the subnet or other AWS servicesm and then sends the response back to the instances.

#### NAT Gateways      

A NAT Gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services cann initiate a connection with those instances.   

** When you create a NAT Gateway, you specify one of the following types.**     
   
**• Public:** (Defaul) Instances within private subnets can connect to the internet through a Public NAT Gatewat, but are unable to receive unsolicited inbound connections from the internet. You must associate an Elastic IP (EIP) with the NAT Gateway at creation. You route traffic from the NAT Gateway to the internet gateway for the VPC. Alternatively, you can use a public NAT Gateway to connect to other VPCs or your on-premise network.   
   
**• Private:** Instances within private subnets can connect to other VPCs or your on-premise network through a private NAT gateway. You can route traffic from the NAT gateway through a Transit Gateway or a Virtual Private Gateway. You cannot associate an elastic IP (EIP) address with a private NAT Gatewat. You can attach an internet gateway to a VPC with a privte NAT Gateway, but if you route traffic from the private NAT Gateway to the internet gateway, the internet gateway drops the traffic.    

#### Transit Gateways   

You can connect your virtual private clouds (VPCs) and on-premesis networks using a transit gateway, which acts as a central hub, routing traffic between VPCs, VPN connections, and AWS Direct Connect connections. 