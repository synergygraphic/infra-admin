# modules/vpc/variables.tf

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}


variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "region" {
  description = "AWS region where the VPC will be created"
  type        = string
}

variable "environment" {
  description = "Environment for tagging purposes"
  type        = string
}

variable "enable_ipv6" {
  description = "Enable IPv6 for the VPC"
  type        = bool
}

variable "vpc_ipv6_cidr_block" {
  description = "IPv6 CIDR block for the VPC, optional"
  type        = string
  default     = null
}
