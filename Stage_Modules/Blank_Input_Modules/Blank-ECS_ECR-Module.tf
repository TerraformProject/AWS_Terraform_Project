module "BLANK_ECS_ECR_AWSPROJECT" {
source = ""

####################################
#- Registry Policy ----------------#
####################################
#- Configuration Notes ------------#

#----------------------------------#
registry_access_policy_file = "" # Local path to policy file with valid JSON syntax

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
    #------------------------------#
    rule_000 = {
        enabled = false
        filter = ""
        scan_frequency = "" # SCAN_ON_PUSH | CONTINUOUS_SCAN 
    }
    #------------------------------#
}

####################################
#- Replication Config -------------#
####################################
#- Configuration Notes ------------#

#----------------------------------#
replication_config_rules = {
## Maximum 10 rules
    #------------------------------#
    rule_000 = {
        #- Enable Replication Configuration -#
        enabled = false
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

##############################
## ECR Private Repositories ##
##############################
#- Configuration Notes ------------#

#----------------------------------#
ecr_repositories = {
    #------------------------------#
    ecr_repo_000 = {
        #- General -#
        name = ""
        image_tag_mutability = "" # MUTABLE | IMMUTABLE
        #- Pull Through Cache -#
        enable_pull_through_cache = false # Forces new resource if set to true from false
        upstream_registry_url = ""
        #- Lifecycle Hook -#
        enable_lifecycle_hook_policy = false
        lifecycle_hook_policy_file = "" # Local path to policy file with valide JSON syntax
        #- Scanning ---------------#
        scan_on_push = false
        #- Encryption -------------#
        encryption_type = "" # AES256 | KMS
        existing_kms_key_arn = ""
        new_kms_key = {
            key_name = ""
            description = ""
            is_enabled = false
            key_usage = "" # ENCRYPT_DECRYPT | SIGN_VERIFY
            cstmr_mstr_key_spec = ""
            enable_key_rotation = false
            multi_region = false
            policy_file = "" # Local file path to policy file with valid JSON syntax
            bypass_policy_lockout_safety_check = false
            deletion_window_in_days = 7 # Must be betwen 7 - 30 days
            kms_tags = {}
        }
        #- Access Policy ----------#
        repo_access_policy_file = "" # Local path to policy file with valid JSON syntax
        #- Tags -------------------#
        repo_tags = {}
    }
    #------------------------------#
}


###################
## END OF MODULE ##
###################
}