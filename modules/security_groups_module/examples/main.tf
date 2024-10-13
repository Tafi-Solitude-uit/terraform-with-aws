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

// Default Security Group
resource "aws_security_group" "anhtaiht_default_sg" {
  vpc_id      = module.vpc_module.vpc_id
  name        = "default-sg-VPC"
  description = "Default security group for VPC"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default-security-group"
  }
}

// Public EC2 security group
resource "aws_security_group" "public_sg" {
  vpc_id      = module.vpc_module.vpc_id
  name = "Public-EC2-SG"
  description = "Allow SSH from a specific IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.12.1/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Private EC2 security group
resource "aws_security_group" "private_sg" {
  vpc_id      = module.vpc_module.vpc_id
  name = "Private-EC2-SG"
  description = "Allow SSH from the public EC2 instance"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}