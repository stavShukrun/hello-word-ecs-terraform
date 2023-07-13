variable "alb_target_group_arn" {
    type = string
}

variable "ecs_cluster_name" {
    type = string
}

variable "aws_region" {
    type = string
}

variable "ecs_service_name" {
    type = string
}

variable "ecr_repository_url" {
    type = string
}

variable "release_version" {
    type = string
}

variable "app_port" {
    type = string
}

variable "ecs_task_execution_role" {
    type = string
}

variable "ecs_tasks_sg_id" {
    type = string
}

variable "load_balancer_sg_id" {
    type = string
}

variable "subnets_private_ids" {
  type = list(string)
}

variable "log_group_id" {
    type = string
}