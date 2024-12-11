# provider.tf

# Provider Configuration with Default Tags

provider "aws" {
    region = var.region
    default_tags {
    tags = local.common_tags
  }
}
