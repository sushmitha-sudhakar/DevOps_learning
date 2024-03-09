resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  ip_address_type    = "ipv4"
  subnets            = ["${var.subnet_id1}", "${var.subnet_id2}"]

  enable_deletion_protection = false

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "lb-tg" {
  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = var.target_type
}

resource "aws_lb_target_group_attachment" "tg-attachment1" {
  target_group_arn = "${aws_lb_target_group.lb-tg.arn}"
  target_id        = "${var.instance_id1}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg-attachment2" {
  target_group_arn = "${aws_lb_target_group.lb-tg.arn}"
  target_id        = "${var.instance_id2}"
  port             = 80
}

resource "aws_security_group" "lb-sg" {
  name   = var.lg_sg_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "http_allow" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.lb-sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "all_outbound_access" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.lb-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}