# Root variables.tf

# VPC-related variables

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "environment" {
  description = "Environment for tagging purposes (e.g., dev, test, prod)"
  type        = string
}

variable "enable_ipv6" {
  description = "Enable IPv6 for the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

# Combined variable for subnet configurations

variable "subnet_config" {
  description = "Configuration for each subnet with CIDR, AZ, and name"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
    ipv6_cidr_block    = string # Optional
  }))
}

# Mapping of subnet names to route table names
variable "route_table_names" {
  description = "Map of subnet names to route table names"
  type        = map(string)
}

# Mapping of subnet names to route table JSON files
variable "route_config_files" {
  description = "Map of subnet names to JSON configuration files for routes"
  type        = map(string)
}

# Security Group Variables
variable "s3_interface_sg_name" {
  description = "Name for the S3 Interface Endpoint Security Group"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed for S3 Interface Endpoint ingress"
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

# S3 Interface Endpoints vars

variable "s3_interface_endpoint_name" {
  description = "Name for the S3 interface endpoint"
  type        = string
}

# S3 Gateway Endpoints

variable "s3_gateway_endpoint_name" {
  description = "Name tag for the S3 Gateway Endpoint"
  type        = string
}

# Variables del COMMON TAGS

variable "usuario" {
  description = "Valor del TAG de USUARIO"
  type        = string
}

variable "centro_costes" {
  description = "Valor del TAG de CENTRO_COSTES"
  type        = string
}

variable "departamento" {
  description = "Valor del TAG de DEPARTAMENTO"
  type        = string
}

variable "proyecto" {
  description = "Valor del TAG de PROYECTO"
  type        = string
}
