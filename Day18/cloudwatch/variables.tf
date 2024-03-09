variable "cpu_alarm_name" {}

variable "cpu_alarm_description" {
   default = "This metric monitors ec2 cpu utilization"
}

variable "instance_alarm_name" {}

variable "instance_alarm_description" {
    default = "This metric monitors ec2 health status"
}

variable "alarm_actions" {
    type = list
}

variable "instance_id" {}

variable "alarm_count" {}