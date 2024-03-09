resource "aws_cloudwatch_metric_alarm" "cpu-utilization" {
  count                     = var.alarm_count
  alarm_name                = var.cpu_alarm_name
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = var.cpu_alarm_description
  alarm_actions             = var.alarm_actions
  dimensions = {
    InstanceId = element(var.instance_id, count.index)
  }
}

resource "aws_cloudwatch_metric_alarm" "instance-health-check" {
  count                     = var.alarm_count
  alarm_name                = var.instance_alarm_name
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "1"
  alarm_description         = var.instance_alarm_description
  alarm_actions             = var.alarm_actions
  dimensions = {
    InstanceId = element(var.instance_id, count.index)
  }
}