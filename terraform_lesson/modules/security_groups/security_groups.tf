resource "aws_security_group" "app_sg" {
  name        = "eng74-hubert-terraform-app"
  description = "Main Security Group for the app instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH accesses from home"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eng74-hubert-terraform-app-sg"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "eng74-hubert-terraform-db"
  description = "Main Security Group for the db instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "MongoDB Access"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["160.100.100.0/24"]
  }

  ingress {
    description = "SSH For the App Instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["160.100.100.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eng74-hubert-terraform-db-sg"
  }
}
