# main.tf or backend.tf

terraform {
  backend "s3" {
    bucket         = "80-nop-s3-bucket-mvp-analitca-02-terraform-01-aws-noinet"  # Updated bucket name
    key            = "modular-vpc/terraform.tfstate"          # Folder structure and state file name
    region         = "eu-west-1"                                   # AWS region
    dynamodb_table = "terraform-state-lock"                        # Optional, if using DynamoDB for locking
    encrypt        = true                                          # Ensures state is encrypted
  }
}
