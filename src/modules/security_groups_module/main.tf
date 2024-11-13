// Default Security Group
resource "aws_security_group" "anhtaiht_default_sg" {
  vpc_id      = var.vpc_id
  name        = "default-sg-VPC"
  description = "Default security group for VPC"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "default-security-group-anhtaiht"
  }
}

// Public EC2 security group
resource "aws_security_group" "anhtaiht_public_sg" {
  vpc_id      = var.vpc_id
  name = "Public-EC2-SG"
  description = "Allow SSH from a specific IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
    description = "Allow SSH access from specific IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "public-security-group-anhtaiht"
  }
}

// Private EC2 security group
resource "aws_security_group" "anhtaiht_private_sg" {
  vpc_id      = var.vpc_id
  name = "Private-EC2-SG"
  description = "Allow SSH from the public EC2 instance"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.anhtaiht_public_sg.id]
    description     = "Allow SSH access from the public EC2 instance"
    
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "private-security-group-anhtaiht"
  }
}