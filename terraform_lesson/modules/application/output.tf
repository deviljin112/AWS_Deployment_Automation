output "app_ip" {
  value = [aws_instance.app_terraform.*.public_ip, aws_instance.app_terraform.*.private_ip]
}

