resource "aws_internet_gateway" "anhtaiht_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Lab01-igw"
  }
}