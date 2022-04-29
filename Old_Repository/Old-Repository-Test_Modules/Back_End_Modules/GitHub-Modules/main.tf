locals {
 
  project_columns_cards = flatten([ for projects, settings in var.github_projects: 
                                   [ for columns, column_values in settings.columns: column_values]  
                                ])

  project_columns_cards_2 = flatten([ for projects, settings in var.github_projects: 
                                   [ for columns, column_values in settings.columns: 
                                     [ for cards, card_values in column_values.cards: card_values ]  
                                ] ])


  

}


#########################
## GitHub Repositories ##
#########################

resource "github_repository" "repo" {
for_each = var.github_repositories
    name = each.value.name
    description = each.value.description
    visibility = each.value.visibility
    has_projects = each.value.has_projects


    dynamic "template" {
      for_each = each.value.use_template == true ? each.value.template : {}
      content {
        owner = each.value.template.owner
        repository = each.value.template.repository
      }
    }
    
}

################################
## GitHub Repository Projects ##
################################

resource "github_repository_project" "project" {
for_each = var.github_projects 
  name       = each.value.name
  repository = github_repository.repo[each.value.repository_map_key].name 
  body       = each.value.body

  depends_on = [ github_repository.repo ]
}

###############################################
## GitHub Repository Project Columns & Cards ##
###############################################

resource "github_project_column" "columns" {
for_each = { for o in local.project_columns_cards: "${o.project_map_key}.${o.name}" => o }
            
  project_id = github_repository_project.project[each.value.project_map_key].id
  name       = each.value.name

  depends_on = [ github_repository_project.project ]
}

resource "github_project_card" "card" {
for_each = { for o in local.project_columns_cards_2: "${o.column_map_key}.${o.note}" => o }
  column_id = github_project_column.columns[each.value.column_map_key].column_id
  note        = each.value.note
}

##################
## GitHub Teams ##
##################

resource "github_team" "teams" {
for_each = var.github_teams 
  name        = each.value.name
  description = each.value.description
  privacy     = each.value.privacy
  ldap_dn = each.value.ldap_dn == "" ? null : each.value.ldap_dn
  create_default_maintainer = each.value.create_default_maintainer
}

resource "github_team_repository" "some_team_repo" {
for_each = var.github_teams    
  team_id    = github_team.teams[each.key].id
  repository = github_repository.repo[ each.value.repository_map_key ].name
  permission = each.value.permission
}