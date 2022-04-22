variable "github_repositories" {
    description = "Settings for create a github repository, repository-project, columns, teams, members"
    type = map(object({
        name = string
        description = string
        visibility = string
        has_projects = bool
        use_template = bool
        template = map(string)
    }))
}

variable "github_teams" {
    description = "Github teams to assign to repositories"
    type = map(object({
        repository_map_key = string
        name = string
        description = string
        privacy = string
        permission = string
        ldap_dn = string
        create_default_maintainer = bool
    }))
    default = null
}

variable "github_projects" {
    description = "Projects specified for the repositories"
    type = map(object({
        repository_map_key = string
        name = string
        body = string
        columns = map(object({
            project_map_key = string
            name = string
            cards = map(map(string))
        }))
        }))
    default = null
}
