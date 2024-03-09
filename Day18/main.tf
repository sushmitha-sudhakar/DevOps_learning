module "vpc_networking" {
  source        = "/Users/sushmithaks/Documents/Github_Repositories/100-days-of-devops/Day16/vpc_networking"

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

module "ec2_instance" {
  source        = "/Users/sushmithaks/Documents/Github_Repositories/100-days-of-devops/Day17/ec2_instance"

  key_name           = var.key_name
  public_key         = var.public_key
  instance_count     = var.instance_count
  instance_type      = var.instance_type
  security_group_ids = [module.vpc_networking.security_group]
  subnet_mask        = module.vpc_networking.public_subnets
  instance_name      = var.instance_name

}

module "sns" {
  source        = "./sns"

  alarm_topic  = var.alarm_topic
  alarms_email = var.alarms_email    
}

module "cloudwatch" {
  source        = "./cloudwatch"

  alarm_count          = length(module.ec2_instance.id)
  cpu_alarm_name       = var.cpu_alarm_name
  instance_alarm_name  = var.instance_alarm_name
  alarm_actions        = [module.sns.arn]
  instance_id          = module.ec2_instance.id
}
