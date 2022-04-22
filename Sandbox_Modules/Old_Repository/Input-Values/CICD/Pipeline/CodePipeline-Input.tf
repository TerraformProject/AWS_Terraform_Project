module "CODEPIPELINE_VPC1" {
    source = "../../../Modules/CICD-Modules/CodePipeline-Modules"

    create_codepipeline = true
    codepipeline_name = "pipe_yuh"
    codepipeline_role_arn = ""

    artifact_store_location = ""
    artifact_store_type = "S3"
    encryption_key_id = ""
    encryption_key_type = "KMS"
    enable_cross_region_artifact_storage = false
    region = "" # DO NOT SPECIFY UNLESS ARTIFACT ARTIFACT STORAGE LOCATION IS IN A SEPERATE REGION

    codepipeline_stages = {
        stage_1 = {
          name = "source_yuh"

          action = {
              action_1 = {
                name = "action_1_yuh" 
                run_order = 1 
                category = "Source"
                owner = "AWS"
                provider = "CodeCommit"
                version = "#Latest"
                input_artifacts = [""] 
                output_artifacts = ["CodeCommit_Artifact"]

                namespace = ""
                # https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference.html
                configuration = {
                    RepositoryName = "repo_yuh"
                    BranchName = "branch_yuh" 
                    PollForSourceChanges = true 
                    OutputArtifactFormat = "ZIP_CODE"
                }
            }
              action_2 = {
                name = "action_1_yuh" 
                run_order = 2
                category = "Source"
                owner = "AWS"
                provider = "ECR"
                version = "#Latest"
                input_artifacts = [""] 
                output_artifacts = ["ECR_Artifact"]

                namespace = ""
                # https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference.html
                configuration = {
                    RepositoryName = "repo_yuh"
                    BranchName = "branch_yuh" 
                    PollForSourceChanges = true 
                    OutputArtifactFormat = "ZIP_CODE"
                }
            }
            
        }
    }
        stage_2 = {
            name = "deploy_yuh"

            action = {
                codedeploy = {
                    name = "action_2_yuh" 
                    run_order = 1 
                    category = "Build"
                    owner = "AWS"
                    provider = "CodeBuild"
                    version = "#Latest"
                    input_artifacts = ["CodeCommit_Artifact", "ECR_Artifact"]
                    output_artifacts = ["CodeBuild_Artifact"]

                    namespace = ""
                    # https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference.html
                    configuration = {
                        ProjectName = "Project_yuh"
                        PrimarySource = "ECR_Artifact"
                        BatchEnabled = false
                        CombineArtifacts = true
                    }
                }
            }
        }

      stage_3 = {
        name = "deploy_yuh"

          action = {
            codedeploy = {
                name = "action_2_yuh" 
                run_order = 2 
                category = "Deploy"
                owner = "AWS"
                provider = "ECS"
                version = "#Latest"
                input_artifacts = ["CodeBuild_Artifact"]
                output_artifacts = ["Deploy_Artifacts"]

                namespace = ""
                # https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference.html
                configuration = {
                    ClusterName = "Cluster_yuh"
                    ServiceName = "Service_yuh"
                    FileName = "File_yuh"
                    DeploymentTimeout = 10
                }
            }
        }
    }
}    
    







}
    
