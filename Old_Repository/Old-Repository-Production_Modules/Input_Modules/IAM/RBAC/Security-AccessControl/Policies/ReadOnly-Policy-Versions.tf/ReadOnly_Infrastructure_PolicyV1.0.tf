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
            "Action": [
                "lambda:ListFunctions",
                "rds:DescribeDBClusters",
                "rds:DescribeDBInstances",
                "tag:GetResources"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "lambda:GetFunction"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:lambda:*:*:function:SecretsManager*"
        },
        {
            "Action": [
                "s3:GetObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::awsserverlessrepo-changesets*",
                "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:Describe*",
                "kms:List*"
            ],
            "Resource": "*"
        },
       {
            "Effect": "Allow",
            "Action": [
                "acm:DescribeCertificate",
                "acm:ListCertificates",
                "acm:GetCertificate",
                "acm:ListTagsForCertificate",
                "acm:GetAccountConfiguration"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ram:Get*",
                "ram:List*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "waf:Get*",
                "waf:List*",
                "waf-regional:Get*",
                "waf-regional:List*",
                "wafv2:Get*",
                "wafv2:List*",
                "wafv2:Describe*",
                "wafv2:CheckCapacity"
            ],
            "Resource": "*"
        }
    ]
}