{
  "Version": "2012-10-17",
  "Statement": [
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
            "arn:aws:iam::092968731555:group/ECR-Groups/Delageted-Admin-Groups/*",
            "arn:aws:iam::092968731555:group/ECR-Groups/ECR-Worker-Groups/*",
            "arn:aws:iam::092968731555:group/ECR-Groups/ECR-Worker-Groups/*/*"
          ],
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "arn:aws:iam::092968731555:policy/IAM-PermBound//ECR-PermBounds/Admin-PermBounds/ECR-Admin-Permission-Boundary1"
              ]
            }
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
            "arn:aws:iam::092968731555:group/ECR-Groups/Delageted-Admin-Groups/*",
            "arn:aws:iam::092968731555:group/ECR-Groups/ECR-Worker-Groups/*",
            "arn:aws:iam::092968731555:group/ECR-Groups/ECR-Worker-Groups/*/*"
        ],
        "condition" : {
          "StringEquals": {
            "iam:PermissionBoundary": [
              "arn:aws:iam::092968731555:policy/IAM-PermBound//ECR-PermBounds/Admin-PermBounds/ECR-Admin-Permission-Boundary1"
              ]
            }
          }
        }
    ]
}