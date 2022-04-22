# What is Amazon VPC?

A virtual network hosted on AWS to launch resources that are defined. Closely resembles that of a datacenter.

Within a VPC you are able to provision the following networking resources.   
• **Route Tables**   
• **Subnets**   
• **DHCP Options sets**   
• **Amazon Domain Name Resolver**  
• **Gateways**   
• **VPC Peering Connections**   
• **Endpoint Services**         
• **Network Analytics**

** A VPC spans all Availability Zones within an AWS region.   

# VPC Route Table Concepts

**The following are the key concepts route tables**   

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

### VPC Subnet Basics   

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

# VPC DHCP Options Sets

**Allows you to specify how devices in your VPC use the Dynamic Host Configuration Protocol (DHCP). The DHCP options set gives you the control over the following aspects with your VPC.**   

• Control over the DNS servers, domain names, Network Time Protocol (NTP) servers used by the devices with your VPC.   
• Enable/Disable DNS resolution completely with you VPC.  

### DCHP Options Set Concepts  

**Each VPC in a Region uses the same default DHCP option set unless you choose to a create a custom DHCP option set, or if you choose to disassociate all options sets from your VPC.**   

#### Default DHCP Option set   
   
Each VPC in a Region uses the same default DHCP option set, which contains the following network configurations.  
   
**• Domain Name:** The domain name that a client should use when resolving hostnames via the Domain Name System.  
**• Domain Name Servers:** The DNS sers that your network interfaces will use for domain name resolution.   

#### Custom DHCP Option set  

You can create your own DHCP option set in a VPC. This enables you to configure the following network configurations.  

**• Domain Name:** The domain name that a client should use when resolving hostnames via the Domain Name System.   
**• Domain Name Servers:** The DNS servers that your network interfaces will use for domain name resolution.   
**• NTP Servers:** The NTP servers that will provide the time to the instances in your network.  
**• NetBIOS Name Servers:** For EC2 Instances running a Windows OS, the NetBIOS computer name is a friendly name assigned to the instance to identify it on the network. A NetBIOS name server maintains a list of mapping between NetBIOS computer name and network addresses for networks that use NetBIOS as their naming service.  
**• NetBIOS Node Type:** For EC2 Instances running a Windows OS, the method that the instances use to resolve NetBIOS names to IP Addresses. 

If you use a custom DHCP Option Set, instances launched in your VPC use the network configurations in the following order.   

1) DHCP Option Set   
2) Interact with Non-Amazon DNS, NTP, and NetBIOS servers (From a corporate data center).    
3) Connect to other devices in the network through you VPC router.   

# Amazon DNS Server  

**The Amazon DNS server is an Amazon Route 53 Resolver server. This server enables DNS for instances that need to communicate over the VPC's Internate Gateway.**  
   
**AWS Route53 provides a wide range of control of DNS Resolving within VPCs** 

The Amazon DNS Server does not reside within a specific subnet or Availability Zone within a VPC. More so, this DNS server is located at the following.   

• 169.254.169.253   
• fd00:ec2::253
• A Reserved IP address at the base of the VPC CIDR IPv4 network range + 2. Example: 10.0.0.0/16, DNS Server - 10.0.0.2 *If VPC contains multiple CIDR blocks , the DNS server is located in the primary CIDR block.         

When you launch an instance into a VPC, Amazon provides the instance with a Private DNS hostname. Amazon also provides a public DNS hostname if the instance is configured with a Public IPv4 address and the VPC DNS attributes are enabled.  

# VPC Gateways  

**You can connect your VPC to other networks such as VPCs, the internet, or on-premise network in the following ways.**

### Internet Gateway     

An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communications between your VPC and the internet. An internet gateway enables resources in your public subnets to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 or IPv6 address.

An internet gateway serves two purposes.  
• To provide a target on your VPC route tables for internet-routable traffic.  
• To perform network address translation (NAT) for instances that have been a assigned public IPv4 addresses.   
   
### Egress-only Internet Gateways     
   
An egress-only internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows for outbound only communications over IPv6 from instances in your VPC to the internet and prevents the internet from initiating an IPv6 connection with your instances.    
     
An egress-only internet gateway is **stateful**: It forwards traffic from the instances in the subnet or other AWS servicesm and then sends the response back to the instances.

### NAT Gateways      

A NAT Gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services cann initiate a connection with those instances.   

When you create a NAT Gateway, you specify one of the following types.     
   
**• Public:** (Defaul) Instances within private subnets can connect to the internet through a Public NAT Gatewat, but are unable to receive unsolicited inbound connections from the internet. You must associate an Elastic IP (EIP) with the NAT Gateway at creation. You route traffic from the NAT Gateway to the internet gateway for the VPC. Alternatively, you can use a public NAT Gateway to connect to other VPCs or your on-premise network.   
   
**• Private:** Instances within private subnets can connect to other VPCs or your on-premise network through a private NAT gateway. You can route traffic from the NAT gateway through a Transit Gateway or a Virtual Private Gateway. You cannot associate an elastic IP (EIP) address with a private NAT Gatewat. You can attach an internet gateway to a VPC with a privte NAT Gateway, but if you route traffic from the private NAT Gateway to the internet gateway, the internet gateway drops the traffic.    

### Transit Gateways   

