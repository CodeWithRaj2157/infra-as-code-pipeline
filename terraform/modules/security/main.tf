############################################
# ALB Security Group
############################################

resource "aws_security_group" "alb" {

  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.project_name}-${var.environment}-alb-sg"
  }

}

############################################
# ECS Security Group
############################################

resource "aws_security_group" "ecs" {

  name        = "${var.project_name}-${var.environment}-ecs-sg"
  description = "ECS Security Group"
  vpc_id      = var.vpc_id

  ingress {

    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]

  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.project_name}-${var.environment}-ecs-sg"
  }

}

############################################
# ECS Task Execution Role
############################################

resource "aws_iam_role" "ecs_execution_role" {

  name = "${var.project_name}-${var.environment}-ecs-execution-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Action = "sts:AssumeRole"

        Effect = "Allow"

        Principal = {

          Service = "ecs-tasks.amazonaws.com"

        }

      }

    ]

  })

}

############################################
# ECS Task Role
############################################

resource "aws_iam_role" "ecs_task_role" {

  name = "${var.project_name}-${var.environment}-ecs-task-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Action = "sts:AssumeRole"

        Effect = "Allow"

        Principal = {

          Service = "ecs-tasks.amazonaws.com"

        }

      }

    ]

  })

}

############################################
# Attach ECS Execution Policy
############################################

resource "aws_iam_role_policy_attachment" "ecs_execution" {

  role = aws_iam_role.ecs_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}

############################################
# CloudWatch Logs Policy
############################################

resource "aws_iam_role_policy_attachment" "cloudwatch" {

  role = aws_iam_role.ecs_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"

}

############################################
# ECR Read Only Policy
############################################

resource "aws_iam_role_policy_attachment" "ecr" {

  role = aws_iam_role.ecs_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}
