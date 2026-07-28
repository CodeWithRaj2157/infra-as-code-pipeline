variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "infra-as-code-pipeline"
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "container_port" {
  type    = number
  default = 3000
}

variable "desired_count" {
  type    = number
  default = 2
}

variable "max_capacity" {
  type    = number
  default = 6
}

variable "min_capacity" {
  type    = number
  default = 2
}

############################################
# ECS Configuration
############################################

variable "container_name" {
  description = "Container Name"
  type        = string
  default     = "ecs-demo-app"
}

variable "task_cpu" {
  description = "CPU units for ECS task"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for ECS task"
  type        = number
  default     = 512
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

############################################
# ALB Health Check
############################################

variable "health_check_path" {
  description = "Health check endpoint"
  type        = string
  default     = "/health"
}

variable "health_check_interval" {
  description = "Health check interval"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Healthy threshold"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold"
  type        = number
  default     = 2
}

############################################
# CloudWatch
############################################

variable "log_retention_days" {
  description = "CloudWatch log retention"
  type        = number
  default     = 7
}

############################################
# Auto Scaling
############################################

variable "cpu_target" {
  description = "CPU utilization target"
  type        = number
  default     = 70
}

variable "memory_target" {
  description = "Memory utilization target"
  type        = number
  default     = 75
}


