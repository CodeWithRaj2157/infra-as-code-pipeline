############################################
# ECS Auto Scaling Target
############################################

resource "aws_appautoscaling_target" "ecs" {

  max_capacity = var.max_capacity
  min_capacity = var.min_capacity

  resource_id = "service/${var.cluster_name}/${var.service_name}"

  scalable_dimension = "ecs:service:DesiredCount"

  service_namespace = "ecs"
}

############################################
# CPU Scaling Policy
############################################

resource "aws_appautoscaling_policy" "cpu" {

  name = "${var.service_name}-cpu-scaling"

  policy_type = "TargetTrackingScaling"

  resource_id = aws_appautoscaling_target.ecs.resource_id

  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension

  service_namespace = aws_appautoscaling_target.ecs.service_namespace

  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {

      predefined_metric_type = "ECSServiceAverageCPUUtilization"

    }

    target_value = var.cpu_target

    scale_in_cooldown = 60

    scale_out_cooldown = 60

  }

}

############################################
# Memory Scaling Policy
############################################

resource "aws_appautoscaling_policy" "memory" {

  name = "${var.service_name}-memory-scaling"

  policy_type = "TargetTrackingScaling"

  resource_id = aws_appautoscaling_target.ecs.resource_id

  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension

  service_namespace = aws_appautoscaling_target.ecs.service_namespace

  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {

      predefined_metric_type = "ECSServiceAverageMemoryUtilization"

    }

    target_value = var.memory_target

    scale_in_cooldown = 60

    scale_out_cooldown = 60

  }

}
