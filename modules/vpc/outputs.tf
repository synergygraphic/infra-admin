# modules/vpc/outputs.tf

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

# VPC CIDR Block
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

# VPC ARN
output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.this.arn
}

# Main Route Table ID
output "main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = aws_vpc.this.main_route_table_id
}

# Default Security Group ID
output "default_security_group_id" {
  description = "The ID of the default security group in this VPC"
  value       = aws_vpc.this.default_security_group_id
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block assigned to the VPC"
  value       = aws_vpc.this.assign_generated_ipv6_cidr_block ? aws_vpc.this.ipv6_cidr_block : null
}

