terraform {
  required_providers {
     aws = {
      source  = "hashicorp/aws" //The source for where to pull terraform modules from
     # version = "~> 2.0" //Pull all compatible modules above version 2.70 
     }
     
     github = {
      source = "integrations/github"
      version = "4.9.4"
     }
  } 
}

provider "aws" {
  region                  = "us-east-1" //AWS destination region for terraform modules
  #shared_credentials_file = AWS_SHARED_CREDENTIALS_FILE
  profile = "AWSeducate"//Profile used to provision and destroy resources.
}

# ############################
# ## Terraform Apply Folder ##
# ############################       

module "GET_APPLY_FOLDER" {
source = "Implemented_Modules/Apply_Values"
}

# #####################
# ## Compute Modules ##
# #####################       

/* module "GET_COMPUTE_MODULES" {
source = "./Implemented_Modules/Compute"
} */


##################
# CI/CD Modules ##
##################

#     ###########################
#     ##  CI/CD Source Modules ##
#     ###########################

#     module "GET_CICD_SOURCE_MODULES" {
#       source = "./Input-Values/CICD/Source"
#     }

#     ##########################
#     ##  CI/CD Build Modules ##
#     ##########################

#     module "GET_CICD_BUILD_MODULES" {
#       source = "./Input-Values/CICD/Build"
#     }

#     ###############################
#     ##  CI/CD Deployemnt Modules ##
#     ###############################

#     module "GET_CICD_DEPLOYMENT_MODULES" {
#       source = "./Input-Values/CICD/Deployment"
#     }

#     ############################
#     ## CI/CD Pipeline Modules ##
#     ############################

#     module "GET_CICD_PIPELINE_MODULES" {
#       source = "./Input-Values/CICD/Pipeline"
#     }

# ####################
# # Network Modules ##
# ####################

#   module "GET_NETWORK_MODULES" {
#     source = "./Input-Values/Network-Input-Values"
#   }

# #################
# ## IAM Modules ##
# #################       

# module "GET_IAM_ROLES_POLICIES" {
# source = "./Input-Values/Security/IAM"
# }

# ########################
# ## Monitoring Modules ##
# ########################

# module "GET_MONITORING_MODULES" {
#   source = "./Input-Values/Security/Monitoring"
# }
       
# #####################
# ## Storage Modules ##
# #####################

# module "GET_STORAGE_MODULES" {
#   source = "./Input-Values/Storage"
# }

###################
# Tesing Modules ##
###################

# module "GET_TESTING_MODULES" {
#   source = "./Input-Values/Testing-Input"
# }