variable "ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "The id of the key pair"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet ID for the public EC2 instance"
  type        = string
}

variable "private_subnet_id" {
  description = "Subnet ID for the private EC2 instance"
  type        = string
}

variable "public_ec2_sg" {
  description = "Security group for the public EC2 instance"
  type        = string
}

variable "private_ec2_sg" {
  description = "Security group for the private EC2 instance"
  type        = string
}

variable "host_os" {
  description = "The operating system of the host"
  type        = string
}