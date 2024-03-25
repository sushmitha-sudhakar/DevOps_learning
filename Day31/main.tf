resource "aws_vpc_peering_connection" "vpc" {
  peer_vpc_id = var.secondary_vpc_id
  vpc_id      = var.primary_vpc_id
  auto_accept = true

  tags = {
    Name = var.vpc_peering_name
  }
}

resource "aws_route" "vpc1-to-vpc2" {
  route_table_id            = var.vpc1_route_id
  destination_cidr_block    = var.vpc2_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc.id
}

resource "aws_route" "vpc2-to-vpc1" {
  route_table_id            = var.vpc2_route_id
  destination_cidr_block    = var.vpc1_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc.id
}