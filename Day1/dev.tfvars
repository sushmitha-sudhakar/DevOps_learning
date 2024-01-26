region = "ap-south-1"

instance_id = "i-036869f6a45bfa033"

sns_topic = "cloudwatch_cli_topic"

alarm_name = "high-cpu-utilization-alarm"

c_operator = "GreaterThanOrEqualToThreshold"

evaluation_periods = "2"

metric_name = "CPUUtilization"

namespace = "AWS/EC2"

period = "300"

statistic = "Average"

threshold = "30"

status_alarm_name = "instance-health-check"

status_alarm_metric = "StatusCheckFailed"

status_alarm_threshold = "1"