You can connect your virtual private clouds (VPCs) and on-premesis networks using a transit gateway, which acts as a central hub, routing traffic between VPCs, VPN connections, and AWS Direct Connect connections.   

# VPC Peering Connections   

A VPC Peering connection is a networking connection between two VPCs that enables you to route traffic between them privately. You can create a VPC Peering connection between your own VPCs, with a VPC in another AWS account, or with a VPC in a separate region.   
   
AWS uses the existing infrastructure of a VPC to create a VPC peering connection; it is neither a gateway nor a VPN connection, and does not rely on a separate piece of physical hardware. There is no single point of failure for communications or a bandwidth bottleneck.

This allows VPC resources including EC2 instances, Amazon RDS databases and Lambda functions that run in different AWS accounts or regions to communicate with each other using private IP addresses, without requiring gateways, VPN connections, or seperate network appliances. The traffic remains encrypted on the via inter-regions and never traverse the public internet.   
   
# VPC Site-to-Site VPN    
    
By default, instances that you launch within a VPC are unable to communicate with your own (remote) network. You can enable access to your remote network from your VPC by createing an AWS Site-to-Site VPN, and configure routing to pass through the connection.    
  
Although the term VPN connection is a general term, a VPN connection refers to the connection between your VPC and your own on-premise network. Site-to-Site VPN supports Internet Protocol securtiy (IPsec) VPN connections.   
   
**The following are the key concepts for Site-to-Site VPN**   
   
**• VPN Connection:** A secure connection between your on-premesis equipment and your VPCs.     
**• VPN Tunnel:** An encrypted link where data can pass from the customer network to or from AWS. Each VPN connection includes two VPN tunnels wich you can simultaneously use for high availability.    
**• Customer Gateway:** An AWS resource which provides information to AWS about your customer gateway device.   
**• Customer Gateway Device:** A physical device or software application on your of the Sit-to-Site VPN connection.    
**• Target Gateway:** A generic term for the VPN Endpoint on the Amazon side of the Site-to-Site VPN conenction.    
**• Virtual Private Gateway:** A virtual private gateway is a VPN endpoint on the Amazon side of your Site-to-Site VPN connection that can be attached to a single VPC.   
**• Transit Gateway:** A Transit hub that can be used to interconnect multiple VPCs and on-premise networks, and a VPN endpoint for the Amazon side of the Site-to-Site VPN connection.   

# VPC Endpoints    

A VPC Endpoint enables connections between a VPC and supported services, without requiring the use of internet gateways, NAT Devices, VPN connections, AWS Direct Connect connections. Therefore, you control the specific API endpoints, sites, and services that are reachable from your VPC.   

VPC Endpoints are virtual devices. They are horizontally scaled, redundant, and highly available VPC components. The following are the different types of VPC Endpoints that is is required by the supported device.   

**• Interface Endpoints:** An interface endpoint is an elastic network interface with a private IP address from the IP address range of your subnet. It serves as an entry point for traffic destined to a service that is owned by AWS or owned by an AWS customer or partner.    
**• Gateway Loadbalance Endpoints:** A Gateway Load Balancer Endpoint os an elastic network interface with a private IP address from the IP address range of your subnet. It serves as an entry point to intercept traffic and route it to a network or security service that you've configured using a Gateway Load Balancer. You specify a Gateway Load Balancer Endpoint as a target for a route in a route table. Gateway Load Balancer Endpoint are supported only for endpoint services that are configured using the Gateway Load Balancer.     
**• Gateway Endpoints:** A Gateway Endpoint is a gateway that is a target for a route in your route table used for traffic destined to either Amazon S3 or DynamoDB.  
   
**Endpoint Services: Are referred to as the application or service in your VPC. Other AWS principals can create an endpoint from their VPC to your endpoint service.**   

# Network Analytics  

**You can use the following tools to monitor traffic or network access in your virtual private network.**    

**• VPC Flows Logs:** VPC Flows Logs capture detailed information about the traffic going to and from network interfaces within your VPC.    
**• VPC IP Address Manager (IPAM):** IPAM plans, tracks, and monitors IP addresses for your workloads. More so an IP address assignment manager.   
**• VPC Traffic Mirroring:** You can use this feature to copy network traffic from a network interface of an Amazon EC2 instance and send it to out-of-band security and monitoring appliances for deep packet inspection. You can detect network and security anomolies, gain operational insights, implement compliance and security controls, and troubleshoot issues.   
**• VPC Reachability Analyzer:** Used to analyze and debug reachability between two resources in your VPC. After you specify the source and destination resources, Reachability Analyzer produces hop-by-hop details of the virtual path between them when they are reachable, and identifies a blocking component when they are unreachable.    
**• Network Access Analyzer:** Used to understand network access to your resources. This helps you indentify improvements to your network security posture and demonstrate that your network meets specific compliance requirements.   
**• CloudTrail Logs:** Captures detailed information about the calls made to the Amazon VPC API. You can use the generated CloudTrail logs to determine which calls were made, the source IP address where the call came from, who made the cal, when the call was made, and so on.    
   
# Additional Resources involved with Amazon VPC   

**• Network Security Groups**
**• Network Access Control Lists (ACLs)   
**• Route53**    
**• DNS Firewall**  
**• Network Firewall**
    
