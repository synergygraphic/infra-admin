# modules/s3_interface_endpoint/variables.tf

variable "vpc_id" {
  description = "ID of the VPC where the S3 interface endpoint will be created"
  type        = string
}

variable "region" {
  description = "AWS region for the S3 interface endpoint"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID to attach to the S3 interface endpoint"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs where the S3 interface endpoint will be created"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "endpoint_name" {
  description = "Name for the S3 interface endpoint"
  type        = string
}
