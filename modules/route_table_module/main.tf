//Public route Table
resource "aws_route_table" "anhtaiht_public_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Lab01-public-rt"
  }
}

//default route for public route table
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.anhtaiht_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

//Associate public subnet with public route table
resource "aws_route_table_association" "anhtaiht_public_subnet_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.anhtaiht_public_rt.id
}

// Private Route Table
resource "aws_route_table" "anhtaiht_private_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Lab01-private-rt"
  }
}

// Default route for Private Route Table
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.anhtaiht_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gw_id
}

// Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "anhtaiht_private_subnet_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.anhtaiht_private_rt.id
}