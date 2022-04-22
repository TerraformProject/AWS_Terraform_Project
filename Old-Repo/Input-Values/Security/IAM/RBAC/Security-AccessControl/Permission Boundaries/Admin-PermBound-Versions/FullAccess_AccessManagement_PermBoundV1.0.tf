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
                "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
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
                "arn:aws:iam::092968731555:user/*",
                "arn:aws:iam::092968731555:role/*"
            ],
            "Condition": {
                "StringEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
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
                "arn:aws:iam::092968731555:user/*",
                "arn:aws:iam::092968731555:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
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
                "arn:aws:iam::092968731555:user/*",
                "arn:aws:iam::092968731555:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
                }
            }
        },
        {
          "Sid": "CroupUserMngmntIfPermBoundIsSet",
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
            "*"
          ],
          "Condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
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
            "*"
          ],
          "Condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
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
          "Resource": "arn:aws:iam::092968731555:user/@{aws:username}",
          "Condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
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
          "Condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
              ]
            }
          }
        },
        {
            "Sid": "DenyAllExceptListedIfNoMFA",
            "Effect": "Deny",
            "Action": [
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
          "iam:PutRolePermissionsBoundary",
          "iam:PutRolePolicy",
          "iam:PutUserPermissionsBoundary",
          "iam:UpdateAssumeRolePolicy",
          "iam:TagPolicy",
          "iam:UntagPolicy"
        ],
        "Resource": [
            "arn:aws:iam::092968731555:role/*",
            "arn:aws:iam::092968731555:policy/*"
        ],
        "Condition" : {
          "StringEquals": {
            "iam:PermissionBoundary": [
              "arn:aws:iam::092968731555:policy${permission_boundary_path}${permission_boundary_name}"
              ]
            }
          }
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:*",
                "access-analyzer:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "organizations:DescribeAccount",
                "organizations:DescribeOrganization",
                "organizations:DescribeOrganizationalUnit",
                "organizations:DescribePolicy",
                "organizations:ListChildren",
                "organizations:ListParents",
                "organizations:ListPoliciesForTarget",
                "organizations:ListRoots",
                "organizations:ListPolicies",
                "organizations:ListTargetsForPolicy"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "sso:*",
                "sso-directory:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cognito-identity:*",
                "cognito-idp:*",
                "cognito-sync:*"
            ],
            "Resource": "*"
        }
    ]
}