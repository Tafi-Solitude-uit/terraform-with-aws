//Public EC2 instance
resource "aws_instance" "public_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  security_groups = [var.public_ec2_sg]
  key_name        = var.key_name
  user_data       = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "anhtaiht-Public-EC2-Instance"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname = self.public_ip,
      user = "ubuntu",
      identityfile = "~/.ssh/anhtaihtkey"
    })
    interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  }
}

//Private EC2 instance
resource "aws_instance" "private_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  security_groups = [var.private_ec2_sg]
  key_name        = var.key_name
  user_data       = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "anhtaiht-Private-EC2-Instance"
  }
}