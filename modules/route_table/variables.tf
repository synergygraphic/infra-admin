# modules/route_table/variables.tf

variable "vpc_id" {
  description = "VPC ID for the route table"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to associate with the route table"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the route table"
  type        = string
}

variable "route_config_file" {
  description = "Path to the JSON file with route configurations"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}

