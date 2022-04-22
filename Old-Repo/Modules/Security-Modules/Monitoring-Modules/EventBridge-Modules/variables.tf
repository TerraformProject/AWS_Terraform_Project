variable "create_new_event_buses" {
    description = "Whether to create new buses or not"
    type = bool 
    default = false
}

variable "new_event_buses" {
    description = "Mapping of maps for new event buses to be created"
    type = any
    default = null
}

variable "create_sender_account_permission" {
    description = "Whether to create sender account bus permission or not"
    type = bool 
    default = false
}

variable "sender_account_permissions" {
    description = "Mapping of maps for sender account permissions to be created"
    type = any
    default = null
}

variable "cloudwatch_rule_target" {
    description = "Mapping of maps for event bridge rules and targets"
    type = any
    default = null
}