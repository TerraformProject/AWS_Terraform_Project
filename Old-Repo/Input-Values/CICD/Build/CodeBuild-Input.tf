module "CODEBUILD_VPC1" {
    source = "../../../Modules/CICD-Modules/CodeBuild-Modules"

#############################################
## CodeBuild Project Source Authentication ##
#############################################

    # Authentication to a github/github_enterprise source
        # provider "github" {
        #     token = ""
        #     base_url = ""
        #     owner = ""
        #     organization = ""
        # }

    # Authentication to a bitbucket registry
        # provider "bitbucket" {
        #     server = ""
        #     username = ""
        #     password = "" 
        # }

    # TO AUTHENTICATE TO AN ECR REGISTRY USE THE REGISTRY_CREDENTIALS 
    # IN THE ENVIRONMENT_SECTION OF THE BELOW CODEBUILD PROJECT

    # TO AUTHENTICATE TO CODECOMMIT REPOSITORY, ENSURE THE SERVICE ROLE HAS THE
    # REQUIRED PERMISSIONS TO DO SO

########################
## CodeBuild Webhooks ##
########################

# PLEASE ENSURE THE PROVIDERS ABOVE HAVE BEEN SPECIFIED TO CREATE THE DESIRED WEBHOOKS BELOW

# AS WELL, UNCOMMENT THE DESIRED WEBOOK CREATING RESOURCES IN THE MAIN.TF FILE

    create_github_webhook = false
    github_webhook = {
        settings = {
            active = true
            events = ["push"]
            name = "webook_yuh"
            repository = ""

            configuration = {
                url = ""
                secret = ""
                content_type = "json"
                insecure_ssl = false
            }

        }
    }

    create_bitbucket_webhook = false
    bitbucket_webhook = {
        settings = {
            owner = ""
            repository = ""
            url = ""
            description = ""  

            events = [""]
        }
    }

#######################
## CodeBuild Project ##
#######################

    create_codebuild_project = true
    project_name = "prjectYUH"
    project_description = ""
    service_role_arn = ""

    ###############################
    ## CodeBuild Project Sources ##
    ###############################

    source_version = "master"
    primary_source = {
        type = "GITHUB"
        buildspec = ""
        location = ""
        git_clone_depth = 1
        insecure_ssl = false
        git_submodules_config = {
           fetch_submodules = false # Value taken only if type == CODECOMMIT || GITHUB || GITHUB_ENTERPRISE 
        }   
        report_build_status = false # Value taken only if type == BITBUCKET || GITHUB || GITHUB_ENTERPRISE
        build_status_config = {
            context = ""
            target_url = "" 
        }
    }

    create_secondary_sources = true
    secondary_sources = {
    source_1 = {
        type = "GITHUB"
        buildspec = ""
        source_identifier = ""
        location = ""
        git_clone_depth = 1
        insecure_ssl = false
        git_submodules_config = {
            fetch_submodules = false # Value taken only if type == CODECOMMIT || GITHUB || GITHUB_ENTERPRISE  
        }   
        report_build_status = false # Value taken only if type == BITBUCKET || GITHUB || GITHUB_ENTERPRISE
        build_status_config = {
            context = ""
            target_url = "" 
        }
      }
    }

    #################################
    ## CodeBuild Project Artifacts ##
    #################################

    artifacts = {
        type = "CODEPIPELINE"
        name = ""
        override_artifacts_name = false 
        namespace_type = ""
        artifact_identifier = "" 
        location = ""
        path = ""
        packaging = ""
        encryption_disabled = false   
    }

    create_secondary_artifacts = true
    secondary_artifacts = {
    artifact = {
        type = "CODEPIPELINE"
        name = ""
        override_artifacts_name = false 
        namespace_type = ""
        artifact_identifier = "atrifactyuh" # Required 
        location = ""
        path = ""
        packaging = ""
        encryption_disabled = false
    }
    }

    ###################################
    ## CodeBuild Project Environment ##
    ###################################

    environment = {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/standard:1.0"
        privileged_mode             = false
        type                        = "LINUX_CONTAINER"
        image_pull_credentials_type = "SERVICE_ROLE"
        certificate = ""
        create_registry_credential = true # If true, image_pull_credentials_type == SERVICE_ROLE
            registry_credential = {
                credential = ""
                credential_provider = "SECRETS_MANAGER"
            }
        create_environment_variables = false
        environment_variable = {
            variable_1 = {
                name = ""
                value = ""
                type = ""
            }
        }
    }

    create_cache = false
    cache = {
        cache = {
            type     = "NO_CACHE"
            location = ""
            modes = []
      }
    }

    #############################################
    ## CodeBuild Project Network Configuraiton ##
    #############################################

    create_vpc_config = false
    vpc_config = {
      config = {
        vpc_id = ""
        subnets = [""]
        security_group_ids = [""]
      }
    }

    concurrent_build_limit = null
    create_build_batch_config = false
    build_batch_config = {
    config = {
        combine_artifacts = false
        restrictions = {
            compute_types_allowed = ["BUILD_GENERAL1_SMALL"]
            maximum_builds_allowed = 2
        }
        service_role = ""
        timeout_in_mins = 10
        }
    }

    ############################
    ## CodeBuild Project Logs ##
    ############################

    create_logs_config = false
    logs_config = {
        logs = {
        create_cloudwatch_logs = false
        cloudwatch_logs = {
          values = {
            status = "DISABLED"
            group_name = ""
            stream_name = ""
          }
        }
        create_s3_logs = false
        s3_logs = {
          values = {
            status = "DISABLED"
            location = "" # If specified, status == ENABLED
            encryption_disabled = false
          }
        }
      }
    }

    ####################################
    ## CodeBuild Project Report Group ##
    ####################################

    create_report_group = true
    report_group = {
        group = {
            name = "groupyuh"
            type = "TEST"
            delete_reports = false
            export_config = {
                type = "S3"
                s3_destination = {
                    bucket = ""
                    encryption_key = ""
                    encryption_disabled = false
                    packaging = "ZIP"
                    path = "" 
                }
            }
            tags = {
                "key" = "value"
            }
        }
    }

    ############################
    ## CodeBuild Project Tags ##
    ############################

    codebuild_project_tags = {
        "key" = "value"
    }
}