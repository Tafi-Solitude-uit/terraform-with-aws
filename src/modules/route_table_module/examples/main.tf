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

//Public route Table
resource "aws_route_table" "anhtaiht_public_rt" {
  vpc_id = "vpc-12345678"

  tags = {
    Name = "Lab01-public-rt"
  }
}

//default route for public route table
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.anhtaiht_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-01c400db07aecee06"
}

//Associate public subnet with public route table
resource "aws_route_table_association" "anhtaiht_public_subnet_association" {
  subnet_id      = "subnet-0d0f1509ea63cdb70"
  route_table_id = aws_route_table.anhtaiht_public_rt.id
}

// Private Route Table
resource "aws_route_table" "anhtaiht_private_rt" {
  vpc_id = "vpc-12345678"

  tags = {
    Name = "Lab01-private-rt"
  }
}

// Default route for Private Route Table
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.anhtaiht_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "nat-01d1e5d02dfd9525d"
}

// Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "anhtaiht_private_subnet_association" {
  subnet_id      = "subnet-0fc6ad9acb3c13d47"
  route_table_id = aws_route_table.anhtaiht_private_rt.id
}