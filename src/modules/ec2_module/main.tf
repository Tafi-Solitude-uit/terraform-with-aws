//Public EC2 instance
resource "aws_instance" "public_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  security_groups = [var.public_ec2_sg]
  key_name        = var.key_name
  user_data       = file("userdata.tpl")

  ebs_optimized = true  # Bật EBS optimized
  monitoring = true  # Bật detailed monitoring

  metadata_options {
    http_tokens = "required"  # Yêu cầu sử dụng IMDSv2
    http_endpoint = "enabled"  # Bật endpoint metadata
  }

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "anhtaiht-Public-EC2-Instance"
  }

  // Provisioner to create ssh config file
  //command line các dòng dưới nếu tự động hóa quy trình với github actions
  # provisioner "local-exec" {
  #   command = templatefile("${var.host_os}-ssh-config.tpl", {
  #     hostname = self.public_ip,
  #     user = "ubuntu",
  #     identityfile = "~/.ssh/anhtaihtkey"
  #   })
  #   interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  # }
}

//Private EC2 instance
resource "aws_instance" "private_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  security_groups = [var.private_ec2_sg]
  key_name        = var.key_name
  user_data       = file("userdata.tpl")

  ebs_optimized = true  # Bật EBS optimized
  monitoring = true  # Bật detailed monitoring

  metadata_options {
    http_tokens = "required"         # Chỉ cho phép IMDSv2
    http_endpoint = "enabled"        # Bật endpoint metadata
  }

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "anhtaiht-Private-EC2-Instance"
  }
}