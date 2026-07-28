variable "project_name" {

  description = "Name of the project"

  type = string

}


variable "environment" {

  description = "Deployment environment name"

  type = string

}


variable "aws_region" {

  description = "AWS region where resources will be created"

  type = string

}


variable "vpc_cidr" {

  description = "CIDR block for the VPC"

  type = string

}


variable "public_subnets" {

  description = "CIDR blocks for public subnets"

  type = list(string)

}


variable "private_subnets" {

  description = "CIDR blocks for private subnets"

  type = list(string)

}


variable "container_port" {

  description = "Port exposed by the application container"

  type = number

}


variable "desired_count" {

  description = "Desired number of ECS service tasks"

  type = number

}


variable "max_capacity" {

  description = "Maximum ECS service task capacity"

  type = number

}


variable "min_capacity" {

  description = "Minimum ECS service task capacity"

  type = number

}


variable "container_name" {

  description = "Name of the ECS container"

  type = string

}


variable "task_cpu" {

  description = "CPU units allocated to ECS task"

  type = number

}


variable "task_memory" {

  description = "Memory allocated to ECS task"

  type = number

}


variable "image_tag" {

  description = "Docker image tag"

  type = string

}


variable "health_check_path" {

  description = "Health check endpoint path"

  type = string

}


variable "log_retention_days" {

  description = "Number of days to retain CloudWatch logs"

  type = number

}


variable "cpu_target" {

  description = "CPU utilization target percentage for autoscaling"

  type = number

}


variable "memory_target" {

  description = "Memory utilization target percentage for autoscaling"

  type = number

}


variable "alarm_email" {

  description = "Email address for CloudWatch alarm notifications"

  type = string

}
