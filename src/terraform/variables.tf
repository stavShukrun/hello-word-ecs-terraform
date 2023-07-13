variable "name" {
  type = string
  default = "stav-hello-world"
}

variable "ecr_repository_url" {
  type = string
  default = "753392824297.dkr.ecr.us-east-1.amazonaws.com/stav-hello-world"
}

variable "release_version" {
  type = string
  default = "1.0.19"
}

variable "ecs_task_execution_role" {
  type = string
  default = "arn:aws:iam::753392824297:role/ecsTaskExecutionRole"
}

variable "ecs_auto_scale_role" {
  type = string
  default = "arn:aws:iam::753392824297:role/ecsAutoscaleRole"
}
locals {
    ###### GLOBAL PARAMS
    aws_region = "us-east-1"

    ###### VPC CIDR

    vpc_cidr = "10.0.0.0/16"
    vpc_tags = {
        Name = "${var.name}-vpc"
    }

  ###### SUBNET PARAMS
  subnet_aws_region = "us-east-1"

  subnets = [
    {
      availability_zone = "${local.aws_region}a"
      is_public = true
      tags = {
    "Name"                            = "stav-public-1"
  }
    },
    {
      availability_zone = "${local.aws_region}a"
      is_public = false
      tags = {
    "Name"                            = "stav-private-1"
  }
    },
    {
      availability_zone = "${local.aws_region}b"
      is_public = true
      tags = {
    "Name"                            = "stav-public-2"
  }
    },
  {
      availability_zone = "${local.aws_region}b"
      is_public = false
      tags = {
    "Name"                            = "stav-private-2"
  }
  }
  ]
 ##### SECURITY GROUP
 app_port = "3000"
}