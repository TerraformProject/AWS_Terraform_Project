###################
## AMI Variables ## 
###################

variable "create_new_ami" {
  description = "Wheather to create a new AMI"
  type = bool
  default = false
}

variable "ami_name" {
  description = "Name for the AMI"
  type = string
  default = ""
}

variable "ami_description" {
  description = "Description of the AMI"
  type = string
  default = ""
}

variable "root_device_name" {
  description = "Name of the root device"
  type = string
  default = ""
}

variable "architecture" {
  description = "The architecture for the AMI"
  type = string
  default = "x86_64"
}

variable "enhanced_networking_support" {
  description = "Whether enhanced networking is enabled for the AMI"
  type = bool
  default = false
}

variable "virtualization_type" {
  description = "The type of virtualization for the AMI. Can be either hvm or paravirtual"
  type = string
  default = null
}

variable "virtualization_settings" {
  description = "The settings for either the hvm or paravirtual virtualization types"
  type = map(string)
  default = {}
}

variable "ebs_block_devices" {
  description = "Map of objects to specify the ebs bloxks for the AMI"
  type = map(object({
    existing_snapshot_id = string
    use_new_snapshot = bool
    ebs_key = string
    availability_zone = string
    ebs_tags = map(string)
    snapshot_tags = map(string)
    device_name = string
    volume_type = string
    volume_size = number
    iops = number
    throughput = number
    delete_on_termination = bool

  }))
}

variable "ephemeral_block_devices" {
  description = "The ephemeral block devices to attach to the AMI"
  type = map(map(string))
  default = {}
}

variable "timeouts" {
  description = "The timeoutes specified for the AMI"
  type = map(string)
  default = {}
}

variable "ami_tags" {
  description = "The tags to associate with the AMI"
  type = map(string)
}

###############################
## Launch Template Variables ##
###############################

## GENERAL SETTING VARIABLES ##

variable "create_lt" {
  description = "Whether to create the launch template or not."
  type = bool 
  default = false
}

variable "lt_use_name_prefix" {
  description = "Wheather to use a name prefix instead of a regular name"
  type = bool
  default = false
}

variable "lt_name" {
  description = "Name of launch template"
  type = string
  default = ""
}

variable "name" {
  description = "Name of launch template"
  type = string
  default = ""
}

variable "lt_description" {
  description = "Description of launch template"
  type = string
  default = ""
}

## VERSION SETTING VARIABLES ##

variable "default_version" {
  description = "Default version of the launch template"
  type = string
  default = null
}

variable "update_default_version" {
  description = "Wheather to update the default version of the launch template. Conflicts with `default_version"
  type = string
  default = null
}

## AMI SETTING VARIABLES ##

variable "use_new_ami" {
  description = "Whether to use the newly created AMI in the module for the launch template"
  type = bool
  default = false
}

variable "use_existing_ami_id" {
  description = "Whether to use the ID of an existing AMI"
  type = bool
  default = false
}

variable "existing_ami_id" {
  description = "The AMI in the existing account to use for the launch template"
  type = string
  default = "" 
}

variable "copy_ami" {
  description = "Copy an AMI from a seperate region to use for the launch template"
  type = object({
    enable = bool
    name = string
    description = string
    source_ami_id = string
    source_ami_region = string
    encrypted = bool
    kms_key_id = string
    create_new_kms_key = bool
    new_kms_key_settings = map(object({
      description = string
      is_enabled = bool
      policy = string
      enable_key_rotation = bool
      deletion_window_in_days = number
      tags = map(string)
    }))
    tags = map(string)
  })
  default = null
}

variable "copy_instance_ami" {
  description = "Copy an AMI from an instance to use for the launch template"
  type = object({
    enable = bool
    name = string
    source_instance_id = string
  })
}

## PRICE MANAGEMENT SETTING VARIABLES ##

