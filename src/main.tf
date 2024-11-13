module "vpc_module" {
  source   = "./modules/vpc_module"
  vpc_cidr = "10.0.0.0/16"
}

module "ec2_module" {
  source            = "./modules/ec2_module"
  ami               = data.aws_ami.server_ami.id
  instance_type     = "t2.micro"
  public_subnet_id  = module.subnet_module.public_subnet_id
  private_subnet_id = module.subnet_module.private_subnet_id
  public_ec2_sg     = module.security_groups_module.public_security_group_id
  private_ec2_sg    = module.security_groups_module.private_security_group_id
  key_name          = module.key_pair_module.key_pair_id
  host_os           = "windows"
}

// Lấy địa chỉ public ip trên trang web dưới và gán giá trị vào allowed_ssh_ip trong module security_groups_module
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

module "security_groups_module" {
  source         = "./modules/security_groups_module"
  vpc_id         = module.vpc_module.vpc_id
  allowed_ssh_ip = format("%s/32", trimspace(data.http.my_ip.body))
}

module "igw_module" {
  source = "./modules/igw_module"
  vpc_id = module.vpc_module.vpc_id
}

module "route_table_module" {
  source            = "./modules/route_table_module"
  vpc_id            = module.vpc_module.vpc_id
  igw_id            = module.igw_module.igw_id
  nat_gw_id         = module.nat_gw_module.nat_gw_id
  public_subnet_id  = module.subnet_module.public_subnet_id
  private_subnet_id = module.subnet_module.private_subnet_id
}

module "subnet_module" {
  source              = "./modules/subnet_module"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  vpc_id              = module.vpc_module.vpc_id
}

module "nat_gw_module" {
  source            = "./modules/nat_gw_module"
  public_subnet_id = module.subnet_module.public_subnet_id
}

module "key_pair_module" {
  source = "./modules/key_pair_module"
}