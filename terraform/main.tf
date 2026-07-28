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

  subnet_ids = module.networking.private_subnet_ids

  security_group_id = module.security.ecs_security_group

  target_group_arn = module.alb.target_group_arn

  desired_count = var.desired_count

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

  project_name = var.project_name

  environment = var.environment

  cluster_name = module.ecs.cluster_name

  service_name = module.ecs.service_name

  alarm_email = var.alarm_email

}



module "autoscaling" {

  source = "./modules/autoscaling"

  cluster_name = module.ecs.cluster_name

  service_name = module.ecs.service_name

  min_capacity = var.min_capacity

  max_capacity = var.max_capacity

  cpu_target = var.cpu_target

  memory_target = var.memory_target

}



