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
                "cognito:*"
            ],
            "Resource": "*"
        }
    ]
}