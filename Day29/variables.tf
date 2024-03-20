variable "region" {}

variable "storage_type" {}

variable "allocated_storage" {}

variable "engine" {}

variable "engine_version" {}

variable "db_instance" {}

variable "db_name" {}

variable "username" {}

variable "parameter_group" {}

variable "subnet_group_name" {}

variable "subnet_ids" {
    type = list
}

variable "rds_sg_name" {}

variable "vpc_id" {}