variable "create_instance_market_options" {
  description = "Whether to create instance market options"
  type        = bool
  default     = false
}

variable "instance_market_options" {
  description = "(LT) The market (purchasing) option for the instance"
  type        = map(object({
    market_type = string
    create_spot_options = bool
    spot_options = map(object({
      block_duration_minutes = number
      instance_interruption_behavior = string
      max_price = string
      spot_instance_type = string
      valid_until = string
    }))
  }))
  default     = null
}

variable "create_license_specifications" {
  description = "Whether to create create license specifications"
  type        = bool
  default     = false
}

variable "license_specifications" {
  description = "(LT) A list of license specifications to associate with"
  type        = map(map(string))
  default     = {}
}

## INSTANCE SETTING VARIABLES ##

variable "instance_type" {
  description = "The type of the instance."
  type = string
  default = ""
}

variable "kernel_id" {
  description = "(LT) The kernel ID"
  type        = string
  default     = null
}

variable "ram_disk_id" {
  description = "(LT) The ID of the ram disk"
  type        = string
  default     = null
}

variable "user_data_local_file_path" {
  description = "The local path to the file containing user data"
  type = string
  default = ""
  sensitive = false
}

variable "user_data_env_vars" {
  description = "Module values to input into user data file as environment variables"
  type = map(string)
  default = {}
}

variable "create_metadata_options" {
  description = "Create metadata options"
  type        = bool
  default     = false
}

variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type        = map(object({
    http_endpoint = string
    http_tokens = string
    http_put_response_hop_limit = number
  }))
  default     = null
}

variable "create_placement" {
  description = "Whether to create a placement"
  type        = bool
  default     = false
}

variable "placement" {
  description = "(LT) The placement of the instance"
  type        = map(object({
    affinity          = string
    availability_zone = string
    group_name        = string
    host_id           = string
    spread_domain     = string
    tenancy           = string
    partition_number  = number
  }))
  default     = {}
}

variable "create_capacity_reservation_specification" {
  description = "Wheather to create capacity reservation specification"
  type        = bool
  default     = false
}

variable "capacity_reservation_specification" {
  description = "(LT) Targeting for EC2 capacity reservations"
  type        = map(object({
    capacity_reservation_preference = string
    capacity_reservation_target = map(string)
  }))
  default     = null
}

variable "create_hibernation_options" {
  description = "Whether to create hibernation options"
  type        = bool
  default     = false
}

variable "hibernation_options" {
  description = "(LT) The hibernation options for the instance"
  type        = map(string)
  default     = {}
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Can be `stop` or `terminate`. (Default: `stop`)"
  type = string
  default = null
}

## CPU SETTING VARIABLES ##

variable "create_cpu_options" {
  description = "Whether to create cpu options"
  type        = bool
  default     = false
}

variable "cpu_options" {
  description = "(LT) The CPU options for the instance"
  type        = map(number)
  default     = {}
}

variable "create_credit_specification" {
  description = "Whether to create credit specification"
  type        = bool
  default     = false
}

variable "credit_specification" {
  description = "(LT) Customize the credit specification of the instance"
  type        = map(string)
  default     = {}
}

## GPU SETTING VARAIBLES ##

variable "create_elastic_gpu_specifications" {
  description = "(LT) The elastic GPU to attach to the instance"
  type        = bool
  default     = false
}

variable "elastic_gpu_specifications" {
  description = "(LT) The elastic GPU to attach to the instance"
  type        = map(string)
  default     = {}
}

variable "create_elastic_inference_accelerator" {
  description = "Whether to create an elastic inference accelerator"
  type        = bool
  default     = false
}

variable "elastic_inference_accelerator" {
  description = "(LT) Configuration block containing an Elastic Inference Accelerator to attach to the instance"
  type        = map(string)
  default     = {}
}

## EBS SETTING VARIABLES ##

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  type = bool
  default = false
}

