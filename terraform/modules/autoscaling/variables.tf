variable "cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of tasks"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of tasks"
  type        = number
}

variable "cpu_target" {
  description = "CPU target utilization percentage"
  type        = number
}

variable "memory_target" {
  description = "Memory target utilization percentage"
  type        = number
}
