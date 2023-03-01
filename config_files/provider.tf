# Provider Configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.53"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}