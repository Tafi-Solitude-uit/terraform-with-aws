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

//key pair
resource "aws_key_pair" "anhtaiht_auth" {
  key_name   = "anhtaihtkey"
  public_key = file("~/.ssh/anhtaihtkey.pub")
}
