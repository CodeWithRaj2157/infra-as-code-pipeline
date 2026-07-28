variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "infra-as-code-pipeline"
}

variable "environment" {
  description = "Environment"
  type        = string
}
