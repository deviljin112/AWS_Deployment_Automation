resource "aws_instance" "db_terraform" {
  ami                         = var.db_ami
  subnet_id                   = var.private_subnet
  instance_type               = var.inst_type
  associate_public_ip_address = false
  tags = {
    Name = "Eng74-hubert-terraform-db"
  }
  key_name               = var.ssh_key
  vpc_security_group_ids = [var.db_sg]
}
