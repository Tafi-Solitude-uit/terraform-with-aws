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

module "vpc_module" {
  source = "../../vpc_module"
  vpc_cidr = "10.0.0.0/16"
}

//public subnet
resource "aws_subnet" "anhtaiht_public_subnet" {
  vpc_id     = module.vpc_module.vpc_id
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Lab01-public-subnet"
  }
}

//private subnet
resource "aws_subnet" "anhtaiht_private_subnet" {
  vpc_id     = module.vpc_module.vpc_id
  cidr_block = "10.0.2.0/24"

  availability_zone = "us-east-1a"

  tags = {
    Name = "Lab01-private-subnet"
  }
}