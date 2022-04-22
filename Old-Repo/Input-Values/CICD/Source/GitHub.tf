provider "github" {
  alias = "ali1"
  owner = "TerraformProject" # Can also specify the Organization Name
  token = "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"
}

module "GITHUB_VPC1" {
    source = "../../../Modules/CICD-Modules/GitHub-Modules"
###########################
## GitHub Authentication ##
###########################
providers = {
    github = github.ali1
}

########################################
## GitHub Projects & Teams & Memebers ##
########################################

github_repositories = {

    repository_1 = {
        name = "repo_yuh"
        description = "description for repo yuh"
        use_template = false
        template = { owner = "", repository = ""}
        visibility = "private"
        has_projects = true
        }

}

github_teams = {

    team_1 = {
        repository_map_key = "repository_1" # Required
        name        = "team_yuh" 
        description = "Some yuh team"
        privacy     = "secret"
        permission = "pull"
        ldap_dn = "" # Only supported for Github Enterprise Server
        create_default_maintainer = false
        }

}

github_projects = {

    project_1 = {
        repository_map_key = "repository_1" # Use map keys from above repositories
        name = "project_yuh"
        body = "body_yuh"
        columns = {
            column_1 = {
                project_map_key = "project_1"
                name = "To-Do"
                cards = {
                    card_1 = {
                        column_map_key = "project_1.To-Do"
                        note = "This yuh is cool"
                    }
                }
            }
            column_2 = {
                project_map_key = "project_1"
                name = "In-Progress"
                cards = {
                    card_1 = {
                        column_map_key = "project_1.In-Progress"
                        note = "This is the card of yuh"
                    }
                    card_2 = {
                        column_map_key = "project_1.In-Progress"
                        note = "This yuh"
                    }
                }
            }
            column_3 = {
                project_map_key = "project_1"
                name = "Done"
                cards = {
                    
                }
            }
        }
    }

    






}





}
