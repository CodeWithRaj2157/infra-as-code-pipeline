output "vpc_id" {

  description = "ID of the VPC created for the infrastructure"

  value = module.networking.vpc_id

}


output "ecs_cluster" {

  description = "Name of the ECS cluster"

  value = module.ecs.cluster_name

}


output "ecr_repository" {

  description = "URL of the ECR repository used for Docker images"

  value = module.ecr.repository_url

}


output "alb_dns" {

  description = "DNS name of the Application Load Balancer"

  value = module.alb.alb_dns_name

}
