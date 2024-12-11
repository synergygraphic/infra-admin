# modules/security_group/main.tf

resource "aws_security_group" "this" {
  name        = var.security_group_name
  vpc_id      = var.vpc_id
  description = "Security group for S3 Interface Endpoints"

  # Apply ingress rules from JSON configuration
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Apply egress rules from JSON configuration
  dynamic "egress" {
    for_each = local.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    var.common_tags,
    { Name = var.security_group_name }  # Add the Name tag here
  )
}

# Load ingress and egress rules from JSON files
data "local_file" "ingress" {
  filename = var.ingress_config_file
}

data "local_file" "egress" {
  filename = var.egress_config_file
}

locals {
  ingress_rules = jsondecode(data.local_file.ingress.content)
  egress_rules  = jsondecode(data.local_file.egress.content)
}
