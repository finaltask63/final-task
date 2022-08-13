#-------------------------------------------------------#
#							#
#		Main definitions here			#
#							#
#-------------------------------------------------------#


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.24"
    }
  }

  backend "s3" {
    bucket = "devops13-state"
    key = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "devops13-locks-db"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = local.region
}

locals {
  region = "us-west-2"
}
