variable "key_name" {}

variable "public_key" {}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group_ids" {
    type = list
}

variable "subnet_mask" {}

variable "instance_name" {}