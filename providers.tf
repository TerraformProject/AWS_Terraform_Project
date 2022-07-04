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
# ## Terraform Test Folder ##
# ############################       

module "GET_TEST_INPUT_FOLDER" {
source = "./Test_Modules/Input_Modules"
}

# ############################
# ## Terraform Stage Folder ##
# ############################       

# module "GET_STAGE_INPUT_FOLDER" {
# source = "./Stage_Modules/Input_Modules"
# }

