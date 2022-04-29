module "IAM_ROLES_POLICIES" {
source = "../../../Modules/Security-Modules/IAM-Modules/Roles-Policies-Modules"
Roles = {
    Role1 = {
        name = "Role1"
        description = "Test Description"
        path = "/"
        force_detach_policies = false
        max_session_duration = 25365

        Trusts = {
                trusted_role_arns = [ "arn:aws:iam::092968731555:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor" ]
                trusted_role_services = [ "ec2.amazonaws.com" ] 
                role_sts_externalid = ""  
                }

        MFA = {
                role_requires_mfa = true
                mfa_age = "3600"
            }

        Permission_Boundary = {
                existing_permission_boundary_arn = ""
                # Create new Permissions Boubdary
                name = "permbound1"
                description = "Permbound Description"
                path = "/"
                local_path_json_file = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"
        }

        Add_Existing_Policies = {
            Policy_1 = {
                    role_name = "Role1" #Required
                    arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
                }
            }

        New_Policies = {
            Policy1 = {
                    role_name = "Role1" # Required
                    policy_name = "TestPolicy1"
                    description = "Desc1"
                    path = "/this/is/a/test/path/"
                    local_path_json_file = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"
                } 
            }

        Role_Tags ={
            "Role" = "RoleYuh"
        }

        Permission_Boundary_Tags = {
            "PermissionBoundary" = "PermBoundYuh",
            "sdgdfg" = "asdfwww"
        }

        Policy_Tags ={
            "YuhPolicy" = "PolicyYuh",
            "aggadvd" = "awfefeef"
        }

    }
    
}




}















