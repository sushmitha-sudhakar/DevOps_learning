variable "region" {}

variable "key_name" {}

variable "public_key" {}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group_ids" {
  type = list(any)
}

variable "subnet_mask" {
  type = list(any)
}

variable "instance_name" {}

variable "access_key" {}

variable "secret_key" {}