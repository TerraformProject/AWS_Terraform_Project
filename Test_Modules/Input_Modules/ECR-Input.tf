module "ECR_VPC1" {
    source = "../../Modules/CICD-Modules/ECR-Modules"

###############################
## Replication Configuration ##
###############################
create_replication_configuration = false
replication_configuration = {
    rules = {
        destination_1 = {
            region = "us-east-1"
            registry_id = "234614842418" 
        }
    }
}

####################
## ECR Repository ##
####################
create_ecr_repositories = true
ecr_repositories = {

    ecr_1 = {
        ## ECR Settings ##
        ecr_name = "Wordpress_001_ECR"
        image_tag_mutability = "MUTABLE"
        scan_on_push = true
        ## ECR Encryption ##
        encryption_configuration = {
          value = {
            enabled = true
            encryption_type = "KMS"
            kms_key = ""
            new_kms_key = {
                enabled = false
                description = "ECR_001_KMS_001" # Required, must be unqiue
                enable_key_rotation = false
                deletion_window_in_days = 7
                policy = <<EOF
                {
                "Sid": "Enable IAM policies",
                "Effect": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "kms:*",
                "Resource": "arn:aws:kms:us-east-1:092968731555:key/"
                }
                EOF
                kms_tags = { "Key" = "Value" }
        }}}
        ## Repository Policy ##
        repository_policy = {
            enabled = true
            module_key = "Wordpress_001_ECR_Policy_001" # Required, must be unique
            ecr_repo_policy_local_path = "Input-Values\\Compute\\Scripts\\ECR-Policy.json"
        }
        ## Lifecycle Policy ##
        lifecycle_policy = {
            enabled = false
            module_key = "" # Required, must be unique
            ecr_lifecycle_policy_local_path = ""
        }
        ## Tags ##
        ecr_tags = {
            "" = "value"
        }
    }

}

}