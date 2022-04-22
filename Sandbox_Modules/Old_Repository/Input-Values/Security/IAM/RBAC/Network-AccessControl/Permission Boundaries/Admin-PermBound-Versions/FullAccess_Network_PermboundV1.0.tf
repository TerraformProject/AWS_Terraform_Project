{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeVpcAttribute",
                "ec2:DescribeVpcs",
                "ec2:AssociateVpcCidrBlock",
                "ec2:CreateDefaultVpc",
                "ec2:CreateVpc",
                "ec2:ModifyVpcAttribute",
                "ec2:ModifyVpcTenancy",
                "ec2:MoveAddressToVpc",
                "ec2:DisassociateVpcCidrBlock",
                "ec2:DeleteVpc"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVpcPeeringConnections",
                "ec2:CreateVpcPeeringConnection",
                "ec2:AcceptVpcPeeringConnection",
                "ec2:ModifyVpcPeeringConnectionOptions",
                "ec2:RejectVpcPeeringConnection",
                "ec2:DeleteVpcPeeringConnection"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVpcClassicLink",
                "ec2:DescribeVpcClassicLinkDnsSupport",
                "ec2:DescribeClassicLinkInstances",
                "ec2:AttachClassicLinkVpc",
                "ec2:EnableVpcClassicLink",
                "ec2:EnableVpcClassicLinkDnsSupport",
                "ec2:DetachClassicLinkVpc",
                "ec2:DisableVpcClassicLink",
                "ec2:DisableVpcClassicLinkDnsSupport"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVpcEndpointConnectionNotifications",
                "ec2:DescribeVpcEndpointConnections",
                "ec2:DescribeVpcEndpoints",
                "ec2:DescribeVpcEndpointServiceConfigurations",
                "ec2:DescribeVpcEndpointServicePermissions",
                "ec2:DescribeVpcEndpointServices",
                "ec2:CreateVpcEndpoint",
                "ec2:CreateVpcEndpointConnectionNotification",
                "ec2:CreateVpcEndpointServiceConfiguration",
                "ec2:ModifyVpcEndpoint",
                "ec2:ModifyVpcEndpointConnectionNotification",
                "ec2:ModifyVpcEndpointServiceConfiguration",
                "ec2:ModifyVpcEndpointServicePermissions",
                "ec2:RejectVpcEndpointConnections",
                "ec2:DeleteVpcEndpointConnectionNotifications",
                "ec2:DeleteVpcEndpoints",
                "ec2:DeleteVpcEndpointServiceConfigurations"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInternetGateways",
                "ec2:CreateInternetGateway",
                "ec2:DescribeEgressOnlyInternetGateways",
                "ec2:CreateEgressOnlyInternetGateway",
                "ec2:AttachInternetGateway",
                "ec2:DetachInternetGateway",
                "ec2:DeleteInternetGateway",
                "ec2:DeleteEgressOnlyInternetGateway"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:SearchTransitGatewayRoutes",
                "ec2:DescribeTransitGateways",
                "ec2:DescribeTransitGatewayAttachments",
                "ec2:DescribeTransitGatewayRouteTables",
                "ec2:DescribeTransitGatewayVpcAttachments",
                "ec2:GetTransitGatewayAttachmentPropagations",
                "ec2:GetTransitGatewayRouteTableAssociations",
                "ec2:GetTransitGatewayRouteTablePropagations",
                "ec2:CreateTransitGateway",
                "ec2:CreateTransitGatewayRoute",
                "ec2:CreateTransitGatewayRouteTable",
                "ec2:CreateTransitGatewayVpcAttachment",
                "ec2:ExportTransitGatewayRoutes",
                "ec2:EnableTransitGatewayRouteTablePropagation",
                "ec2:AcceptTransitGatewayVpcAttachment",
                "ec2:AssociateTransitGatewayRouteTable",
                "ec2:ModifyTransitGatewayVpcAttachment",
                "ec2:DisableTransitGatewayRouteTablePropagation",
                "ec2:DisassociateTransitGatewayRouteTable",
                "ec2:RejectTransitGatewayVpcAttachment",
                "ec2:ReplaceTransitGatewayRoute",
                "ec2:DeleteTransitGateway",
                "ec2:DeleteTransitGatewayRoute",
                "ec2:DeleteTransitGatewayRouteTable",
                "ec2:DeleteTransitGatewayVpcAttachment"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeCarrierGateways",
                "ec2:CreateCarrierGateway",
                "ec2:DeleteCarrierGateway"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeCustomerGateways",
                "ec2:CreateCustomerGateway",
                "ec2:DeleteCustomerGateway"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeNatGateways",
                "ec2:CreateNatGateway",
                "ec2:DeleteNatGateway"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVpnGateways",
                "ec2:DescribeVpnConnections",
                "ec2:CreateVpnGateway",
                "ec2:CreateVpnConnection",
                "ec2:CreateVpnConnectionRoute",
                "ec2:AttachVpnGateway",
                "ec2:DetachVpnGateway",
                "ec2:DeleteVpnConnection",
                "ec2:DeleteVpnConnectionRoute",
                "ec2:DeleteVpnGateway"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [      
                "directconnect:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [      
                "cloudfront:ListDistributions"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeRouteTables",
                "ec2:CreateRouteTable",
                "ec2:CreateRoute",
                "ec2:EnableVgwRoutePropagation",
                "ec2:AssociateRouteTable",
                "ec2:ReplaceRoute",
                "ec2:ReplaceRouteTableAssociation",
                "ec2:DisassociateRouteTable",
                "ec2:DisableVgwRoutePropagation",
                "ec2:DeleteRoute",
                "ec2:DeleteRouteTable"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeSubnets",
                "ec2:CreateDefaultSubnet",
                "ec2:CreateSubnet",
                "ec2:AssociateSubnetCidrBlock",
                "ec2:ModifySubnetAttribute",
                "ec2:DisassociateSubnetCidrBlock",
                "ec2:DeleteSubnet"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeNetworkAcls",
                "ec2:GetConsoleScreenshot",
                "ec2:CreateNetworkAcl",
                "ec2:CreateNetworkAclEntry",
                "ec2:ReplaceNetworkAclEntry",
                "ec2:ReplaceNetworkAclAssociation",
                "ec2:DeleteNetworkAcl",
                "ec2:DeleteNetworkAclEntry"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeKeyPairs",
                "ec2:DescribePlacementGroups",
                "ec2:CreatePlacementGroup",
                "ec2:DeletePlacementGroup"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeNetworkInterfaceAttribute",
                "ec2:DescribeNetworkInterfacePermissions",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeMovingAddresses",
                "ec2:DescribePrefixLists",
                "ec2:CreateNetworkInterface",
                "ec2:CreateNetworkInterfacePermission",
                "ec2:AllocateAddress",
                "ec2:AssociateAddress",
                "ec2:AssignIpv6Addresses",
                "ec2:AssignPrivateIpAddresses",
                "ec2:ModifyNetworkInterfaceAttribute",
                "ec2:AttachNetworkInterface",
                "ec2:DetachNetworkInterface",
                "ec2:ResetNetworkInterfaceAttribute",
                "ec2:ReleaseAddress",
                "ec2:RestoreAddressToClassic",
                "ec2:UnassignIpv6Addresses",
                "ec2:UnassignPrivateIpAddresses",
                "ec2:DisassociateAddress",
                "ec2:DeleteNetworkInterface",
                "ec2:DeleteNetworkInterfacePermission"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeSecurityGroupReferences",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeStaleSecurityGroups",
                "ec2:CreateSecurityGroup",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
                "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:RevokeSecurityGroupIngress"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:*",
                "route53domains:*",
                "ec2:CreateDhcpOptions", 
                "ec2:DescribeDhcpOptions",
                "ec2:AssociateDhcpOptions", 
                "ec2:CreateTags",
                "ec2:DeleteDhcpOptions"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeFlowLogs",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:DeleteAlarms",
                "cloudwatch:GetMetricStatistics",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:GetLogEvents",
                "sns:ListTopics",
                "sns:ListSubscriptionsByTopic",
                "sns:CreateTopic",
                "ec2:CreateFlowLogs",
                "ec2:DeleteFlowLogs"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:GetBucketWebsite"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:Describe*",
                "elasticloadbalancing:List*",
                "elasticloadbalancing:Describe*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecs:DescribeServices",
                "application-autoscaling:DescribeScalableTargets",
                "application-autoscaling:DescribeScalingActivities",
                "application-autoscaling:DescribeScalingPolicies"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:GetBucketWebsite"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:ListRoles",
                "iam:PassRole"
            ],
            "Resource": "arn:aws:iam::*:role/flow-logs-*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "networkmanager:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole",
                "iam:TagRole",
                "iam:UntagRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": [
                        "transitgateway.amazonaws.com",
                        "cloudwatch.amazonaws.com",
                        "logs.amazonaws.com",
                        "events.amazonaws.com"
                    ]
                }
            }
        },
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
          "Sid": "AllowListReadForIAM",
          "Effect": "Allow",
          "Action": [
            "iam:List*",
            "iam:Get*"
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
          "Sid": "AllowManageOwnVirtualMFADevice",
          "Effect": "Allow",
          "Action": [
              "iam:CreateVirtualMFADevice",
              "iam:DeleteVirtualMFADevice"
          ],
          "Resource": "${module.Create_Group_Add_Users_Module.group_arn}",
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
          "Resource": "${module.Create_Group_Add_Users_Module.group_arn}",
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
            "arn:aws:iam::092968731555:role/IAM-Roles/Worker-Roles/*",
            "arn:aws:iam::092968731555:policy/IAM-Policies/Worker-Policies/*"
        ],
        "condition" : {
          "StringEquals": {
            "iam:PermissionBoundary": [
              "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        }
    ]
}