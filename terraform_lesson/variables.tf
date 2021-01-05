variable "region" {
  default = "eu-west-1"
}

variable "app_ami" {
  default = "ami-0a031f2f9ec273e4f"
}

variable "db_ami" {
  default = "ami-05399c20723d2acbd"
}

variable "ssh_key" {
  default = "eng74.hubert.aws.key"
}

variable "inst_type" {
  default = "t2.micro"
}
