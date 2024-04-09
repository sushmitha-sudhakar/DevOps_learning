resource "aws_vpc_endpoint" "ec2logs"{
  vpc_id            = var.vpc_id
  service_name      = var.service_name
  subnet_ids        = [var.subnet_id]
  vpc_endpoint_type = var.endpoint_type

  security_group_ids = [var.security_group]
  policy = <<POLICY
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
  private_dns_enabled = true
}