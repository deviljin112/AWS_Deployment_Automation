output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.terraform_igw.id
}
