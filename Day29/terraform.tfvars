region = "ap-south-1"

storage_type = "gp2"

allocated_storage = "20"

engine = "mysql"

engine_version = "5.7"

db_instance = "db.t3.micro"

db_name = "testmysqldb"

username = "admin"

parameter_group = "default.mysql5.7"

subnet_group_name = "dbmysql"

subnet_ids = ["subnet-0bddb510506ab51bb","subnet-097070aa1c6b97e07","subnet-05b9357c7b8ae45c7"]

rds_sg_name = "mysqlsg"

vpc_id = "vpc-0625bf573398c5261"