module "SECURITY_GROUPS_VPC1" {
    source = "../../Modules/Compute-Modules/Default-Modules/Security-Groups-Modules"

public_security_groups = {}
    
private_security_groups = {}

database_security_groups = {}
    
}