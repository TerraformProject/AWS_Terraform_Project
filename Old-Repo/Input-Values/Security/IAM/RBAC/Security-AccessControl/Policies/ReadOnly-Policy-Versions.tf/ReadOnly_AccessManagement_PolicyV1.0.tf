{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "*"
            ],
            "Resource": "*",
            "condition" : {
            "StringNotEquals": {
                "iam:PermissionBoundary": [
                    "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
                ]
            }
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