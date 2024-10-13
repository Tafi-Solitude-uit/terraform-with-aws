terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "anhtaiht"
}

resource "aws_internet_gateway" "anhtaiht_igw" {
  vpc_id = "vpc-0b3b3b3b3b3b3b3b3"

  tags = {
    Name = "Lab01-igw"
  }
}