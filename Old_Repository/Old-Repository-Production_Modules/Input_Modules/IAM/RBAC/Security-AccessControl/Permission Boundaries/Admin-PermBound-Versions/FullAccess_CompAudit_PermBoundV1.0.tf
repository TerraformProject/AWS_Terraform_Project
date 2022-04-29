{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyAccessToCostAndBilling",
            "Effect": "Deny",
            "Action": [
                "account:*",
                "aws-portal:*",
                "savingsplans:*",
                "cur:*",
                "ce:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DenyPermBoundaryIAMPolicyAlteration",
            "Effect": "Deny",
            "Action": [
                "iam:DeletePolicy",
                "iam:DeletePolicyVersion",
                "iam:CreatePolicyVersion",
                "iam:SetDefaultPolicyVersion"
            ],
            "Resource": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
            ]
        },
        {
            "Sid": "DenyRemovalOfPermBoundaryFromAnyUserOrRole",
            "Effect": "Deny",
            "Action": [
                "iam:DeleteUserPermissionsBoundary",
                "iam:DeleteRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::YourAccount_ID:user/*",
                "arn:aws:iam::YourAccount_ID:role/*"
            ],
            "Condition": {
                "StringEquals": {
                    "iam:PermissionsBoundary": "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
                }
            }
        },
        {
            "Sid": "DenyAccessIfRequiredPermBoundaryIsNotBeingApplied",
            "Effect": "Deny",
            "Action": [
                "iam:PutUserPermissionsBoundary",
                "iam:PutRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::YourAccount_ID:user/*",
                "arn:aws:iam::YourAccount_ID:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
                }
            }
        },
        {
            "Sid": "DenyUserAndRoleCreationWithOutPermBoundary",
            "Effect": "Deny",
            "Action": [
                "iam:CreateUser",
                "iam:CreateRole"
            ],
            "Resource": [
                "arn:aws:iam::YourAccount_ID:user/*",
                "arn:aws:iam::YourAccount_ID:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
                }
            }
        },
        {
          "Sid": "AllowUserGroupManagementOnlyInTheSpecifiedLocation",
          "Effect": "Allow",
          "Action": [
            "iam:CreateGroup",
            "iam:UpdateGroup",
            "iam:DeleteGroup",
            "iam:AddUserToGroup",
            "iam:RemoveUserFromGroup",
            "iam:ChangePassword",
            "iam:CreateUser",
            "iam:UpdateUser",
            "iam:DeleteUser",
            "iam:CreateLoginProfile",
            "iam:UpdateLoginProfile",
            "iam:DeleteLoginProfile",
            "iam:CreateAccountAlias",
            "iam:DeleteAccountAlias",
            "iam:CreateAccessKey",
            "iam:UpdateAccessKey",
            "iam:DeleteAccessKey",
            "iam:CreateVirtualMFADevice",
            "iam:ResyncMFADevice",
            "iam:DeactivateMFADevice",
            "iam:DeleteVirtualMFADevice"
          ],
          "Resource": [
            "${module.Create_Group_Add_Users_Module.group_arn}"
          ],
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
          "Sid": "AllowUserGroupManagementOnlyInTheSpecifiedLocation",
          "Effect": "Allow",
          "Action": [
            "iam:ChangePassword",
            "iam:UpdateLoginProfile",
            "iam:CreateAccountAlias",
            "iam:DeleteAccountAlias"
          ],
          "Resource": [
            "@{aws:username}"
          ],
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
          "Sid": "AllowManageOwnVirtualMFADevice",
          "Effect": "Allow",
          "Action": [
              "iam:CreateVirtualMFADevice",
              "iam:DeleteVirtualMFADevice"
          ],
          "Resource": "@{aws:username}",
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
          "Sid": "AllowManageOwnUserMFA",
          "Effect": "Allow",
          "Action": [
              "iam:DeactivateMFADevice",
              "iam:EnableMFADevice",
              "iam:ResyncMFADevice"
          ],
          "Resource": "@{aws:username}",
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
            "Sid": "DenyAllExceptListedIfNoMFA",
            "Effect": "Deny",
            "NotAction": [
                "iam:CreateVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:GetUser",
                "iam:ListMFADevices",
                "iam:ListVirtualMFADevices",
                "iam:ResyncMFADevice",
                "sts:GetSessionToken"
            ],
            "Resource": "*",
            "Condition": {
                "BoolIfExists": {"aws:MultiFactorAuthPresent": "false"}
            }
        },
        {
        "Sid": "AllowPolicyManagementOnlyInSpecifiedLocation",
        "Effect": "Allow",
        "Action": [
          "iam:AttachGroupPolicy",
          "iam:AttachRolePolicy",
          "iam:AttachUserPolicy",
          "iam:CreatePolicy",
          "iam:CreatePolicyVersion",
          "iam:DeletePolicy",
          "iam:DeletePolicyVersion",
          "iam:DeleteRolePolicy",
          "iam:DeleteUserPolicy",
          "iam:DetachRolePolicy",
          "iam:DetachUserPolicy",
          "iam:PutGroupPolicy",
          "iam:PutRolePermissionBoundary",
          "iam:PutRolePolicy",
          "iam:PutUserPermissionBoundary",
          "iam:UpdateAssumeRolePolicy",
          "iam:TagPolicy",
          "iam:UntagPolicy"
        ],
        "Resource": [
            "${module.Create_Group_Add_Users_Module.group_arn}"
        ],
        "condition" : {
          "StringEquals": {
            "iam:PermissionBoundary": [
              "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
            "Sid": "AuditManagerAccess",
            "Effect": "Allow",
            "Action": [
                "auditmanager:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ConfigFullAccess",
            "Effect": "Allow",
            "Action": [
                "config:BatchGet*",
                "config:Describe*",
                "config:Get*",
                "config:List*",
                "config:Put*",
                "config:Select*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "OrganizationsAccess",
            "Effect": "Allow",
            "Action": [
                "organizations:ListAccountsForParent",
                "organizations:ListAccounts",
                "organizations:DescribeOrganization",
                "organizations:DescribeOrganizationalUnit",
                "organizations:DescribeAccount",
                "organizations:ListParents",
                "organizations:ListChildren"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowOnlyAuditManagerIntegration",
            "Effect": "Allow",
            "Action": [
                "organizations:RegisterDelegatedAdministrator",
                "organizations:DeregisterDelegatedAdministrator",
                "organizations:EnableAWSServiceAccess"
            ],
            "Resource": "*",
            "Condition": {
                "StringLikeIfExists": {
                    "organizations:ServicePrincipal": [
                        "auditmanager.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Sid": "IAMAccess",
            "Effect": "Allow",
            "Action": [
                "iam:GetUser",
                "iam:ListUsers",
                "iam:ListRoles"
            ],
            "Resource": "*"
        },
        {
            "Sid": "IAMAccessCreateSLR",
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "arn:aws:iam::*:role/aws-service-role/auditmanager.amazonaws.com/AWSServiceRoleForAuditManager*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": "auditmanager.amazonaws.com"
                }
            }
        },
        {
            "Sid": "IAMAccessManageSLR",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteServiceLinkedRole",
                "iam:UpdateRoleDescription",
                "iam:GetServiceLinkedRoleDeletionStatus"
            ],
            "Resource": "arn:aws:iam::*:role/aws-service-role/auditmanager.amazonaws.com/AWSServiceRoleForAuditManager*"
        },
        {
            "Sid": "S3Access",
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        },
        {
            "Sid": "KmsAccess",
            "Effect": "Allow",
            "Action": [
                "kms:DescribeKey",
                "kms:ListKeys",
                "kms:ListAliases",
                "kms:GetKeyPolicy",
                "kms:GetKeyRotationStatus",              
                "kms:ListResourceTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "KmsCreateGrantAccess",
            "Effect": "Allow",
            "Action": [
                "kms:CreateGrant"
            ],
            "Resource": "*",
            "Condition": {
                "Bool": {
                    "kms:GrantIsForAWSResource": "true"
                },
                "StringLike": {
                    "kms:ViaService": "auditmanager.*.amazonaws.com"
                }
            }
        },
        {
            "Sid": "SNSAccess",
            "Effect": "Allow",
            "Action": [
                "sns:ListTopics"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CreateEventsAccess",
            "Effect": "Allow",
            "Action": [
                "events:PutRule"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "events:source": "aws.securityhub",
                    "events:detail-type": "Security Hub Findings - Imported"
                }
            }
        },
        {
            "Sid": "EventsAccess",
            "Effect": "Allow",
            "Action": [
                "events:DeleteRule",
                "events:DescribeRule",
                "events:EnableRule",
                "events:DisableRule",
                "events:ListTargetsByRule",
                "events:PutTargets",
                "events:RemoveTargets"
            ],
            "Resource": "arn:aws:events:*:*:rule/AuditManagerSecurityHubFindingsReceiver"
        },
        {
            "Sid": "TagAccess",
            "Effect": "Allow",
            "Action": [
                "tag:GetResources"
            ],
            "Resource": "*"
        },
        {
            "Sid": "acmConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "acm:DescribeCertificate",
                "acm:ListCertificates",
                "acm:ListTagsForCertificate"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AutoScalingConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "application-autoscaling:DescribeScalableTargets",
                "application-autoscaling:DescribeScalingPolicies",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeLifecycleHooks",
                "autoscaling:DescribePolicies",
                "autoscaling:DescribeScheduledActions",
                "autoscaling:DescribeTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "BackupConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "backup:ListBackupPlans",
                "backup:GetBackupPlan",
                "backup:ListBackupVaults",
                "backup:DescribeBackupVault",
                "backup:GetBackupVaultNotifications",
                "backup:GetBackupVaultAccessPolicy",
                "backup:ListBackupSelections",
                "backup:GetBackupSelection",
                "backup:ListRecoveryPointsByBackupVault",
                "backup:DescribeRecoveryPoint",
                "backup:ListTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CloudfrontConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "cloudfront:ListTagsForResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CloudformationConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                
                "cloudformation:DescribeType",
                "cloudformation:ListTypes"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CloudfrontConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "cloudtrail:DescribeTrails",
                "cloudtrail:GetEventSelectors",
                "cloudtrail:GetTrailStatus",
                "cloudtrail:ListTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "cloudwatchConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DescribeAlarms"
            ],
            "Resource": "*"
        },
        {
            "Sid": "codepipelineConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "codepipeline:GetPipeline",
                "codepipeline:GetPipelineState",
                "codepipeline:ListPipelines"
            ],
            "Resource": "*"
        },
        {
            "Sid": "daxConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "dax:DescribeClusters"
            ],
            "Resource": "*"
        },
        {
            "Sid": "dmsConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "dms:DescribeReplicationInstances",
                "dms:DescribeReplicationSubnetGroups",
                "dms:ListTagsForResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "dynamoDBConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeTable",
                "dynamodb:ListTables",
                "dynamodb:ListTagsOfResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ec2ConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
                "ec2:GetEbsEncryptionByDefault"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ecrConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "ecr:DescribeRepositories",
                "ecr:GetLifecyclePolicy",
                "ecr:GetRepositoryPolicy",
                "ecr:ListTagsForResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ecrConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "ecs:DescribeClusters",
                "ecs:DescribeServices",
                "ecs:DescribeTaskDefinition",
                "ecs:DescribeTaskSets",
                "ecs:ListClusters",
                "ecs:ListServices",
                "ecs:ListTagsForResource",
                "ecs:ListTaskDefinitions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "eksConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:DescribeNodegroup",
                "eks:ListClusters",
                "eks:ListNodegroups"
            ],
            "Resource": "*"
        },
        {
            "Sid": "elasticacheConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "elasticache:DescribeCacheClusters",
                "elasticache:DescribeCacheParameterGroups",
                "elasticache:DescribeCacheSubnetGroups",
                "elasticache:DescribeReplicationGroups"
            ],
            "Resource": "*"
        },
        {
            "Sid": "elasticacheConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:DescribeAccessPoints",
                "elasticfilesystem:DescribeBackupPolicy",
                "elasticfilesystem:DescribeFileSystems",
                "elasticfilesystem:DescribeFileSystemPolicy",
                "elasticfilesystem:DescribeLifecycleConfiguration",
                "elasticfilesystem:DescribeMountTargets",
                "elasticfilesystem:DescribeMountTargetSecurityGroups"
            ],
            "Resource": "*"
        },
        {
            "Sid": "elasticloadbalancingConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeLoadBalancerPolicies",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:DescribeTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "elasticloadbalancingConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "elasticmapreduce:DescribeCluster",
                "elasticmapreduce:DescribeSecurityConfiguration",
                "elasticmapreduce:GetBlockPublicAccessConfiguration",
                "elasticmapreduce:ListClusters",
                "elasticmapreduce:ListInstances"
            ],
            "Resource": "*"
        },
        {
            "Sid": "elasticloadbalancingConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "es:DescribeElasticsearchDomain",
                "es:DescribeElasticsearchDomains",
                "es:ListDomainNames",
                "es:ListTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "gaurddutyConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "guardduty:GetDetector",
                "guardduty:GetFindings",
                "guardduty:GetMasterAccount",
                "guardduty:ListDetectors",
                "guardduty:ListFindings"
            ],
            "Resource": "*"
        },
        {
            "Sid": "iamConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "iam:GenerateCredentialReport",
                "iam:GetAccountAuthorizationDetails",
                "iam:GetAccountPasswordPolicy",
                "iam:GetAccountSummary",
                "iam:GetCredentialReport",
                "iam:GetGroup",
                "iam:GetGroupPolicy",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:GetUser",
                "iam:GetUserPolicy",
                "iam:ListAttachedGroupPolicies",
                "iam:ListAttachedRolePolicies",
                "iam:ListAttachedUserPolicies",
                "iam:ListEntitiesForPolicy",
                "iam:ListGroupPolicies",
                "iam:ListGroupsForUser",
                "iam:ListInstanceProfilesForRole",
                "iam:ListPolicyVersions",
                "iam:ListRolePolicies",
                "iam:ListUserPolicies",
                "iam:ListVirtualMFADevices"
            ],
            "Resource": "*"
        },
        {
            "Sid": "kinesisConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "kinesis:DescribeStreamSummary",
                "kinesis:ListStreams",
                "kinesis:ListTagsForStream"
            ],
            "Resource": "*"
        },
        {
            "Sid": "lambdaConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "lambda:GetAlias",
                "lambda:GetFunction",
                "lambda:GetPolicy",
                "lambda:ListAliases",
                "lambda:ListFunctions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "logsConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "logs:DescribeLogGroups"
            ],
            "Resource": "*"
        },
        {
            "Sid": "rdsConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "rds:DescribeDBClusters",
                "rds:DescribeDBClusterSnapshotAttributes",
                "rds:DescribeDBClusterSnapshots",
                "rds:DescribeDBInstances",
                "rds:DescribeDBSecurityGroups",
                "rds:DescribeDBSnapshotAttributes",
                "rds:DescribeDBSnapshots",
                "rds:DescribeDBSubnetGroups",
                "rds:DescribeEventSubscriptions",
                "rds:ListTagsForResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "redshiftConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "redshift:DescribeClusterParameterGroups",
                "redshift:DescribeClusterParameters",
                "redshift:DescribeClusterSecurityGroups",
                "redshift:DescribeClusterSnapshots",
                "redshift:DescribeClusterSubnetGroups",
                "redshift:DescribeClusters",
                "redshift:DescribeEventSubscriptions",
                "redshift:DescribeLoggingStatus"
            ],
            "Resource": "*"
        },
        {
            "Sid": "route53ConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "route53:GetHostedZone",
                "route53:ListHostedZones",
                "route53:ListHostedZonesByName",
                "route53:ListResourceRecordSets",
                "route53:ListTagsForResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "S3ConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "s3:GetAccelerateConfiguration",
                "s3:GetAccessPoint",
                "s3:GetAccountPublicAccessBlock",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketLocation",
                "s3:GetBucketLogging",
                "s3:GetBucketNotification",
                "s3:GetBucketObjectLockConfiguration",
                "s3:GetBucketPolicy",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketWebsite",
                "s3:GetEncryptionConfiguration",
                "s3:GetLifecycleConfiguration",
                "s3:GetReplicationConfiguration",
                "s3:ListAccessPoints",
                "s3:ListAllMyBuckets",
                "s3:ListBucket"
            ],
            "Resource": "*"
        },
        {
            "Sid": "sagemakerConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "sagemaker:DescribeCodeRepository",
                "sagemaker:DescribeEndpointConfig",
                "sagemaker:DescribeNotebookInstance",
                "sagemaker:ListCodeRepositories",
                "sagemaker:ListEndpointConfigs",
                "sagemaker:ListNotebookInstances",
                "sagemaker:ListTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "secretsmanagerConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:ListSecrets",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "*"
        },
        {
            "Sid": "securitythubConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "securityhub:describeHub"
            ],
            "Resource": "*"
        },
        {
            "Sid": "shieldConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "shield:DescribeDRTAccess",
                "shield:DescribeProtection",
                "shield:DescribeSubscription"
            ],
            "Resource": "*"
        },
        {
            "Sid": "snsConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "sns:GetTopicAttributes",
                "sns:ListSubscriptions",
                "sns:ListTagsForResource",
                "sns:ListTopics"
            ],
            "Resource": "*"
        },
        {
            "Sid": "snsConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "sns:GetTopicAttributes",
                "sns:ListSubscriptions",
                "sns:ListTagsForResource",
                "sns:ListTopics"
            ],
            "Resource": "*"
        },
        {
            "Sid": "sqsConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "sqs:GetQueueAttributes",
                "sqs:ListQueues",
                "sqs:ListQueueTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ssmConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAutomationExecutions",
                "ssm:DescribeDocument",
                "ssm:GetAutomationExecution",
                "ssm:GetDocument",
                "ssm:ListDocuments"
            ],
            "Resource": "*"
        },
        {
            "Sid": "storagegatewayConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "storagegateway:ListGateways",
                "storagegateway:ListVolumes"
            ],
            "Resource": "*"
        },
        {
            "Sid": "storagegatewayConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
               "support:DescribeCases"
            ],
            "Resource": "*"
        },
        {
            "Sid": "storagegatewayConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "waf:GetLoggingConfiguration",
                "waf:GetWebACL",
                "wafv2:GetLoggingConfiguration",
                "waf-regional:GetLoggingConfiguration",
                "waf-regional:GetWebACL",
                "waf-regional:GetWebACLForResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ConfigTrackPermissions",
            "Effect": "Allow",
            "Action": [
                "tag:GetResources"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "securityhub:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": "securityhub.amazonaws.com"
                }
            }
        }
         ]
}