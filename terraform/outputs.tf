output "vpc_id" {
  value = module.networking.vpc_id
}

output "ecs_cluster" {
  value = module.ecs.cluster_name
}

output "ecr_repository" {
  value = module.ecr.repository_url
}

output "alb_dns" {
  value = module.alb.alb_dns_name
}
