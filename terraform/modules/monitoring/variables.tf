variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "alarm_email" {
  description = "Email address for CloudWatch alarms"
  type        = string
}
