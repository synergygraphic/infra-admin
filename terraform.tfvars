# Root terraform.tfvars

# VPC Configuration
vpc_cidr            = "10.92.8.0/21"
vpc_ipv6_cidr_block = "2a05:d018:1675:4700::/56"
vpc_name            = "80-nop-ec2-vpc-01-lab_mvp_analitica-02"
region              = "eu-west-1"
environment         = "nop"
enable_dns_support   = true
enable_dns_hostnames = true
enable_ipv6         = true

# Subnet Configuration
subnet_config = {
  lakehouse_az1       = { cidr_block = "10.92.8.0/24", availability_zone = "eu-west-1a", name = "lakehouse_az1", ipv6_cidr_block = "2a05:d018:1675:4700::/64" }
  lakehouse_az2       = { cidr_block = "10.92.9.0/24", availability_zone = "eu-west-1b", name = "lakehouse_az2", ipv6_cidr_block = "2a05:d018:1675:4701::/64" }
  processing_glue_az1 = { cidr_block = "10.92.10.0/24", availability_zone = "eu-west-1a", name = "processing_glue_az1", ipv6_cidr_block = "2a05:d018:1675:4702::/64" }
  processing_glue_az2 = { cidr_block = "10.92.11.0/24", availability_zone = "eu-west-1b", name = "processing_glue_az2", ipv6_cidr_block = "2a05:d018:1675:4703::/64" }
  governance_az1      = { cidr_block = "10.92.12.0/25", availability_zone = "eu-west-1a", name = "governance_az1", ipv6_cidr_block = "2a05:d018:1675:4704::/64" }
  admin_az1           = { cidr_block = "10.92.12.128/25", availability_zone = "eu-west-1a", name = "admin_az1", ipv6_cidr_block = "2a05:d018:1675:4705::/64" }
}


# Route Table Mapping
route_table_names = {
  "lakehouse_az1"       = "80-nop-ec2-rt-lakehouse-01_az1-02"
  "lakehouse_az2"       = "80-nop-ec2-rt-lakehouse-02_az2-02"
  "processing_glue_az1" = "80-nop-ec2-rt-processing_glue-03_az1-02"
  "processing_glue_az2" = "80-nop-ec2-rt-processing-04_az2-02"
  "governance_az1"      = "80-nop-ec2-rt-governance-05_az1-02"
  "admin_az1"           = "80-nop-ec2-rt-admin-06_az1-02"
}

# Mapping of route table JSON files for each subnet

route_config_files = {
  "lakehouse_az1"       = "data/route_tables/lakehouse_az1_routes.json"
  "lakehouse_az2"       = "data/route_tables/lakehouse_az2_routes.json"
  "processing_glue_az1" = "data/route_tables/processing_glue_az1_routes.json"
  "processing_glue_az2" = "data/route_tables/processing_glue_az2_routes.json"
  "governance_az1"      = "data/route_tables/governance_az1_routes.json"
  "admin_az1"           = "data/route_tables/admin_az1_routes.json"
}

# S3 Interface Endpoint Configuration
s3_interface_endpoint_name  = "80-pro-ec2-iep-S3_Interface_Endpoint-02"
s3_interface_sg_name        = "80-nop-ec2-sg-S3_Interface_Endpoint_SG-02"
allowed_cidr_blocks         = ["10.92.8.0/21"]

# S3 Gateway Endpoint
s3_gateway_endpoint_name = "80-nop-ec2-s3_gateway_endpoint-02"

# Security Groups
ingress_config_file = "data/security_groups/ingress_rules.json"
egress_config_file  = "data/security_groups/egress_rules.json"

# COMMON TAGS

usuario       = "EJIE"
centro_costes = "EJIE"
departamento  = "LAB-MVP-ANALITICA"
proyecto      = "LAB-MVP-ANALITICA"


