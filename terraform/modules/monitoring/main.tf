############################################
# SNS Topic
############################################

resource "aws_sns_topic" "alerts" {

  name = "${var.project_name}-${var.environment}-alerts"

}

############################################
# Email Subscription
############################################

resource "aws_sns_topic_subscription" "email" {

  topic_arn = aws_sns_topic.alerts.arn

  protocol = "email"

  endpoint = var.alarm_email

}

############################################
# CPU Alarm
############################################

resource "aws_cloudwatch_metric_alarm" "cpu_high" {

  alarm_name = "${var.project_name}-${var.environment}-cpu-high"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/ECS"

  period = 60

  statistic = "Average"

  threshold = 80

  alarm_description = "CPU utilization is above 80%"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  dimensions = {

    ClusterName = var.cluster_name

    ServiceName = var.service_name

  }

}

############################################
# Memory Alarm
############################################

resource "aws_cloudwatch_metric_alarm" "memory_high" {

  alarm_name = "${var.project_name}-${var.environment}-memory-high"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "MemoryUtilization"

  namespace = "AWS/ECS"

  period = 60

  statistic = "Average"

  threshold = 80

  alarm_description = "Memory utilization is above 80%"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  dimensions = {

    ClusterName = var.cluster_name

    ServiceName = var.service_name

  }

}

############################################
# Running Tasks Alarm
############################################

resource "aws_cloudwatch_metric_alarm" "running_tasks" {

  alarm_name = "${var.project_name}-${var.environment}-running-tasks"

  comparison_operator = "LessThanThreshold"

  evaluation_periods = 2

  metric_name = "RunningTaskCount"

  namespace = "ECS/ContainerInsights"

  period = 60

  statistic = "Average"

  threshold = 1

  alarm_description = "Running task count dropped below 1"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  dimensions = {

    ClusterName = var.cluster_name

    ServiceName = var.service_name

  }

}

############################################
# CloudWatch Dashboard
############################################

resource "aws_cloudwatch_dashboard" "ecs" {

  dashboard_name = "${var.project_name}-${var.environment}-dashboard"

  dashboard_body = jsonencode({

    widgets = [

      {

        type = "metric"

        width = 12

        height = 6

        properties = {

          title = "ECS CPU"

          view = "timeSeries"

          region = "ap-south-1"

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              var.cluster_name,
              "ServiceName",
              var.service_name
            ]
          ]

        }

      },

      {

        type = "metric"

        width = 12

        height = 6

        properties = {

          title = "ECS Memory"

          view = "timeSeries"

          region = "ap-south-1"

          metrics = [
            [
              "AWS/ECS",
              "MemoryUtilization",
              "ClusterName",
              var.cluster_name,
              "ServiceName",
              var.service_name
            ]
          ]

        }

      }

    ]

  })

}
