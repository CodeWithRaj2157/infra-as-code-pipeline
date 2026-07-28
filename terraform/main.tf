module "networking" {

  source = "./modules/networking"

  project_name    = var.project_name
  environment     = var.environment

  vpc_cidr        = var.vpc_cidr

  public_subnets  = var.public_subnets

  private_subnets = var.private_subnets

}

module "security" {

  source = "./modules/security"

  vpc_id = module.networking.vpc_id

}

module "ecr" {

  source = "./modules/ecr"

  repository_name = "${var.project_name}-${var.environment}"

}

module "ecs" {

  source = "./modules/ecs"

  cluster_name = "${var.project_name}-${var.environment}"

  subnet_ids = module.networking.private_subnet_ids

  security_group_id = module.security.ecs_security_group

  target_group_arn = module.alb.target_group_arn

  container_port = var.container_port

  desired_count = var.desired_count

}

module "alb" {

  source = "./modules/alb"

  subnet_ids = module.networking.public_subnet_ids

  security_group = module.security.alb_security_group

  vpc_id = module.networking.vpc_id

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
