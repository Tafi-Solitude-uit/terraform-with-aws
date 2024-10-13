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

//Elastic IP for NAT Gateway
resource "aws_eip" "anhtaiht_nat_eip" {
  domain = "vpc"
}

//NAT Gateway
resource "aws_nat_gateway" "anhtai_nat_gw" {
  allocation_id = aws_eip.anhtaiht_nat_eip.id
  subnet_id     = "subnet-0b3b3b3b3b3b3b3b3"

  tags = {
    Name = "Lab01-nat-gw"
  }
}