variable "manage_block_device_mappings" {
  description = "Wheather to create the ebs block device mappings"
  type = bool
  default = false  
}

variable "block_device_mappings" {
  description = "(LT) Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type        = map(object({
    device_name = string
    no_device = string
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      iops                  = number
      throughput            = number
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
      encrypted             = bool
      kms_key_id            = string
      create_new_kms_key = bool
      new_kms_key_settings = any
    })
  }))
  default     = {}
}

## NETWORKING SETTING VARIABLES ##

variable "disable_api_termination" {
  description = "If true, enables EC2 instance termination protection"
  type = bool
  default = null
}

variable "create_network_interfaces" {
  description = "whether to create network interfaces"
  type        = bool
  default     = false
}

variable "network_interfaces" {
  description = "(LT) Customize network interfaces to be attached at instance boot time"
  type        = map(object({
    associate_carrier_ip_address = bool
    associate_public_ip_address  = bool
    delete_on_termination        = bool
    description                  = string
    device_index                 = number
    ipv4_addresses               = list(string)
    ipv4_address_count           = number
    ipv6_addresses               = list(string)
    ipv6_address_count           = number
    existing_network_interface_id         = string
    primary_private_ip_address           = string
    existing_security_groups              = list(string)
    use_new_security_groups = list(string)
    subnet_id                    = string
    existing_network_interface_id = string
    new_network_interface = bool
    source_dest_check = bool
    interface_type = string
  }))
  default     = {}
}

## SECURITY/MONITORING SETTING VARIABLES ##

variable "use_new_security_groups" {
  description = "Whether to use the newly created security groups from the module "
  type = list(string)
  default = []
}

variable "existing_security_group_ids" {
  description = "Securtiy groups to be used for the instance"
  type = list(string)
  default = []
}

variable "key_name" {
  description = "The key name that should be used for the instance."
  type = string
  default = ""
}

variable "create_iam_instance_profile" {
  description = "Whether to create an IAM Instance Profile for the instance"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "(LT) The IAM Instance Profile ARN to launch the instance with"
  type        = map(string)
  default     = {}
}

variable "create_enclave_options" {
  description = "Whether to create enclave options"
  type        = bool
  default     = false
}

variable "enclave_options" {
  description = "(LT) Enable Nitro Enclaves on launched instances"
  type        = map(string)
  default     = {}
}

variable "create_monitoring" {
  description = "Whether to create monitoring"
  type = bool
  default = false
}

variable "monitoring" {
  description = "Specify if monitoring is enabled or disabled"
  type = map(bool)
  default = {}
}

## LAUNCH TEMPLATE TAG SETTING VARIABLES ##

variable "create_tag_specifications" {
  description = "whether to create tag specifications"
  type        = bool
  default     = false
}

variable "tag_specifications" {
  description = "(LT) The tags to apply to the resources during launch"
  type        = map(object({
    resource_type = string
    tags = map(string)
  }))
  default     = {}
}

variable "launch_template_tags" {
  description = "Tags for the lainch template"
  type        = map(string)
  default     = {}
}

variable "create_ami_launch_permissions" {
  description = "Whether to create launch permission for the AMI"
  type = bool
  default = false
}

variable "ami_launch_permissions" {
  description = "settings for creating one or more launch permissions for the AMI"
  type = map(map(string))
  default = {}
}

#############################################
## Launch Template Security Group Variable ##
#############################################

variable "create_launch_template_security_groups" {
  description = "whether or not to create the security groups for the launch template"
  type = bool
  default = false
}

variable "launch_template_security_groups" {
  description = "Mapping of objects for specified security groups"
  type = map(object({
    name = string
    description = string
    vpc_id = string
    ingress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      security_groups = list(string)
      self = bool
    }))
    egress_rules = map(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
      ipv6_cidr_blocks = list(string)
      security_groups = list(string)
      self = bool
    }))
    tags = map(string)
  }))
  default = null
}
