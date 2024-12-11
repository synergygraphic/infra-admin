# Root main.tf

# Define common tags
locals {
  common_tags = {
    USUARIO       = var.usuario
    CENTRO_COSTES = var.centro_costes
    DEPARTAMENTO  = var.departamento
    PROYECTO      = var.proyecto
    ENTORNO       = var.environment
  }
}

# Call the VPC module
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  region                = var.region
  environment           = var.environment
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  vpc_ipv6_cidr_block   = var.vpc_ipv6_cidr_block  # Pass the IPv6 CIDR block here

  # Required tags and environment variables
  common_tags           = local.common_tags
}

# Subnet module

module "subnets" {
  source = "./modules/subnet"

  vpc_id        = module.vpc.vpc_id
  subnet_config = var.subnet_config
  enable_ipv6   = var.enable_ipv6
  # Required tags and environment variables
  common_tags   = local.common_tags   # Use local here
}

# Call the route table module for each sunet to be created

module "route_tables" {
  source = "./modules/route_table"

  for_each = var.route_table_names

  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.subnets.subnet_ids[each.key]
  route_table_name  = each.value
  common_tags       = local.common_tags
  route_config_file = var.route_config_files[each.key]
}

# S3 Interface Endpoint Security Group
module "s3_interface_security_group" {
  source              = "./modules/security_group"
  vpc_id              = module.vpc.vpc_id
  security_group_name = var.s3_interface_sg_name
  ingress_config_file = "data/security_groups/s3_endpoint_ingress.json"
  egress_config_file  = "data/security_groups/s3_endpoint_egress.json"
  allowed_cidr_blocks = var.allowed_cidr_blocks  # Ensure this is defined
  common_tags         = local.common_tags
}

# Retrieve Security Group ID for use in the endpoints module
output "s3_interface_sg_id" {
  description = "ID of the S3 Interface Security Group"
  value       = module.s3_interface_security_group.security_group_id  # Updated name
}


##################            S3 Endpoint Modules      #########################

# S3 Gateway Endpoint Module with added dependency

module "s3_gateway_endpoint" {
  source                  = "./modules/s3_gateway_endpoint"
  vpc_id                  = module.vpc.vpc_id
  region                  = var.region
  route_table_ids         = [for rt in module.route_tables : rt.route_table_id]
  common_tags             = local.common_tags
  endpoint_name           = var.s3_gateway_endpoint_name

  # Ensures the gateway waits until the VPC, subnets, and route tables are created
  depends_on = [
    module.vpc,
    module.subnets,
    module.route_tables,
    module.s3_interface_security_group
  ]
}

# S3 Interface endpoint module

# Define local variables specifically for the endpoint configuration
locals {
  s3_endpoint_subnet_ids = [
    module.subnets.subnet_ids["lakehouse_az1"],
    module.subnets.subnet_ids["lakehouse_az2"]
  ]
  s3_interface_security_group_id = module.s3_interface_security_group.security_group_id
}

# S3 Interface Endpoint Module with dependency on S3 Gateway

module "s3_interface_endpoint" {
  source            = "./modules/s3_interface_endpoint"
  vpc_id            = module.vpc.vpc_id
  region            = var.region
  security_group_id = local.s3_interface_security_group_id
  subnet_ids        = local.s3_endpoint_subnet_ids  # Directly reference the local variable here
  common_tags       = local.common_tags
  endpoint_name     = var.s3_interface_endpoint_name  # Pass the variable here

  # Ensure the interface endpoint waits for the gateway endpoint
  depends_on = [module.s3_gateway_endpoint.s3_gateway_id]

}
