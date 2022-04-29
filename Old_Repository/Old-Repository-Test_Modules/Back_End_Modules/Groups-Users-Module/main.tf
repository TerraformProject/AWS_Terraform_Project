resource "aws_iam_group" "this" {
  name = element(var.name_group, 0)
  path = element(var.path_group, 0)
}

resource "aws_iam_group_membership" "this" {

  group = element(var.name_group, 0)
  name  = element(var.membership_name, 0)
  users = concat(var.add_existing_console_users, var.users_with_console_access)

  depends_on = [aws_iam_user_login_profile.console_users_login_profile]
}

# data "aws_iam_user" "get_existing_users" {
#   for_each = toset(var.add_existing_console_users)
#   user_name = each.key
#   }

resource "aws_iam_user" "console_users" {
  for_each = toset(var.users_with_console_access)

  name          = each.key
  path          = element(var.put_path_console_users, 0)
  force_destroy = element(var.force_destroy, 0)
}

resource "aws_iam_user_login_profile" "console_users_login_profile" {
  for_each = toset(var.users_with_console_access)

  user    = each.key
  password_length = 20
  password_reset_required = element(var.password_reset_required, 0)

  pgp_key = element(matchkeys( values(var.create_access_keys), keys(var.create_access_keys), [each.key]), 0)
  #pgp_key = contains(keys(var.create_access_keys), each.key) == true ? element(matchkeys( values(var.create_access_keys), [each.key], keys(var.create_access_keys)),0) : ""

  depends_on = [aws_iam_user.console_users]
}

resource "aws_iam_policy" "this_policy" {
  name        = length(var.group_policy_local_path) != 0 ? element(var.group_policy_name, 0) : ""
  # description = length(var.group_policy_local_path) != 0 ? element(var.group_policy_description, 0) : ""
  path = length(var.group_policy_local_path) != 0 ? element(var.put_path_aws_group_policy, 0) : ""
  count = length(var.group_policy_local_path) > 0 ? 1 : 0

  policy = file(element(var.group_policy_local_path, 0) == "" ? "" : element(var.group_policy_local_path, 0))
}


resource "aws_iam_group_policy_attachment" "group_assumable_roles" {
  group      = aws_iam_group.this.id
  count = length(var.group_policy_local_path) > 0 ? 1 : 0
  policy_arn = aws_iam_policy.this_policy[0].arn

  depends_on = [aws_iam_policy.this_policy]
}

