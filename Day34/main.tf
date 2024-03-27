# Query all avilable Availibility Zone
data "aws_availability_zones" "available" {}

# To get the latest Centos7 AMI
data "aws_ami" "ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240223.0-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "test-key" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}

resource "aws_instance" "test_instance" {
  count                  = var.instance_count
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.test-key.id
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = element(var.subnet_mask, count.index)
  user_data              = data.template_file.user-init.rendered

  tags = {
    Name = "${var.instance_name}.${count.index + 1}"
  }
}