module "myip" {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

provider "aws" {
  region = var.region
}

module "db" {
  source = "./modules/database"

  db_ami         = var.db_ami
  inst_type      = var.inst_type
  ssh_key        = var.ssh_key
  private_subnet = module.networks.subnet_private_id
  db_sg          = module.sg.db_sg
}

module "app" {
  source = "./modules/application"

  app_ami       = var.app_ami
  inst_type     = var.inst_type
  ssh_key       = var.ssh_key
  ssh_file      = var.ssh_file
  app_sg        = module.sg.app_sg
  db_ip         = module.db.db_ip
  public_subnet = module.networks.subnet_public_id
}

module "networks" {
  source = "./modules/networks"

  my_ip  = module.myip.address
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
}

module "sg" {
  source = "./modules/security_groups"

  my_ip  = module.myip.address
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "./modules/virtual_private_cloud"
}
