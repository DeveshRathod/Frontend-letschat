# --------------------------------------------------------------------------------------------------------
# Cloud watch log groups
# --------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.ecs_log_group_name
  retention_in_days = var.ecs_log_retention_days
}

# --------------------------------------------------------------------------------------------------------
# Task definition
# --------------------------------------------------------------------------------------------------------
resource "aws_ecs_task_definition" "ecs" {
  family                   = var.ecs_name
  network_mode             = var.ecs_network_mode
  requires_compatibilities = var.ecs_requires_compatibilities
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory

  execution_role_arn = var.ecs_task_role_arn
  task_role_arn      = var.ecs_task_role_arn

  runtime_platform {
    operating_system_family = var.ecs_os_family
    cpu_architecture        = var.ecs_cpu_arch
  }

  container_definitions = jsonencode([
    {
      name      = var.ecs_name
      image     = var.ecs_frontend_image
      essential = true

      portMappings = [
        {
          containerPort = var.ecs_container_port
          hostPort      = var.ecs_container_port
        }
      ]

      environment = [
        {
          name  = "BACKEND_HOST"
          value = "${var.ecs_backend_service_discovery_name}.${var.ecs_namespace_name}:${var.ecs_backend_port}"
        }
      ]

      healthCheck = {
        command     = var.healthcheck_command
        interval    = var.healthcheck_interval
        timeout     = var.healthcheck_timeout
        retries     = var.healthcheck_retries
        startPeriod = var.healthcheck_start_period
      }

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.ecs_log_group_name
          "awslogs-region"        = var.ecs_region
          "awslogs-stream-prefix" = var.ecs_log_stream_prefix
        }
      }
    }
  ])
}
