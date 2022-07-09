module "ECS_CLUSTER_AWS_PROJECT" {
source = "../Back_End_Modules/ECS_Clusters-Module.tf"

##################
## ECS Clusters ##
##################
#- Configuration Notes ---------------------#

#-------------------------------------------#
ecs_clusters = {
    #---------------------------------------#
    cluster_000 = {
        #- ECS CLuster -#
        name = "testcluster"
        #- ECS Services -#
        services = {
            #-------------------------------#
            serv_000 = {
                #- Service -#
                name = ""
                existing_task_definition_name = ""
                task_definitition_index_key = ""
                iam_role = ""
                #- Capacity Provider Strategy -#
                default_capacity_provider_name = ""
                capacity_providers = {
                    #-----------------------#
                    cp_000 = {
                        name = ""
                        base = 1
                        weight = 100
                        
                    }
                    #-----------------------#
                }
            }

        }

        #- Capacity Provider Strategy -#
        strategy = {
            default_capacity_provider = {

            }
                #---------------------------#
                prov_000 = {

                }
                #---------------------------#
            
        }
        #- Host-Container Encryption -#
        kms_key_id = ""
        new_kms_key = {
            key_name = "testkey"
            description = ""
            is_enabled = true
            key_usage = "ENCRYPT_DECRYPT" # # ENCRYPT_DECRYPT | SIGN_VERIFY
            customer_master_key_spec = ""
            enable_key_rotation = false
            multi_region = false
            policy_file = ""
            bypass_policy_lockout_safety_check = false
            deletion_window_in_days = 7
            kms_tags = {}
        }
        #- Metric Log Configuration -#
        enable_container_insights = false
        logging = "OVERRIDE" # DEFAULT | OVERRIDE | NONE
        log_exports = {
            cloudwatch = {
                enabled = false
                log_group_name = ""
                encryption_enabled = false
            }
            s3_bucket = {
                enabled = true
                bucket_name = "test-383845834583485"
                bucket_folder = "testbucketfolder"
                encryption_enabled = false
            }
        }
    cluster_tags = {}
    }
    #---------------------------------------#
}


###################
## End of Module ##
###################
}