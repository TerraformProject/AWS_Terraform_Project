locals {
  codecommit = flatten([ for stages, settings in var.codepipeline_stages: 
                          [ for configuration, values in settings.action: values ]  
                    ])
}


resource "aws_codepipeline" "codepipeline" {
count = var.create_codepipeline == true ? 1 : 0
  name     = var.codepipeline_name
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.artifact_store_location
    type     = var.artifact_store_type
    region = var.enable_cross_region_artifact_storage == true ? var.region : null  

    encryption_key {
      id   = var.encryption_key_id
      type = var.encryption_key_type
    }
  }


  dynamic "stage" {
    for_each = var.codepipeline_stages
    content {
    name = stage.value.name
  
        dynamic "action" {
        for_each = lookup(stage.value, "action", {} )
        content {
        name             = lookup(action.value, "name", "" )
        run_order        = lookup(action.value, "run_order", "" )
        category         = lookup(action.value, "category", "" )
        owner            = lookup(action.value, "owner", "" )
        provider         = lookup(action.value, "provider", "" )
        version          = lookup(action.value, "version", "" )
        input_artifacts  = lookup(action.value, "input_artifacts", null )
        output_artifacts = lookup(action.value, "output_artifacts", "" )

        namespace = lookup(action.value, "namespace", null ) 
        configuration = {
        # Multi-Use
          RepositoryName = lookup(action.value["configuration"], "RepositoryName", null )
          PollForSourceChanges = lookup(action.value["configuration"], "PollForSourceChanges", null )
          BranchName = lookup(action.value["configuration"], "BranchName", null )
          OutputArtifactFormat = lookup(action.value["configuration"], "OutputArtifactFormat", null )
          Capabilities = lookup(action.value["configuration"], "Capabilities", null )
          TemplatePath = lookup(action.value["configuration"], "TemplatePath", null )
        ## Source ##
            # CodeCommit
                # All Located in Multi-Use
            # S3
            S3Bucket = lookup(action.value["configuration"], "S3Bucket", null )
            S3ObjectKey = lookup(action.value["configuration"], "S3ObjectKey", null ) 
            # ECR
            ImageTag = lookup(action.value["configuration"], "ImageTag", null )
            # CodeStarSourceConnection
            ConnectionArn = lookup(action.value["configuration"], "ConnectionArn", null )
            FullRepositoryID = lookup(action.value["configuration"], "FullRepositoryID", null )
            DetectChanges = lookup(action.value["configuration"], "DetectChanges", null )
            # CloudFormationStackSet
            StackSetName = lookup(action.value["configuration"], "StackSetName", null )
            Description = lookup(action.value["configuration"], "Description", null )
            Parameters = lookup(action.value["configuration"], "Parameters", null )
            PermissionModel = lookup(action.value["configuration"], "PermissionModel", null )
            AdministrationRoleArn = lookup(action.value["configuration"], "AdministrationRoleArn", null )
            ExecutionRoleArn = lookup(action.value["configuration"], "ExecutionRoleArn", null )
            OrganizationAutoDeployment = lookup(action.value["configuration"], "OrganizationAutoDeployment", null )
            DeployemntTargets = lookup(action.value["configuration"], "DeployemntTargets", null )
            OrganizationalUnitIds = lookup(action.value["configuration"], "OrganizationalUnitIds", null )
            Regions = lookup(action.value["configuration"], "Regions", null )
            FailureTolerancePercentage = lookup(action.value["configuration"], "FailureTolerancePercentage", null )
            MaxConcurrentPercentage = lookup(action.value["configuration"], "MaxConcurrentPercentage", null )
        ## Build/Test ##
            # CodeBuild
            ProjectName = lookup(action.value["configuration"], "ProjectName", null )
            PrimarySource = lookup(action.value["configuration"], "PrimarySource", null )
            BatchEnabled = lookup(action.value["configuration"], "BatchEnabled", null )
            CombineArtifacts = lookup(action.value["configuration"], "CombineArtifacts", null )
            EnvironmentVariables = lookup(action.value["configuration"], "EnvironmentVariables", null )
            # DeviceFarm
            AppType = lookup(action.value["configuration"], "AppType", null )
            ProjectID = lookup(action.value["configuration"], "ProjectID", null )
            App = lookup(action.value["configuration"], "App", null )
            AppiumVersion = lookup(action.value["configuration"], "AppiumVersion", null )
            DevicePoolArn = lookup(action.value["configuration"], "DevicePoolArn", null )
            TestType = lookup(action.value["configuration"], "TestType", null )
            RadioBluetoothEnabled = lookup(action.value["configuration"], "RadioBluetoothEnabled", null )
            RecordAppPerformanceData = lookup(action.value["configuration"], "RecordAppPerformanceData", null )
            RecordVideo = lookup(action.value["configuration"], "RecordVideo", null )
            RadioWifiEnabled = lookup(action.value["configuration"], "RadioWifiEnabled", null )
            RadioNfcEnabled = lookup(action.value["configuration"], "RadioNfcEnabled", null )
            RadioGpsEnabled = lookup(action.value["configuration"], "RadioGpsEnabled", null )
            Test = lookup(action.value["configuration"], "Test", null )
            FuzzEventCount = lookup(action.value["configuration"], "FuzzEventCount", null )
            FuzzEventThrottle = lookup(action.value["configuration"], "FuzzEventThrottle", null )
            CustomHostMachineArtifacts = lookup(action.value["configuration"], "CustomHostMachineArtifacts", null )
            CustomDeviceArtifacts = lookup(action.value["configuration"], "CustomDeviceArtifacts", null )
            UnmeteredDevicesOnly = lookup(action.value["configuration"], "UnmeteredDevicesOnly", null )
            JobTimeoutMinutes = lookup(action.value["configuration"], "JobTimeoutMinutes", null )
            Latitude = lookup(action.value["configuration"], "Latitude", null )
            Longitude = lookup(action.value["configuration"], "Longitude", null )
      ## Deploy ##
            # CodeDeploy
            ApplicationName = lookup(action.value["configuration"], "ApplicationName", null )
            DeploymentGroupName = lookup(action.value["configuration"], "DeploymentGroupName", null )
            # ECS
            ClusterName = lookup(action.value["configuration"], "ClusterName", null )
            ServiceName = lookup(action.value["configuration"], "ServiceName", null )
            FileName = lookup(action.value["configuration"], "FileName", null )
            DeploymentTimeOut = lookup(action.value["configuration"], "DeploymentTimeOut", null )
            # CodeDeployToECS
            ApplicationName = lookup(action.value["configuration"], "ApplicationName", null )
            DeploymentGroupName = lookup(action.value["configuration"], "DeploymentGroupName", null )
            TaskDefinitionTemplateArtifact = lookup(action.value["configuration"], "TaskDefinitionTemplateArtifact", null )
            AppSpecTemplateArtifact = lookup(action.value["configuration"], "AppSpecTemplateArtifact", null )
            TaskDefinitionTemplatePath = lookup(action.value["configuration"], "TaskDefinitionTemplatePath", null )
            Image1ArtifactName = lookup(action.value["configuration"], "Image1ArtifactName", null )
            Image2ArtifactName = lookup(action.value["configuration"], "Image2ArtifactName", null )
            Image3ArtifactName = lookup(action.value["configuration"], "Image3ArtifactName", null )
            Image4ArtifactName = lookup(action.value["configuration"], "Image4ArtifactName", null )
            Image1ContainerName = lookup(action.value["configuration"], "Image1ContainerName", null )
            Image2ContainerName = lookup(action.value["configuration"], "Image2ContainerName", null )
            Image3ContainerName = lookup(action.value["configuration"], "Image3ContainerName", null )
            Image4ContainerName = lookup(action.value["configuration"], "Image4ContainerName", null )
            # CloudFromation
            ActionMode = lookup(action.value["configuration"], "ActionMode", null )
            StackName = lookup(action.value["configuration"], "StackName", null )
            ChangeSetName = lookup(action.value["configuration"], "ChangeSetName", null )
            RoleArn = lookup(action.value["configuration"], "RoleArn", null )
            TemplateConfiguration = lookup(action.value["configuration"], "TemplateConfiguration", null )
            TemplatePath = lookup(action.value["configuration"], "TemplatePath", null )
            OutputFileName = lookup(action.value["configuration"], "OutputFileName", null )
            ParameterOverrides = lookup(action.value["configuration"], "ParameterOverrides", null )
            # AppConfig
            Application = lookup(action.value["configuration"], "Application", null )
            Environment = lookup(action.value["configuration"], "Environment", null )
            ConfigurationProfile = lookup(action.value["configuration"], "ConfigurationProfile", null )
            InputArtifactConfigurationPath = lookup(action.value["configuration"], "InputArtifactConfigurationPath", null )
            DeploymentStrategy = lookup(action.value["configuration"], "DeploymentStrategy", null )
      ## Invoke ##
            # Lambda 
            FunctionName = lookup(action.value["configuration"], "FunctionName", null )
            UserParamters = lookup(action.value["configuration"], "UserParamters", null )
            # StepFunctions
            StateMachineArn = lookup(action.value["configuration"], "StateMachineArn", null )
            ExecutionNamePrefix = lookup(action.value["configuration"], "ExecutionNamePrefix", null )
            InputType = lookup(action.value["configuration"], "InputType", null )
            Input = lookup(action.value["configuration"], "Input", null )
          }
        }
      }
    }
  }
}
                      
   