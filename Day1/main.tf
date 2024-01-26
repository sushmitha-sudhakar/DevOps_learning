data "aws_instance" "test_ec2" {
  instance_id = var.instance_id

  # filter {
  #   name   = "tag:Name"
  #   values = ["instance-name-tag"]
  # }
}

data "aws_sns_topic" "test_topic" {
  name = var.sns_topic
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name                = var.alarm_name
  comparison_operator       = var.c_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic
  threshold                 = var.threshold
  alarm_description         = var.alarm_description
  alarm_actions             = [ "${data.aws_sns_topic.test_topic.arn}" ]
  dimensions                = {
    InstanceId = "${data.aws_instance.test_ec2.id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "instance-health-check" {
  alarm_name                = var.status_alarm_name
  comparison_operator       = var.c_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.status_alarm_metric
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic
  threshold                 = var.status_alarm_threshold
  alarm_description         = var.status_alarm_description
  alarm_actions             = [ "${data.aws_sns_topic.test_topic.arn}" ]
  dimensions                = {
    InstanceId = "${data.aws_instance.test_ec2.id}"
  }
}