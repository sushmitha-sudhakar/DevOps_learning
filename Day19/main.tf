module "lb" {
  source = "./application_lb"

  lb_name            = var.lb_name
  load_balancer_type = var.load_balancer_type
  subnet_id1         = var.subnet_id1
  subnet_id2         = var.subnet_id2
  target_group_name  = var.target_group_name
  vpc_id             = var.vpc_id
  target_type        = var.target_type
  instance_id1       = var.instance_id1
  instance_id2       = var.instance_id2
  lg_sg_name         = var.lg_sg_name
}