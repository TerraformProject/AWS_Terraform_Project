module "EVENT_BRIDGE_VPC1" {
    source = "../../../Modules/Security-Modules/Monitoring-Modules/EventBridge-Modules"

########################
## Event Bridge Buses ##
########################    

create_new_event_buses = true
new_event_buses = {
    bus_1 = {
        name = "bus_1"
    }
}

#############################
## EventBridge Permissions ##
#############################

create_sender_account_permission = true
sender_account_permissions = {
    permission_1 = {
        principal = "123456789101"
        statement_id = "the_yuh_statement_id"
        action = "events:PutEvents"
        event_bus_name = "bus_1" # Specify the map key of newly created bus. "" will use default bus
        }
}

##################################
## Event Bridge Rules & Targets ##
##################################

cloudwatch_rule_target = {

    target_rule_1 = {
        rule = {
                name = "nameyuh"
                # name_prefix = ""
                description = "hdfghdfgh"
                is_enabled = true
                role_arn = ""
                event_bus_name = "bus_1" # Specify the map key of newly created bus. "" will use default bus

                # schedule_expression = ""
                event_pattern = <<EOF
                {
                "detail-type": [
                    "AWS Console Sign In via CloudTrail"
                    ]
                }
                EOF

                tags = {
                    "keyyuh" = "yuhvalue"
                } 
            }
        target = {
                associated_rule_name = "nameyuh" # Required
                target_id = "sdfgsdfgds"
                arn = ""
                event_bus_name = "bus_1" # Specify the map key of newly created bus. "" will use default bus
                role_arn = ""

                # input = ""
                # input_path = ""
                # run_command_targets = {}
                # ecs_target = {} 
                # batch_target = {}
                # kinesis_taget = {}
                # sqs_target = {}
                # retry_policy = {}
                # dead_letter_config = {}
                # input_transformer = {}
            }
        
        }
    
}










}



