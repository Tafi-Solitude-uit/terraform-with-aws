resource "aws_vpc" "anhtaiht_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Lab01-vpc"
  }
}