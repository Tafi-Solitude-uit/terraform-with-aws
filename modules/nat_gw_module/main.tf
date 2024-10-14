//Elastic IP for NAT Gateway
resource "aws_eip" "anhtaiht_nat_eip" {
  domain = "vpc"
}

//NAT Gateway
resource "aws_nat_gateway" "anhtai_nat_gw" {
  allocation_id = aws_eip.anhtaiht_nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "Lab01-nat-gw"
  }
}