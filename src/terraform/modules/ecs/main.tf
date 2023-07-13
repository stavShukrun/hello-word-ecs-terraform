resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "hello" {
  family = "hello-world"
  execution_role_arn = var.ecs_task_execution_role
  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.ecs_service_name}",
      "image": "${var.ecr_repository_url}:${var.release_version}",
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.log_group_id}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "${var.ecs_cluster_name}"
        }
      },

      "portMappings": [
        {
          "containerPort": ${var.app_port}
        }
      ]
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"
  cpu          = "256"
  memory       = "512"
}

resource "aws_ecs_service" "hello" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.hello.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.ecs_service_name
    container_port   = var.app_port
  }

  network_configuration {
    subnets          = var.subnets_private_ids
    security_groups  = [var.ecs_tasks_sg_id, var.load_balancer_sg_id]
  }
}