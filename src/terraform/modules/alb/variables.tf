variable "alb_name" {
    type = string
}

variable "alb_target_group_name" {
    type = string
}

variable "load_balancer_sg_id" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "app_port" {
    type = string
}

variable "subnets_public_ids" {
    type = list(string)
}