####################################
# CloudWatch Log Group
####################################

resource "aws_cloudwatch_log_group" "ecs" {

  name              = "/ecs/${var.cluster_name}"
  retention_in_days = var.log_retention_days

}

####################################
# ECS Cluster
####################################

resource "aws_ecs_cluster" "this" {

  name = var.cluster_name

  setting {

    name  = "containerInsights"

    value = "enabled"

  }

  tags = {

    Name = var.cluster_name

  }

}

####################################
# ECS Task Definition
####################################

resource "aws_ecs_task_definition" "this" {

  family = "${var.cluster_name}-task"

  network_mode = "awsvpc"

  requires_compatibilities = [
    "FARGATE"
  ]

  cpu = var.task_cpu

  memory = var.task_memory

  execution_role_arn = var.execution_role_arn

  task_role_arn = var.task_role_arn

  container_definitions = templatefile(
    "${path.module}/task-definition.json.tpl",
    {
      container_name = var.container_name
      image          = "${var.repository_url}:${var.image_tag}"
      container_port = var.container_port
      log_group      = aws_cloudwatch_log_group.ecs.name
      region         = "ap-south-1"
    }
  )

}
