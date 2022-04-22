# ECR Module

```
In this module the user is able to create:
    1   -   More than one ECR repository.
        1a - Create ECR Repository.
        1b - Create new KMS key for ECR Encryption.
        1c - Create ECR Repository Policy.
        1d - Create ECR Lifecycle Policy.
        1e - Create ECR Replication Configuration.
```

Use the following example below to use as a reference for creating more than one ECR repository

[ECR Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)

[KMS Key Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)

[ECR Repository Policy Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy)

[ECR Lifecycle Policy Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy)

```terraform

####################
## ECR Repository ##
####################
create_ecr_repositories = true # Whether to create ECR Repositories
ecr_repositories = {

    ## Able to create more than one ECR Repository. Copy and paste example below

    ecr_1 = { # Module key for the repository. Must be unique. Terraform does not process duplicates
        ## ECR Settings ##
        ecr_name = "" # Name of the ECR Repository
        image_tag_mutability = "" # Tag mutability setting for the repository
        scan_on_push = true # Whether images are scanned if they are pushed into this ECR Repository
        ## ECR Encryption ##
        encryption_configuration = {
          value = {
            enabled = false # Whether the ECR Repository should be encrypted
            encryption_type = "" # Type of encryption for the ECR Repository
            kms_key = "" # encryption_type must == "KMS". Existing KMS key ARN to use for encrypting the ECR Repository
            new_kms_key = {
                enabled = false # Whether to create a new KMS key to encrypt the ECR Repository
                description = "" # Required, must be unqiue. Used for module reference
                enable_key_rotation = true # Whether to enable key rotation
                deletion_window_in_days = 7 # Number of days the KMS key is active before deletion
                policy = "" # Policy to attach to the KMS key
                kms_tags = { "Key" = "Value" } # Tags to associate to the KMS key
        }}}
        ## Repository Policy ##
        repository_policy = {
            enabled = true # Whether to add a repository policy to the ECR Repository
            module_key = "" # Required, must be unique. Used for module reference            
            ecr_repo_policy_local_path = "" # Local path to JSON file containing repository policy
        }
        ## Lifecycle Policy ##
        lifecycle_policy = {
            enabled = true # Whether to add a lifecycle policy to the ECR Repository
            module_key = "" # Required, must be unique. Used for Module reference
            ecr_lifecycle_policy_local_path = "" # Local path to JSON file containing lifecycle policy
        }
        ## Tags ##
        ecr_tags = {
            "key" = "value" # Tags to associate with the ECR Repository
        }
    }

###############################
## Replication Configuration ##
###############################
create_replication_configuration = false # Whether to create a Replication Configuration
replication_configuration = {
    rules = {

        ## Able to create more than one destination for ECR Replication. Copy and paste example below

        destination_1 = {
            region = "" # AWS Region the destination ECR repository is located for replication
            registry_id = "" # Account ID the destination ECR Repository is located in for replication 
        }

    }
}

}

```