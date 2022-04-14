# What is Amazon EC2?
Computing capacity provisiioned on the AWS cloud to be used as scalable alternative to investing in hardware up front.
You can use amazon EC2 to launch as many servers as needed, configure security and networking, and manage storage,
Amazon EC2 enables you to scale up and down to adapt to changes in resource requirements needed in order to keep
operating costs lows and applications running smoothly.

## Features of Amazon EC2

• Virtual computing environments known as instances.  
• Preconfigured templates for instance (AMIs).   
• Various configurations of CPU, memory, and storage depending on the instance type selected.   
• Storage volumes for temporay storage or persistant storage know Elastic Block storage (EBS).   
• Multiple physical location for instance, such as instances and EBS volumes.   
• Firewall that enables you to specify the protocols, ports, and IP address used to reach you instances.   
• Static IP addresses.   
• Metadata, known as tags.   
• Virtual networks that are logically isolated from the rest of the AWS.

## EC2 Pricing

There are multiple ways of purchasing EC2 instances with the following options
   
• On-Demand Instances: Pay by the second. For the instances you launch.   
• Spot Instances: Request unused EC2 instances.   
• Reserved Instances: Commitment to instances with consistent configuration, instance type, and region for a term of 1 to 3 years.   
• Capacity Reservations: Reserve capacity for you instances in a specific availability zone for any duration.   
• Saving Plans: Commitment to instances with a consistent amount of usage ($USD/hr) for a term of 1 to 3 years.   
• Dedicated Instances: Pay by the hour, for instances that run on single tenant hardware.   
• Dedicated Hosts: Paid physical host fully dedicated to running instances. Bring existing per-socket, per-core, per-VM software licences.

## Instance Types

The Instance type, when launching an instance, determines the hardware of the host computer used. Each instance type
offers different compute, memory, and storage capabilities. As well, instance types are grouped into instance families
based on these capabilities.  

These instance families are categorized in the following ways   
   
• General Purpose Instance   
• Compute Optimized instances   
• Memory Optimized Instances   
• Storage Optimized Instances   
• Linux Accelerated Computing Instances  
• Instances Built on the Nitro System

## Instance Fleets

Within a single API call to AWS, you have the ability to launch multiple instance types across multiple Availability Zones, using On-Demand, Reserved, or Spot purchasing options.
   
#### EC2 On-Demand and Spot Fleets tend to be used together when working with Instance Fleets.   
   
• Define seperate On-Demand and Spot capacity targets and the maximum amount you're willing to pay per hour.   
• Specify the instance type that work best for you applications.   
• Specify how Amazon EC2 should distibute your fleet capacity within each purchasing option.

** When specifying the maximum amount per hour you are willing to pay for you fleet, EC2 fleet will continue to provision instances to reach the target capacity until the expense amount has exceeded the maximum pay amount.   

## Instance Storage

AWS offers multiple ways of storing EC2 instance data with the following.
    
#### Amazon Elastic Block Store   
   
• Amazon EBS provides block level storage volumes that you can attach and detach from EC2 instances.   
• The volume persists independently from the actual instance.   
• Multiple volumes are able to be attached to a single EC2 instance.   
• You can dynamically change the configurations options of an EBS volume. Even while it connected to an instance.   
• EBS volumes can also be created as encrypted volumes using the EBS encryption feature.    

#### Amazon EC2 Instance Store    
  
Provide temporary block level storage to an instance when it is running. The data on the instance store only persists during the life of the associated instance.   
   
** If you stop, hibernate, or terminate an instance, any data on instance store volumes is lost.   
   
#### Amazon EFS with Amazon EC2   
    
Provides scalable file storage for use with Amazon EC2. When creating an EFS file system, you can configure instances to mount the file system. This allows for multiple workload and applications running on multiple instances to acces this as a common data source.   

#### Amazon S3 with Amazon EC2    
   
Amazon S3 storage is designed to make web-scale computing easier by enabling you to store and retreive any amount of data, at any time, from within Amazon EC2 or anywhere on the WEB.   
   
Example: You can use Amazon S3 to stora snapshot of EBS volumes in S3 Buckets at a low cost.

## Additional Resources involved with EC2   

• Amazon AMI  
• Amazon Launch Templates   
• Amazon Auto Scaling Groups   
• Amazon Launch Configurations   
• Amazon Load Balancers       
• Amazon Networking/Security Section

   

   

