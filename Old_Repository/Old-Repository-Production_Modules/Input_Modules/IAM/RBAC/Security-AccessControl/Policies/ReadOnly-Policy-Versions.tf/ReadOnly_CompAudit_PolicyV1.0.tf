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
            "Sid": "AuditManagerAccess",
            "Effect": "Allow",
            "Action": [
                "auditmanager:List*".
                "auditmanager:Get*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "iamConfigTrackPermission",
            "Effect": "Allow",
            "Action": [
                "iam:GetCredentialReport"
                
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
            "Effect": "Allow",
            "Action": [
                "securityhub:Get*",
                "securityhub:List*",
                "securityhub:Describe*"
                ],
            "Resource": "*"
        }
    ]
}