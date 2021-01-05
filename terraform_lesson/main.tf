provider "aws" {
  region = var.region
}

resource "aws_instance" "app_terraform" {
  ami                         = var.app_ami
  instance_type               = var.inst_type
  associate_public_ip_address = true
  tags = {
    Name = "Eng74-hubert-terraform-app"
  }
  key_name               = var.ssh_key
  security_groups        = ["Eng74-hubert-terraform-app"]
  vpc_security_group_ids = ["sg-041ca396643d159d5"]
}

resource "aws_instance" "db_terraform" {
  ami                         = var.db_ami
  instance_type               = var.inst_type
  associate_public_ip_address = false
  tags = {
    Name = "Eng74-hubert-terraform-db"
  }
  key_name        = var.ssh_key
  security_groups = ["Eng74-hubert-terraform-db"]
}

output "ip" {
  value = [aws_instance.app_terraform.*.public_ip, aws_instance.app_terraform.*.private_ip, aws_instance.db_terraform.*.public_ip, aws_instance.db_terraform.*.private_ip]
}
