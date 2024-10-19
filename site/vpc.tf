resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name    = format("%s-vpc", var.f5xc_vsite_name)
    Creator = var.aws_owner_tag
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = format("%s-gw", var.f5xc_vsite_name)
    Creator = var.aws_owner_tag
  }
}

resource "aws_security_group" "allow_slo_traffic" {
  name        = "${var.f5xc_vsite_name}-allow-slo-traffic"
  description = "allow ssh traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = [ var.aws_vpc_cidr ]
  }

  ingress {
    from_port   = "4500"
    to_port     = "4500"
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = var.f5xc_vsite_name
    Creator = var.aws_owner_tag
  }
} 

resource "aws_security_group" "allow_sli_traffic" {
  name        = "${var.f5xc_vsite_name}-allow-sli-traffic"
  description = "allow all sli traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = var.f5xc_vsite_name
    Creator = var.aws_owner_tag
  }
} 

output "vpc" {
  value = resource.aws_vpc.vpc
}
output "internet_gateway" {
  value = resource.aws_internet_gateway.gateway
}
#output "route_table" {
#  value = resource.aws_route_table.rt
#}
output "security_group" {
  value = {
    slo = resource.aws_security_group.allow_slo_traffic
    sli = resource.aws_security_group.allow_sli_traffic
  }
}
