{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal" : {
        "AWS" : "${var.trusted_role_arns}",
        "Service" : "${var.trusted_role_services}"
      },
      "Condition" : {
          "Bool" : { "aws:MultiFactorAuthPresent" :  "true" },
          "NumericLessThan" : { "aws:MultiFactorAuthAge" : "${var.mfa_age}" }
      }
    }
  ]
}