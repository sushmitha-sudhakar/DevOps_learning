data "aws_route_table" "default" {
  vpc_id = var.vpc_id
}

#Adding Elastic IP for NAT gateway
resource "aws_eip" "eip" {
   domain   = "vpc"
}

#Adding NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.subnet_id
}

# Private Route Table
resource "aws_default_route_table" "private_route" {
  default_route_table_id = data.aws_route_table.default.id
  route {
    nat_gateway_id = aws_nat_gateway.nat_gw.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = var.private_route_name
  }
}