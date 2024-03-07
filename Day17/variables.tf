variable "region" {}

variable "key_name" {}

variable "public_key" {}

variable "instance_count" {}

variable "instance_type" {}

variable "instance_name" {} 

variable "vpc_name" {}

variable "vpc_cidr" {}

variable "internet_gateway_name" {}

variable "public_route_name" {}

variable "private_route_name" {}

variable "public_cidrs" {
   type = list
}

variable "public_subnet_name" {}

variable "private_cidrs" {
    type = list
}

variable "private_subnet_name" {}

variable "sg_name" {}