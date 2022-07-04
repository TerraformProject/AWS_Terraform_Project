# ECS ECR Module Manual

The module below allows you to manage a ECR registry andrepositories. Please use the sections below to specify values.     

**Supportive Documents**       

[ECR Resource Reference](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)      

[ECR API Reference](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/Welcome.html)    

### Registry Policy

This section of the module allows you to create an ECR Registry access policy

```Terraform
####################################
#- Registry Policy ----------------#
####################################
#- Configuration Notes ------------#

#----------------------------------#
registry_access_policy_file = "" # Local path to policy file with valid JSON syntax
```     

### Registry Scanning Configuration     

Please use the section below to specify how ECR will scan images in private repositories based on the provided rules below.    

```Terraform
####################################
#- Registry Scanning Config -------#
####################################
#- Configuration Notes ------------#

#----------------------------------#
scan_type = "" # BASIC | ENHANCED
scan_rules = {
    # If scan_frequency == "SCAN_ON_PUSH", the scan_on_push attribute in repository 
    # config must == true for filter to apply.
    # scan_frequency == CONTINUOUS_SCAN overrides scan_on_push == true value in repository
    # ABLE TO CREATE MORE THAN ONE RULE
    #------------------------------#
    rule_000 = {
        enabled = # Whether or not this rule is enabled
        filter = "" # A prefix match to a repository | Able to use * in prefix to filter multiple repositories
        scan_frequency = "" # SCAN_ON_PUSH | CONTINUOUS_SCAN 
    }
    #------------------------------#
}
```     

### ECR Replication Configuration        

Please use the section below to specify what repositories will be replicated.     

**Important Note:** There can be no more than 10 rules to apply to replication configuration.    

```Terraform
####################################
#- Replication Config -------------#
####################################
#- Configuration Notes ------------#

#----------------------------------#
replication_config_rules = {
## Maximum 10 rules
## ABLE TO CREATE MORE THAN ONE RULE
    #------------------------------#
    rule_000 = {
        #- Enable Replication Configuration -#
        enabled = false # Whether or not to enable this replication configuration
        #- Select Repository -#
        ecr_repo_name = "" # Specified ECR repo name must be a prefix match
        #- Select Destination -#
        destination = {
            region = "" # Required
            registry_id = "" # Required, account ID of the destination registry
            # Specify "self" within registry_id if this replication config is within 
            # same account but different region
        }
    }
    #------------------------------#
}
```      

### ECR Private Repositories       

Please use the section below to specify and configure the number of private repositores to be created and managed in the ECR registry.   

**Supportive Documents**     

[KMS Key Resource Reference](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)          

```Terraform
##############################
## ECR Private Repositories ##
##############################
#- Configuration Notes ------------#

#----------------------------------#
ecr_repositories = {
# ABLE TO CREATE MORE THAN ONE REPOSITORY
    #------------------------------#
    ecr_repo_000 = {
        #- General -#
        name = "" # Name for the repository
        image_tag_mutability = "" # MUTABLE | IMMUTABLE
        #- Pull Through Cache -#
        enable_pull_through_cache = false # Forces new resource if set to true from false
        upstream_registry_url = "" # URL of public repository to create a initial pull and following pull cache from
        #- Lifecycle Hook -#
        enable_lifecycle_hook_policy = false # Whether or not enable a lifecycle hook for the repository
        lifecycle_hook_policy_file = "" # Local path to policy file with valide JSON syntax
        #- Scanning ---------------#
        scan_on_push = false # Whether or not images pushed to this repository will undergo scanning for OS and application security
        #- Encryption -------------#
        encryption_type = "" # AES256 | KMS
        existing_kms_key_arn = "" # Existing ARN of KMS key to use to encrypt this repository
        new_kms_key = {
            key_name = "" # Name of KMS key to be merged with tags
            description = "" # Description of the KMS key
            is_enabled = false # Whether or not this KMS is enabled
            key_usage = "" # ENCRYPT_DECRYPT | SIGN_VERIFY
            cstmr_mstr_key_spec = "" # Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms
            enable_key_rotation = false # Whether or not key rotation is enabled
            multi_region = false # Whether or not this key is multi-region
            policy_file = "" # Local file path to policy file with valid JSON syntax
            bypass_policy_lockout_safety_check = false # A flag to indicate whether to bypass the key policy lockout safety check
            deletion_window_in_days = 7 # Must be betwen 7 - 30 days
            kms_tags = {} # Tags to associate with the KMS key
        }
        #- Access Policy ----------#
        repo_access_policy_file = "" # Local path to policy file with valid JSON syntax
        #- Tags -------------------#
        repo_tags = {} # Tags to associate with the repository
    }
    #------------------------------#
}
```      

# ECR Repositories Sample Output    

Please use the samples below to output the values as needed.    

```Terraform
##########################################
## Elastic Container Repository Outputs ##
##########################################
#- Sample -----------------------------#
# output "ecr_repository_index_key_export_attribute" {
#   value = aws_ecr_repository.ecr_repo["ecr_repository_index_key"].export_attribute
# }
#--------------------------------------#
```

