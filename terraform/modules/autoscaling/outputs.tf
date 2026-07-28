output "autoscaling_target_id" {
  value = aws_appautoscaling_target.ecs.id
}

output "cpu_policy_arn" {
  value = aws_appautoscaling_policy.cpu.arn
}

output "memory_policy_arn" {
  value = aws_appautoscaling_policy.memory.arn
}
