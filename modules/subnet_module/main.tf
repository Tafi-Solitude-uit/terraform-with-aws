//public subnet
resource "aws_subnet" "anhtaiht_public_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidr

  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Lab01-public-subnet"
  }
}

//private subnet
resource "aws_subnet" "anhtaiht_private_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnet_cidr

  availability_zone = "us-east-1a"

  tags = {
    Name = "Lab01-private-subnet"
  }
}