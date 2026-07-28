module "networking" {
  source = "./modules/networking"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

module "security" {

  source = "./modules/security"

  vpc_id       = module.networking.vpc_id

  project_name = var.project_name

  environment  = var.environment

}

module "ecr" {

  source = "./modules/ecr"

  repository_name = "${var.project_name}-${var.environment}"

  project_name = var.project_name

  environment = var.environment

}


module "ecs" {

  source = "./modules/ecs"

  project_name = var.project_name

  environment = var.environment

  cluster_name = "${var.project_name}-${var.environment}"

  container_name = var.container_name

  container_port = var.container_port

  task_cpu = var.task_cpu

  task_memory = var.task_memory

  execution_role_arn = module.security.ecs_execution_role_arn

  task_role_arn = module.security.ecs_task_role_arn

  repository_url = module.ecr.repository_url

  image_tag = var.image_tag

  log_retention_days = var.log_retention_days

}



module "alb" {

  source = "./modules/alb"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.networking.vpc_id

  subnet_ids = module.networking.public_subnet_ids

  security_group = module.security.alb_security_group

  container_port = var.container_port

  health_check_path = var.health_check_path

}



module "monitoring" {

  source = "./modules/monitoring"

  cluster_name = "${var.project_name}-${var.environment}"

}

module "autoscaling" {

  source = "./modules/autoscaling"

  cluster_name = module.ecs.cluster_name

  service_name = module.ecs.service_name

  min_capacity = var.min_capacity

  max_capacity = var.max_capacity

}
