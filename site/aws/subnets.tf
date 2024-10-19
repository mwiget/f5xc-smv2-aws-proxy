resource "aws_subnet" "slo" {
  count                   = 1
  vpc_id                  = var.aws_vpc_id
  cidr_block              = var.aws_slo_subnet
  map_public_ip_on_launch = false
  availability_zone       = format("%s%s", var.aws_region, var.aws_availability_zone)
  tags                    = {
    Name    = format("%s-slo-%s", var.f5xc_virtual_site, var.aws_availability_zone)
    Creator = var.aws_owner_tag
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "sli" {
  count                   = 1
  vpc_id                  = var.aws_vpc_id
  cidr_block              = var.aws_sli_subnet
  map_public_ip_on_launch = false
  availability_zone       = format("%s%s", var.aws_region, var.aws_availability_zone)
  tags                    = {
    Name    = format("%s-sli-%s", var.f5xc_virtual_site, var.aws_availability_zone)
    Creator = var.aws_owner_tag
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.aws_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.aws_internet_gateway_id 
  }

  #  route {
  #    cidr_block           = "10.0.0.0/8"
  #    network_interface_id = aws_network_interface.sm_sli_eni[0].id
  #  }

  tags = {
    Name = var.f5xc_virtual_site
    Creator = var.aws_owner_tag
  }
}

resource "aws_route_table_association" "pub_subnet_rt_join" {
 count          = 1
 subnet_id      = element(aws_subnet.slo[*].id, count.index)
 route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_subnet_rt_join_sli" {
 count          = 1
 subnet_id      = element(aws_subnet.sli[*].id, count.index)
 route_table_id = aws_route_table.public_rt.id
}
