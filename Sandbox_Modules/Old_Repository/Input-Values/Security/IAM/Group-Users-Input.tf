
      ##### VARIABLE FOR INPUT VALUES TO BE REFERENCED BY MODULE CALL BELOW #####

##### IF CREATING NEW INSTANCE OF GROUPS AND USERS CHANGE VARIABLE AND MODULE NAME TO SOMETHING UNIQUE #####
##### ENSURE THAT BOTH VARAIBLE AND MODULE HAVE THE SAME UNIQUE NAME #####

variable "IAM_GROUP_USERS" {
  # The corresponding documentation for each field can be found in the module below.
  description = "Create the Group, Users, and Apply Assumable Roles."
  type        = map(any)
  default     = {
    tempalate = {
    ##### Group Settings #####
        "name_group" = ["TestGroup"]
        "path_group" = ["/this/is/a/test/group/path/"]
        ## Group Policy Settings ##
        "group_policy_name" = ["TestGroupPolicyName"]
        "put_path_aws_group_policy" = ["/this/is/the/way/"]
        "group_policy_local_path" = ["Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"] 

    ##### Group Memebership Settings #####
      "membership_name" = ["testGroupmembName"]
        ## Add Existing Users to Group ##
        "add_existing_console_users" = [""]

        ## Create/Add Console Users to Group ##
        "users_with_console_access" = ["user1", "user2", "user3"]
        "password_reset_required" = ["true"]
        "put_path_console_users" = ["/this/test/path/"]
        ## To Decrypt passwords generated to give to users use these Commands:
        ## terraform output password | base64 --decode | keybase pgp decrypt
        
        ## Give programmatic access to select new users from above list ##
        "create_access_keys" = {
            "user1" = "keybase:scrumlord",
            "user2" = "keybase:scrumlord",
            "user3" = "keybase:scrumlord"
        }

        "force_destroy" = ["true"]
    } 
  }
}






      ##### MODULE CALL #####

##### EDIT MODULE NAME ONLY IF CREATING NEW GROUP AND USERS #####
##### AS WELL, EDIT THE FOR_EACH ARGUMENT VALUE TO MATCH THE VARIABLE NAME #####
##### LASTLY, EDIT THE LOOKUP() VARIABLE VALUE TO MATCH THE VARIABLE NAME #####
##### ENSURE MODULE NAME IS THE SAME AS THE VARIABLE NAME #####

module "IAM_GROUP_USERS" {
for_each = var.IAM_GROUP_USERS

source = "../../../Modules/Security-Modules/IAM-Modules/Groups-Users-Module"
    # Name of IAM Group & IAM Group Policy

        name_group = lookup(var.IAM_GROUP_USERS[each.key], "name_group" == [""] ? null : "name_group", null)

        path_group = lookup(var.IAM_GROUP_USERS[each.key], "path_group", [""])

        membership_name = lookup(var.IAM_GROUP_USERS[each.key], "membership_name", [""])

        group_policy_name = lookup(var.IAM_GROUP_USERS[each.key], "group_policy_name", [""])

        put_path_aws_group_policy = lookup(var.IAM_GROUP_USERS[each.key], "put_path_aws_group_policy", [""])

        group_policy_local_path = lookup(var.IAM_GROUP_USERS[each.key], "group_policy_local_path", [])

    # List of IAM users to have in an IAM group which can assume the role
    # Can specify users in the AWS console or users created through the "Create-User" module.

        add_existing_console_users = lookup(var.IAM_GROUP_USERS[each.key], "add_existing_console_users" == [""] ? null : "add_existing_console_users", [""])

        users_with_console_access = lookup(var.IAM_GROUP_USERS[each.key], "users_with_console_access", [""])

        password_reset_required = lookup(var.IAM_GROUP_USERS[each.key], "password_reset_required", ["true"])

        put_path_console_users = lookup(var.IAM_GROUP_USERS[each.key], "put_path_console_users", [""])

        create_access_keys = lookup(var.IAM_GROUP_USERS[each.key], "create_access_keys", [{}])

        force_destroy = lookup(var.IAM_GROUP_USERS[each.key], "force_destroy", ["false"])
    } 

    ##### END OF MODULE CALL #####