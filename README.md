### (In-Progress) - AWS Compute  

**7/4/2022 Comment:" Hello Again! Another module has been pushed into production. Very happy that this was complete within a day. Still have several more compute modules to push into production before the next deliverable is complete. Nevertheless, there is progress to be shown!   

#### ECR Elastic Container Registry (ECR) Module    

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/ECS_ECR-Module-Manual.md)    

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-ECS_ECR-Module.tf)     

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/ECS_ECR-AWS_PROJECT.tf)         

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/ECS_ECR-Module)    

**Modules currently being worked**    

[Sandbox Modules](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Sandbox_Modules/)     
      
[Test Modules](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Test_Modules/)    

**All modules currently in production**   

[Production Modules](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/) 

If there are any questions, feel free to reach out.

Thank you all!
nzebar


**7/3/2022 Comment:** Hello! Apologies for the wait in pushing modules to production. A lot of changes happening within the past month.       

To show some progress, although not a full deliverable, I have added the following Compute module to production for everyone to review.     


#### EC2 Launch Template Module     

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/EC2_Launch_Template-Module-Manual.md)    

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-EC2_Launch_Template-Module.tf)     

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/EC2_Launch_Template-AWS_PROJECT.tf)         

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/EC2_Launch_Template-Module)    

**NOTE:** My next initiative will be to work with previous ECS modules I have created. Getting them working with the stage environment and then pushing to production. To view these modules being worked on, please reference the link below to the testing directory where they will be located.      

If there are any questions, feel free to reach out.    

Thank you all!     
nzebar   

**Modules currently being worked**    

[Sandbox Modules](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Sandbox_Modules/)     
      
[Test Modules](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Test_Modules/)    

**All modules currently in production**   

[Production Modules](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/)        

#----------------------------------------------------------------------------------------------------#

### 6/5/2022 - AWS Network Module(s)

**Comment:** Hello Everyone! Below consists of the first deliverable creating using the modules specified below. Now that the foundation for the network is in place, the next deliverable will consist of AWS compute resources. Such as AMI(s), Launch Templates, Auto Scaling Groups, etc...

**If there are any questions, feel free to reach out! Any feedback is appreciated!**

Best,
nzebar

![Architecture Design for this Project](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Project_Images/Deliverable%201%20-%20AWS%20Project.png)

**The following AWS resources can be provisioned using the Network Modules below**

**Important Note:** Although the modules created below were all used to create the diagram above, all modules are independent and can serve their functionality seperately.

#### AWS VPC Module

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/VPC-Module-Manual.md)

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-VPC-Module.tf)

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/VPC-AWS_PROJECT.tf)

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/VPC-Module)

#### AWS VPC Route Tables Module

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/VPC_Route_Tables-Module-Manual.md)

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-VPC_Route_Tables-Module.tf)

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/VPC_Route_Tables-AWS_PROJECT.tf)

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/VPC_Route_Tables-Module)

#### AWS VPC Subnet ACL Module

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/VPC_Subnet_ACL-Module-Manual.md)

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-VPC_Subnet_ACL-Module.tf)

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/VPC_Subnet_ACL-AWS_PROECT.tf)

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/VPC_Subnet_ACL-Module)

#### AWS VPC ACL Subnet Module

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/VPC_ACL_Subnet-Module-Manual.md)

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-VPC_ACL_Subnet-Module.tf)

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/VPC_ACL_Subnet-AWS_PROJECT.tf)

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/VPC_ACL_Subnet-Module)

#### AWS Load Balancer Module

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/Load_Balancer-Module-Manual.md)

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-Load_Balancer-Module.tf)

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/Load_Balancer-AWS_PROJECT.tf)

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/Load_Balancer-Module)

#----------------------------------------------------------------------------------------------------#

### 4/25/2022 - AWS VPC Quick Start Module

**The following AWS resources can be provisioned using the module AWS Quick Start below**
• AWS VPC
• AWS VPC GATEWAYS
• AWS VPC DEFAULT ROUTE TABLE
• AWS VPC ROUTE TABLES
• AWS VPC SUBNETS
• AWS VPC DEFAULT ACL
• AWS VPC DEFAULT SECURITY GROUP

#### Documents

[Module Manual](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Module_Manuals/Module-Manual-VPC-QuickStart-Module.md)

[Blank Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Blank_Input_Modules/Blank-VPC-QuickStart-Module.tf)

[Use Case Scenario: Input File](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Production_Modules/Input_Modules/VPC_QuickStart_AWS_PROJECT.tf)

[Use Case Scenario: Back End Module](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Production_Modules/Back_End_Modules/VPC-QuickStart-Module)

**If there are any questions, feel free to reach out! Any feedback is appreciated!**

Best,
nzebar

#----------------------------------------------------------------------------------------------------#

# AWS\_Terraform\_Project

![Architecture Design for this Project](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Project_Images/Architecture%20Design%20for%20the%20Project%20(1).png)

**Below is a link to the folder that contains modules created prior to this current work effort.**

[Old-Repository Folder](https://github.com/TerraformProject/AWS_Terraform_Project/tree/master/Old_Repository)