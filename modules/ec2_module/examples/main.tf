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

//Public EC2 instance
resource "aws_instance" "public_instance" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-0b3b3b7b7b7b7b7b7"
  security_groups = ["sg-0b3b3b7b7b7b7b7b7"]
  key_name        = "anhtaihtkey"

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "anhtaiht-Public-EC2-Instance"
  }
}

//Private EC2 instance
resource "aws_instance" "private_instance" {
  ami             = "ami-1C231bfafe1f0"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-c3b3b7b7b7b7b7b7"
  security_groups = ["sg-567b3b7b7b7b7b7b7"]
  key_name        = "anhtaihtkey"

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "anhtaiht-Private-EC2-Instance"
  }
}