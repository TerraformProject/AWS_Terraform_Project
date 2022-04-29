{
  "Version": "2012-10-17",
  "Statement": [
      {
      "Sid": "DenyAccessIfRequiredPermBoundaryIsNotSet",
      "Effect": "Deny",
      "Action": [
        "iam:PutUserPermissionBoundary",
        "iam:PutRolePermissionBoundary"
      ],
      "Resource": [
        "arn:aws:iam::092968731555:user/*",
        "arn:aws:iam::092968731555:role/*"
      ],
      "condition": {
        "StringNotEquals": {
            "iam:PermissionBoundary": [
              "arn:aws:iam::092968731555:policy/Admin/PermissionBoundaries/CICD-Admin-PermBoundary1.tf"
          ]
        }
      }
    },
    {
      "Sid": "DenyCreateUserOrRoleWithoutPermissionBoundary",
      "Effect": "Deny",
      "Action": [
        "iam:CreateGroup",
        "iam:CreateUser",
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::092968731555:group/*",
        "arn:aws:iam::092968731555:user/*",
        "arn:aws:iam::092968731555:role/*"
      ],
      "condition": {
        "StringNotEquals": {
          "iam:PermissionBoundary": [
            "arn:aws:iam::092968731555:policy/Admin/PermissionBoundaries/CICD-Admin-PermBoundary1.tf"
          ]
        }
      }
    },
    {
        "Sid": "DenyRemovalPermBoundaryFromIAMUserRole",
        "Effect": "Deny",
        "Action":  [
          "iam:DeletetUserPermissionBoundary",
          "iam:DeleteRolePermissionBoundary"
        ],
        "Resource": [
          "arn:aws:iam::092968731555:user/*",
          "arn:aws:iam::092968731555:role/*"
        ],
        "condition": {
          "StringEquals": {
            "iam:PermissionBoundary": [
              "arn:aws:iam::092968731555:policy/Admin/PermissionBoundaries/CICD-Admin-PermBoundary1.tf"
              ]
           }
        }
     },
     {
        "Sid": "DenyPermBoundaryPolicyAlteration",
        "Effect": "Deny",
        "Action": [
          "iam:CreatePolicyVersion",
          "iam:DeletePolicyVersion",
          "iam:DeletePolicy",
          "iam:SetDefaultPolicyVersion"
        ],
        "Resource": [
          "arn:aws:iam::092968731555:policy/Admin/PermissionBoundaries/CICD-Admin-PermBoundary1.tf"
        ]
      },
      {
        "Sid": "DenyAccessToAccountBilling",
        "Effect": "Deny",
        "Action": [
          "account:*",
          "aws-portal:*",
          "savingsplans:*",
          "cur:*",
          "ce:*"
        ],
        "Resource": [
          "*"
        ] 
      },
      {
        "Effect": "Allow",
        "Action": [
            "ecr:*"
        ],
        "Resource": [
            "*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
            "events:DescribeRule",
            "events:ListRuleNamesByTarget",
            "events:ListRules",
            "events:ListTargetsByRule",
            "events:TestEventPattern",
            "events:DescribeEventBus",
            "events:DeleteRule",
            "events:PutRule",
            "events:PutTargets",
            "events:RemoveTargets"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "codepipeline:*"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "codecommit:*"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "codebuild:*"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "codedeploy:*"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "ecs:*"
        ],
        "Resource": "*"
      },
      {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:*:parameter/aws/service/ecs*"
      },
      {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": [
                        "codepipeline.amazonaws.com",
                        "codebuild.amazonaws.com",
                        "codedeploy.amazonaws.com",
                        "ecs.application-autoscaling.amazonaws.com",
                        "autoscaling.amazonaws.com",
                        "cloudwatch.amazonaws.com"
                    ]
                }
            }
      },
      {
            "Action": "iam:PassRole",
            "Effect": "Allow",
            "Resource": [
                "arn:aws:iam::*:role/ecsInstanceRole*"
            ],
            "Condition": {
                "StringLike": {
                    "iam:PassedToService": [
                        "ec2.amazonaws.com",
                        "ec2.amazonaws.com.cn"
                    ]
                }
            }
        },
      {
        "Effect": "Allow",
        "Action": [
            "servicediscovery:CreatePrivateDnsNamespace",
            "servicediscovery:CreateService",
            "servicediscovery:GetNamespace",
            "servicediscovery:GetOperation",
            "servicediscovery:GetService",
            "servicediscovery:ListNamespaces",
            "servicediscovery:ListServices",
            "servicediscovery:UpdateService",
            "servicediscovery:DeleteService"
        ],
        "Resource": [
            "*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
            "elasticloadbalancing:CreateListener",
            "elasticloadbalancing:CreateLoadBalancer",
            "elasticloadbalancing:CreateRule",
            "elasticloadbalancing:CreateTargetGroup",
            "elasticloadbalancing:DeleteListener",
            "elasticloadbalancing:DeleteLoadBalancer",
            "elasticloadbalancing:DeleteRule",
            "elasticloadbalancing:DeleteTargetGroup",
            "elasticloadbalancing:DescribeListeners",
            "elasticloadbalancing:DescribeLoadBalancers",
            "elasticloadbalancing:DescribeRules",
            "elasticloadbalancing:DescribeTargetGroups"
        ],
        "Resource": [
            "*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
            "ec2:AssociateRouteTable",
            "ec2:AttachInternetGateway",
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:CancelSpotFleetRequests",
            "ec2:CreateInternetGateway",
            "ec2:CreateLaunchTemplate",
            "ec2:CreateRoute",
            "ec2:CreateRouteTable",
            "ec2:CreateSecurityGroup",
            "ec2:CreateSubnet",
            "ec2:CreateVpc",
            "ec2:DeleteLaunchTemplate",
            "ec2:DeleteSubnet",
            "ec2:DeleteVpc",
            "ec2:Describe*",
            "ec2:DetachInternetGateway",
            "ec2:DisassociateRouteTable",
            "ec2:ModifySubnetAttribute",
            "ec2:ModifyVpcAttribute",
            "ec2:RunInstances",
            "ec2:RequestSpotFleet"
        ],
        "Resource": [
            "*"
        ]
      },
      {
            "Effect": "Allow",
            "Action": [
                "route53:GetHostedZone",
                "route53:ListHostedZonesByName",
                "route53:GetHealthCheck"
            ],
            "Resource": [
                "*"
            ]
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
            "arn:aws:iam::092968731555:group/CICD/*",
            "arn:aws:iam::092968731555:user/CICD/*"
          ]
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
            "arn:aws:iam::092968731555:group/CICD/*",
            "arn:aws:iam::092968731555:role/CICD/*"
        ]
      }
  ]
}