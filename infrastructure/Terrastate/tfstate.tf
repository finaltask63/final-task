#-----------------------------------------------#
#						#
#	S3 bucket for .tfstate storage		#
#	DynamoDB table is also here		#
#						#
#-----------------------------------------------#


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.24"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = "devops13-state"

#  lifecycle {
#    prevent_destroy = true
#  }

  tags = {
    Name = "devops13-tfstate"
    Owner = "devops13"
    Purpose = "The final task lab"
  }

}

resource "aws_dynamodb_table" "terraform_locks" {

  hash_key = "LockID"
  name = "devops13-locks-db"

  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

}




