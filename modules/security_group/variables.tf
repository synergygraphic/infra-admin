# modules/security_group/variables.tf

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress rules"
  type        = list(string)
}

variable "ingress_config_file" {
  description = "Path to the JSON file for ingress rules"
  type        = string
}

variable "egress_config_file" {
  description = "Path to the JSON file for egress rules"
  type        = string
}

variable "common_tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
}
