resource "aws_instance" "app_terraform" {
  ami                         = var.app_ami
  subnet_id                   = var.public_subnet
  instance_type               = var.inst_type
  associate_public_ip_address = true
  tags = {
    Name = "Eng74-hubert-terraform-app"
  }
  key_name               = var.ssh_key
  vpc_security_group_ids = [var.app_sg]

  provisioner "remote-exec" {
    inline = [
      "export DB_HOST=${tostring(var.db_ip[1][0])}",
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
}
