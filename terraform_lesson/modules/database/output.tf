output "db_ip" {
  value = [aws_instance.db_terraform.*.public_ip, aws_instance.db_terraform.*.private_ip]
}

output "instance_id" {
  value = aws_instance.db_terraform.id
}
