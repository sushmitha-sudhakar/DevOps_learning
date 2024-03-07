resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name   = var.keypair_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "aws_security_group" "sg" {
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  ami                    = var.ami_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.keypair.id
  tags =  {
    Name = "test-ec2-instance"
  }
}