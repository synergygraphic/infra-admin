# subnet/variables.tf

variable "vpc_id" {
  description = "VPC ID for the subnet"
  type        = string
}

variable "vpc_ipv6_cidr_block" {
  description = "IPv6 CIDR block for the VPC, optional"
  type        = string
}

variable "enable_ipv6" {
  description = "Enable IPv6 for the VPC"
  type        = bool
}

variable "subnet_config" {
  description = "Configuration for each subnet with CIDR and availability zone"
  type = map(object({
    cidr_block        = string
    ipv6_cidr_block   = string
    availability_zone = string
    name              = string
  }))
}

variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}

