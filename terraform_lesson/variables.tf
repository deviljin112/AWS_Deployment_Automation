variable "region" {
  default = "eu-west-1"
}

variable "app_ami" {
  default = "ami-01e59b8cbc8b86814"
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

variable "ssh_file" {
  default = "~/.ssh/eng74hubertawskey.pem"
}
