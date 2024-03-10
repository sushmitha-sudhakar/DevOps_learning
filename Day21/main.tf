module "rds" {
    source = "./rds"

    kms_key          = var.kms_key
    kms_alias        = var.kms_alias
    rds_subnet_name  = var.rds_subnet_name
    rds_subnet1      = var.rds_subnet1
    rds_subnet2      = var.rds_subnet2
    rds_sg_name      = var.rds_sg_name
    vpc_id           = var.vpc_id
    engine           = var.engine
    engine_version   = var.engine_version
    db_instance      = var.db_instance
    db_name          = var.db_name
    db_username      = var.db_username
    retention_days   = var.retention_days
    payload          = var.payload
}