terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias  = "west"
  region = var.region
}

provider "aws" {
  alias  = "east"
  region = var.destination_region
}
#pass environment variables for access and secret key

#export AWS_ACCESS_KEY_ID=""
#export AWS_SECRET_ACCESS_KEY=""