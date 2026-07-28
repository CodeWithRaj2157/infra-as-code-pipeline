variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "security_group" {
  description = "ALB Security Group"
  type        = string
}

variable "container_port" {
  description = "Application Port"
  type        = number
  default     = 3000
}

variable "health_check_path" {
  description = "Health Check Path"
  type        = string
  default     = "/health"
}
