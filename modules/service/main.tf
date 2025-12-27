# --------------------------------------------------------------------------------------------------------
# Load Balancer
# --------------------------------------------------------------------------------------------------------
resource "aws_lb" "frontend" {
  name               = var.service_lb_name
  internal           = var.service_lb_internal
  load_balancer_type = var.service_lb_type
  security_groups    = var.service_lb_sgs
  subnets            = var.service_lb_psubnets
}

# --------------------------------------------------------------------------------------------------------
# Target Group
# --------------------------------------------------------------------------------------------------------
resource "aws_lb_target_group" "frontend" {
  name        = var.service_tg_name
  port        = var.service_tg_port
  protocol    = var.service_tg_protocol
  vpc_id      = var.service_tg_vpc_id
  target_type = var.service_tg_target_type

  health_check {
    path                = var.service_hc_path
    protocol            = var.service_hc_protocol
    matcher             = var.service_hc_matcher
    interval            = var.service_hc_interval
    timeout             = var.service_hc_timeout
    healthy_threshold   = var.service_hc_healthy_threshold
    unhealthy_threshold = var.service_hc_unhealthy_threshold
  }
}

# --------------------------------------------------------------------------------------------------------
# LB listener
# --------------------------------------------------------------------------------------------------------
resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.listener_default_action_type
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

# --------------------------------------------------------------------------------------------------------
# ECS Service
# --------------------------------------------------------------------------------------------------------
resource "aws_ecs_service" "frontend" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_arn
  task_definition = var.ecs_task_defination_arn
  desired_count   = var.ecs_desired_count
  launch_type     = var.ecs_launch_type

  network_configuration {
    subnets          = var.ecs_private_subnets
    security_groups  = var.ecs_sg_id
    assign_public_ip = var.ecs_assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend.arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }

  depends_on = [aws_lb_listener.frontend]
}

# --------------------------------------------------------------------------------------------------------
# Auto scaling group
# --------------------------------------------------------------------------------------------------------
resource "aws_appautoscaling_target" "frontend" {
  max_capacity       = var.as_max_capacity
  min_capacity       = var.as_min_capacity
  resource_id        = "service/${var.as_cluster_name}/${aws_ecs_service.frontend.name}"
  scalable_dimension = var.as_scalable_dimension
  service_namespace  = var.as_service_namespace
}

# --------------------------------------------------------------------------------------------------------
# ASG policy
# --------------------------------------------------------------------------------------------------------
resource "aws_appautoscaling_policy" "frontend_cpu" {
  name               = var.cpu_policy_name
  policy_type        = var.cpu_policy_type
  resource_id        = aws_appautoscaling_target.frontend.resource_id
  scalable_dimension = aws_appautoscaling_target.frontend.scalable_dimension
  service_namespace  = aws_appautoscaling_target.frontend.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.cpu_predefined_metric
    }
    target_value       = var.cpu_target_value
    scale_in_cooldown  = var.cpu_scale_in_cooldown
    scale_out_cooldown = var.cpu_scale_out_cooldown
  }
}

# --------------------------------------------------------------------------------------------------------
# ASG policy
# --------------------------------------------------------------------------------------------------------
resource "aws_appautoscaling_policy" "frontend_mem" {
  name               = var.mem_policy_name
  policy_type        = var.mem_policy_type
  resource_id        = aws_appautoscaling_target.frontend.resource_id
  scalable_dimension = aws_appautoscaling_target.frontend.scalable_dimension
  service_namespace  = aws_appautoscaling_target.frontend.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.mem_predefined_metric
    }
    target_value       = var.mem_target_value
    scale_in_cooldown  = var.mem_scale_in_cooldown
    scale_out_cooldown = var.mem_scale_out_cooldown
  }
}
