module "vpc_networking" {
  source        = "./vpc_networking"
  
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  internet_gateway_name = var.internet_gateway_name
  public_route_name     = var.public_route_name
  private_route_name    = var.private_route_name
  public_cidrs          = var.public_cidrs
  public_subnet_name    = var.public_subnet_name
  private_cidrs         = var.private_cidrs
  private_subnet_name   = var.private_subnet_name
  sg_name               = var.sg_name

}