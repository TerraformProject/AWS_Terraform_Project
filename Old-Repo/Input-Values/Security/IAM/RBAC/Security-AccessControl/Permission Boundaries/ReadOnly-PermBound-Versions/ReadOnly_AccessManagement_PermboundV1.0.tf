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
            "iam:ChangePassword",
            "iam:UpdateLoginProfile",
            "iam:CreateAccountAlias",
            "iam:DeleteAccountAlias"
          ],
          "Resource": [
            "*"
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
                "*"
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
          "Resource": "*",
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
            "Effect": "Allow",
            "Action": [
                "iam:List*",
                "iam:Describe*",
                "iam:Get*",
                "access-analyzer:List",
                "access-analyzer:Describe*",
                "access-analyzer:Get*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ds:DescribeDirectories",
                "ds:DescribeTrusts",
                "sso:Describe*",
                "sso:Get*",
                "sso:List*",
                "sso:Search*",
                "sso-directory:DescribeDirectory"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cognito-identity:Describe*",
                "cognito-identity:Get*",
                "cognito-identity:List*",
                "cognito-idp:Describe*",
                "cognito-idp:AdminGet*",
                "cognito-idp:AdminList*",
                "cognito-idp:List*",
                "cognito-idp:Get*",
                "cognito-sync:Describe*",
                "cognito-sync:Get*",
                "cognito-sync:List*"
            ],
            "Resource": "*"
        }
    ]
}