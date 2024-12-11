#  modules/subnet/outputs.tf

output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = { for name, subnet in aws_subnet.this : name => subnet.id }
}

output "subnet_cidrs" {
  description = "The CIDR blocks of the created subnets"
  value       = { for name, subnet in aws_subnet.this : name => subnet.cidr_block }
}
