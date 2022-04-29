locals {

  trusts = flatten(
    [ for role, trust_settings in var.Roles: role ] 
  )

  mfa = flatten(
    [ for role in var.Roles:
        [ for mfa, mfa_settings in role: mfa if mfa == "MFA" ]
      ]
  )

  permission_boundary = flatten(
   [ for role, role_settings in var.Roles:
       [ for Permission_Boundary, Permission_Boundary_Settings in role_settings: Permission_Boundary_Settings if Permission_Boundary == "Permission_Boundary" ] 
      ]
  )

  existing_policies = flatten([ for roles, role_settings in var.Roles:
                                [for policy, values in role_settings.Add_Existing_Policies: {
                                  role_name = values.role_name
                                  arn = values.arn
                                } ] ] )

  policies = flatten([for roles, role_settings in var.Roles: 
                        [ for policy, values in role_settings.New_Policies: 
                            {
                              role_name = values.role_name
                              policy_name = values.policy_name
                              description = values.description
                              path = values.path 
                              local_path_json_file = values.local_path_json_file 
                            } ] ] )

  policy_attachment = values(tomap({ for k in keys(aws_iam_role.this): k => k  }))

   policy_tags = [ for role in var.Roles: lookup(role, "Policy_Tags", "") ] 

}

data "aws_iam_policy_document" "assume_role" {

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"] 

    dynamic "principals" {
    for_each = var.Roles  
        content {
        type        = "AWS"
        identifiers = lookup(principals.value.Trusts, "trusted_role_arns", "" )
        } 
    }

    dynamic "principals" {
    for_each = var.Roles
      
        content {
        type        = "Service"
        identifiers = lookup(principals.value.Trusts, "trusted_role_services", "" )
        }
    }

    dynamic "condition" {
    for_each = var.Roles 

      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [ for k, v in condition.value.Trusts: v if k == "role_sts_externalid" ]
      } 
    }
  }
}

data "aws_iam_policy_document" "assume_role_with_mfa" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    dynamic "principals" {
    for_each = var.Roles  
        content {
        type        = "AWS"
        identifiers = lookup(principals.value.Trusts, "trusted_role_arns", "" )
        } 
    }

    dynamic "principals" {
    for_each = var.Roles
      
        content {
        type        = "Service"
        identifiers = lookup(principals.value.Trusts, "trusted_role_services", "" )
        }
    }

    dynamic "condition" {
    for_each = var.Roles  

      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [ for k, v in condition.value.Trusts: v if k == "role_sts_externalid" ]  
      } 
    }

    dynamic "condition" {
      for_each = var.Roles
      content {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = [ for k, v in condition.value.MFA: v if k == "role_requires_mfa" ]
      }
    }

    dynamic "condition" {
      for_each = var.Roles
      content {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [ for k, v in condition.value.MFA: v if k == "mfa_age" ]
      }
    }
  }
}

resource "aws_iam_role" "this" {
for_each = var.Roles

  name                 = lookup(var.Roles[each.key], "name", "")  
  path                 = lookup(var.Roles[each.key], "path", "")
  max_session_duration = lookup(var.Roles[each.key], "max_session_duration", "")
  description          = lookup(var.Roles[each.key], "description", "")

  force_detach_policies = lookup(var.Roles[each.key], "force_detach_policies", "")
 
  permissions_boundary = aws_iam_policy.permission_boundary[each.key].arn

  assume_role_policy = lookup(each.value.MFA, "role_requires_mfa", false ) == true ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = lookup(var.Roles[each.key], "Role_Tags", {})
}

resource "aws_iam_policy" "permission_boundary" {
for_each = var.Roles

  name        = lookup(each.value.Permission_Boundary, "name", "" )
  path        = lookup(each.value.Permission_Boundary, "path", "" )
  description = lookup(each.value.Permission_Boundary, "description", "" )

  policy = file( lookup(each.value.Permission_Boundary, "local_path_json_file", "" ) )

  tags = { for k in var.Roles: k => k if k == "Permission_Boundary_Tags"}
}

resource "aws_iam_policy" "policy" {
for_each = { for o in local.policies : "${o.role_name}.${o.policy_name}.${o.description}.${o.path}.${o.local_path_json_file}" => o }

  name        = each.value.policy_name
  path        = each.value.path
  description = each.value.description

  policy = file(each.value.local_path_json_file) 

  tags =  element(tolist(local.policy_tags), 0)
}

resource "aws_iam_role_policy_attachment" "policy-attach-locals" {
for_each = { for o in local.policies : "${o.role_name}.${o.policy_name}.${o.description}.${o.path}.${o.local_path_json_file}" => o }

  role       = aws_iam_role.this[ element(local.policy_attachment, index(local.policy_attachment, each.value.role_name) ) ].name
  policy_arn = aws_iam_policy.policy[each.key].arn
}

resource "aws_iam_role_policy_attachment" "policy-attach-existing" {
for_each = { for o in local.existing_policies: "${o.role_name}.{o.arn}" => o}

  role       = aws_iam_role.this[ each.value.role_name ].name
  policy_arn = each.value.arn
}