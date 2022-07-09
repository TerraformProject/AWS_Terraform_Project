# Jenkins on AWS Fargate

## Installing Jenkins and creating container in Docker

#### Step 1

First we must pull from a repository hosting a Jenkins image file.
For this example I have pulled a Jenkins Image file from the official Jenkins repository on dockerhub.
[Link to Official Repository for Jenkins Container](https://hub.docker.com/r/jenkins/jenkins/)

In the pictures below you will notice that the specific Jenkins image file being pulled is the latest LTS container.
The latest weekly release of Jenkins includes new features and/or updates to Jenkins in process of being implemented.
Therefore, for best practice the Latest LTS release of Jenkins will be pulled for this use case.


![Pulling Jenkins container](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/Pulling%20Jenkins%20container.JPG)


![DockerPullJenkinsLTS](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/DockerPullJenkinsLTS.JPG)


<br>
#### Step2

Once the Jenkins Image has successfuly been pulled, we are now able to quickly create a Docker container with this Image file as the base.

Please take note of parameters:
-d # Specified that the container created from the Jenkins image file will be running as a background process.
-p # Specified the port mapping of container port to host port for Docker to route traffic appropriately.

![DockerRunJenkins](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/DockerRunJenkins.JPG)

<br>
## Initial Setup of Jenkins and Plugins

Step1
Now that we have quickly created a Jenkins container to connect to, please refer to the container setup logs as this is where the admin password is provided and needed for initial Jenkin setup.


![JenkinsAdminPassword](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/JenkinsAdminPassword.JPG)

Step2
With the copied admin password needed for initial Jenkins setup, please open a web browser to connect to the Jenkins container created above.

Please Note:
The password specified is taken from the logs generated in the step above.

![InitialJenkinsLogin](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/InitialJenkinsLogin.JPG)

Step3
Next we are given the two options of either selecting "Install suggested pluggins" or "Select plugins to install"

Every use case for Jenkins is unique. Therefore, we will select the "Select plugins to install" as this provides is more control in our initial installation.

Please note the selected additional plugins for the initial install. We will able to add/manage/remove additional plugins later on.

![Select Plugins to install](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/Select%20Plugins%20to%20install.JPG)

Additional Plugins:
\* means plugins for this use case. Other plugins are optional and experimenting is recommended.
\* - Dashboard view.
\* - Configuration as Code
\* - JUnit
\* - Conditional Buildstep
\- Copy Artifact
\- BitBucket
\* - Git Parameter
\* - GitHub
\- Git
\- GitLab

![Initiall install plugins](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/Select%20Plugins%20to%20install.JPG)


![Installing](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/Installing.JPG)

<br>
Step 4
Once all of the plugins have been installed we are now able to specify the credentials for the first admin user.

![NewAdminUser.JPG](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/NewAdminUser.JPG)

<br>
Please note:
The next page will ask to specify the URL that will used by external source when connecting to Jenkins Resources. For this use case, the localhost URL will suffice for now.

![InstanceConfig.JPG](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/InstanceConfig.JPG)

Step 5
After being directed to the home page for jenkins we will need to the following plugins that were not included in the initial setup.

From the home page, select the Manage Jenkins tab from the left most column. Then select the manage plugins to be taken to the Plugin Manager page.


![PostInstallPlugins](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/PostInstallPlugins.JPG)

Then select available plugins.

Please use the search bar to install the following plugins
\- Terraform
\- AWS CodePipeline
\- Amazon EC2 Container Service plugin with autoscaling capabilities

You have the option of either installing the plugins with/without a Jenkins restart. Since we do not have any jobs created yet yet, installing the plugins without a Jenkins restart will suffice.

![Available Plugins](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/Available%20Plugins.JPG)

You will now see the selected plugins begin to install to install until completion.

![PluginInstallComplete](https://github.com/TerraformProject/AWS_Terraform_Project/blob/master/Notes/Jenkis%20-%20Notes/Jenkins%20AWS%20Fargate%20Imgs/PluginInstallComplete.JPG)