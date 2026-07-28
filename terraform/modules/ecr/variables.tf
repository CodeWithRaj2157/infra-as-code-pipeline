variable "repository_name" {
  description = "ECR Repository Name"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning"
  type        = bool
  default     = true
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
