variable "region" {}

variable "instance_id" {}

variable "sns_topic" {}

variable "alarm_name" {}

variable "c_operator" {}

variable "metric_name" {}

variable "namespace" {}

variable "evaluation_periods" {}

variable "period" {}

variable "statistic" {}

variable "threshold" {}

variable "alarm_description" {
    default = "This metric monitors ec2 cpu utilization"
}

variable "status_alarm_description" {
    default = "This metric monitors ec2 health status"
}

variable "status_alarm_name" {}

variable "status_alarm_metric" {}

variable "status_alarm_threshold" {}
