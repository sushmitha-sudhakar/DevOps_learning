resource "aws_kms_key" "rds-key" {
    description = "key to encrypt rds password"
  tags ={
    Name = var.kms_key
  }
}

resource "aws_kms_alias" "rds-kms-alias" {
  target_key_id = aws_kms_key.rds-key.id
  name          = var.kms_alias
}

data "aws_kms_secrets" "rds-secret" {
  secret {
    name    = "password"
    payload = var.payload
  }
}

resource "aws_db_subnet_group" "rds-private-subnet" {
  name       = var.rds_subnet_name
  subnet_ids = [var.rds_subnet1,var.rds_subnet2]
}

resource "aws_security_group" "rds-sg" {
  name   = var.rds_sg_name
  vpc_id = var.vpc_id
}

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds-sg.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "mysql" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.db_instance
  db_name                     = var.db_name
  username                    = var.db_username
  password                    = data.aws_kms_secrets.rds-secret.plaintext["password"]
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = aws_db_subnet_group.rds-private-subnet.name
  vpc_security_group_ids      = [aws_security_group.rds-sg.id]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = var.retention_days
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = true
  skip_final_snapshot         = true
}


