variable "vpc_id" {
  type        = string
  description = "The Id of the VPC"
}

variable "igw_id" {
  type        = string
  description = "The Id of the Internet Gateway"
}

variable "nat_gw_id" {
  type        = string
  description = "The Id of the NAT Gateway"
}

variable "public_subnet_id" {
  type        = string
  description = "The Id of the public subnet" 
}

variable "private_subnet_id" {
  type        = string
  description = "The Id of the private subnet"
}
