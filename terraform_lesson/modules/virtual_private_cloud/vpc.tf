resource "aws_vpc" "terraform_vpc" {
  cidr_block       = "160.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "eng74-hubert-terraform-vpc"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "eng74-hubert-terraform-igw"
  }
}
