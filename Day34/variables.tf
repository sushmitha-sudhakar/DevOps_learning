variable "region" {}

variable "key_name" {}

variable "public_key" {}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group_ids" {
    type = list
}

variable "subnet_mask" {
    type = list
}

variable "instance_name" {}