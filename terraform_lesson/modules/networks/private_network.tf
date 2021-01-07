resource "aws_subnet" "subnet_private" {
  vpc_id     = var.vpc_id
  cidr_block = "160.100.0.0/24"

  tags = {
    Name = "eng74-hubert-terraform-subnet-private"
  }
}

resource "aws_route_table" "route_table_private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "eng74-hubert-terraform-private-route"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_network_acl" "private_nacl" {
  vpc_id     = var.vpc_id
  subnet_ids = [aws_subnet.subnet_private.id]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "160.100.100.0/24"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "160.100.100.0/24"
    from_port  = 27017
    to_port    = 27017
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "160.100.100.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "eng74-hubert-terraform-private-nacl"
  }
}
