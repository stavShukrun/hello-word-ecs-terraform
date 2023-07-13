module "vpc" {
  source                    = "./modules/vpc"
  vpc_cidr                  = local.vpc_cidr 
  vpc_tags                  = local.vpc_tags
}

module "subnets" {
  source                    = "./modules/subnets"
  vpc_id                    = module.vpc.vpc_id
  vpc_cidr                  = local.vpc_cidr 
  subnets                   = local.subnets
  depends_on                = [module.vpc]
}

module "igw" {
  source                    = "./modules/igw"
  vpc_id                    = module.vpc.vpc_id
  subnets_public_ids        = module.subnets.subnets_public
  depends_on                = [module.subnets]
}

module "route_table" {
  source                    = "./modules/route_table"
  vpc_id                    = module.vpc.vpc_id
  igw_id                    = module.igw.igw_id
  nat_id                    = module.igw.nat_id
  depends_on                = [module.vpc,module.igw]
}

module "route_table_association" {
  source                    = "./modules/route_table_association"
  subnets_public_ids        = module.subnets.subnets_public
  subnets_private_ids       = module.subnets.subnets_private
  route_table_ids           = module.route_table
  depends_on                = [module.route_table, module.subnets]
}

module "security_group" {
  source                    = "./modules/security_group"
  vpc_id                    = module.vpc.vpc_id
  security_group_name       = "${var.name}-lb-sg"
  tasks_security_group_name = "${var.name}-tasks-sg"
  app_port                  = local.app_port
  depends_on                = [module.vpc]
}

module "alb" {
  source                    = "./modules/alb"
  alb_name                  = "${var.name}-alb"
  alb_target_group_name     = "${var.name}-tg"
  subnets_public_ids        = module.subnets.subnets_public
  load_balancer_sg_id       = module.security_group.load_balancer_sg_id
  vpc_id                    = module.vpc.vpc_id
  app_port                  = local.app_port
  depends_on                = [module.security_group] 
}

module "cloudwatch_log" {
  source                    = "./modules/cloudwatch_log"
  depends_on                = [ module.alb ]
}

module "ecs" {
  source                    = "./modules/ecs"
  ecs_cluster_name          = "${var.name}-cluster"
  ecs_service_name        = "${var.name}-service"
  aws_region                = local.aws_region
  ecr_repository_url        = var.ecr_repository_url
  release_version           = var.release_version
  app_port                  = local.app_port
  ecs_task_execution_role   = var.ecs_task_execution_role
  alb_target_group_arn      = module.alb.alb_target_group_arn
  load_balancer_sg_id       = module.security_group.load_balancer_sg_id
  ecs_tasks_sg_id           = module.security_group.ecs_tasks_sg_id
  subnets_private_ids       = module.subnets.subnets_private
  log_group_id              = module.cloudwatch_log.log_group_id
  depends_on                = [ module.alb ]
}

module "auto_scaling" {
  source                    = "./modules/auto_scaling"
  ecs_cluster_name          = module.ecs.ecs_cluster_name
  ecs_service_name          = module.ecs.ecs_service_name
  ecs_auto_scale_role       = var.ecs_auto_scale_role
  depends_on                = [ module.ecs ]
}