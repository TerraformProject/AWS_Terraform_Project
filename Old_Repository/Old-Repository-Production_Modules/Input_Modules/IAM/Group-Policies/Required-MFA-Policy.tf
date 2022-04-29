{
    Version = "2012-10-17"
    Statement = [
      {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": [
                "arn:aws:iam:us-east-1:092968731555:role/Network/*"
            ]
      }
    ]
  },
  {
        "Sid": "AllowUserManagementOnlyInTheSpecifiedLocation",
        "Effect": "Allow",
        "Action": [
          "iam:ChangePassword",
          "iam:UpdateLoginProfile",
          "iam:CreateAccountAlias",
          "iam:DeleteAccountAlias"
        ],
        "Resource": [
          "arn:aws:iam::092968731555:mfa/$${aws:username}"
        ]
      },
      {
          "Sid": "AllowManageOwnVirtualMFADevice",
          "Effect": "Allow",
          "Action": [
              "iam:CreateVirtualMFADevice",
              "iam:DeleteVirtualMFADevice"
          ],
          "Resource": "arn:aws:iam::092968731555:mfa/$${aws:username}"
      },
      {
          "Sid": "AllowManageOwnUserMFA",
          "Effect": "Allow",
          "Action": [
              "iam:DeactivateMFADevice",
              "iam:EnableMFADevice",
              "iam:ResyncMFADevice"
          ],
          "Resource": "arn:aws:iam::092968731555:user/$${aws:username}"
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
      }
}