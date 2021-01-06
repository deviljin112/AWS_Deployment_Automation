module "myip" {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "db_terraform" {
  ami                         = var.db_ami
  subnet_id                   = aws_subnet.subnet_private.id
  instance_type               = var.inst_type
  associate_public_ip_address = false
  tags = {
    Name = "Eng74-hubert-terraform-db"
  }
  key_name               = var.ssh_key
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

resource "aws_instance" "app_terraform" {
  ami                         = var.app_ami
  subnet_id                   = aws_subnet.subnet_public.id
  instance_type               = var.inst_type
  associate_public_ip_address = true
  tags = {
    Name = "Eng74-hubert-terraform-app"
  }
  key_name               = var.ssh_key
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  provisioner "remote-exec" {
    inline = [
      "export DB_HOST=${tostring(aws_instance.db_terraform.*.private_ip[0])}",
      "export IP=$(curl ifconfig.me)",
      "sudo sed -i \"s/server_name 1.1.1.1/server_name $IP/g\" /etc/nginx/nginx.conf",
      "sudo systemctl restart nginx",
      "cd /home/ubuntu/NodeJS_App/app",
      "pm2 start app.js",
      "npm run seed"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      password    = ""
      private_key = file(var.ssh_file)
      host        = self.public_ip
    }
  }

  depends_on = [aws_instance.db_terraform]
}

output "ip" {
  value = [aws_instance.app_terraform.*.public_ip, aws_instance.app_terraform.*.private_ip, aws_instance.db_terraform.*.public_ip, aws_instance.db_terraform.*.private_ip]
}
