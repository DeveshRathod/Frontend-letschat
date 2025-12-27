################################################################################################################
# Remote state
################################################################################################################
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket
    key    = var.remote_key
    region = var.aws_region
  }
}

################################################################################################################
# ECS Module
################################################################################################################
module "ecs_module" {
  source = "../../modules/ecs"

  ecs_name           = var.ecs_name
  ecs_frontend_image = var.ecs_frontend_image
  ecs_cpu            = var.ecs_cpu
  ecs_memory         = var.ecs_memory
  ecs_container_port = var.ecs_container_port
  ecs_backend_port   = var.ecs_backend_port

  ecs_network_mode             = var.ecs_network_mode
  ecs_requires_compatibilities = var.ecs_requires_compatibilities

  ecs_os_family = var.ecs_os_family
  ecs_cpu_arch  = var.ecs_cpu_arch

  ecs_log_group_name     = var.ecs_log_group_name
  ecs_log_stream_prefix  = var.ecs_log_stream_prefix
  ecs_log_retention_days = var.ecs_log_retention_days
  ecs_region             = var.aws_region

  ecs_task_role_arn                  = data.terraform_remote_state.network.outputs.ecs_task_role_arn
  ecs_backend_service_discovery_name = data.terraform_remote_state.network.outputs.backend_service_discovery_name
  ecs_namespace_name                 = data.terraform_remote_state.network.outputs.service_discovery_namespace_name

  healthcheck_command      = var.healthcheck_command
  healthcheck_interval     = var.healthcheck_interval
  healthcheck_retries      = var.healthcheck_retries
  healthcheck_start_period = var.healthcheck_start_period
  healthcheck_timeout      = var.healthcheck_timeout
}

################################################################################################################
# Service Module
################################################################################################################
module "service_module" {
  source = "../../modules/service"

  service_lb_name     = var.service_lb_name
  service_lb_internal = var.service_lb_internal
  service_lb_type     = var.service_lb_type
  service_lb_sgs      = [data.terraform_remote_state.network.outputs.security_group_id]
  service_lb_psubnets = data.terraform_remote_state.network.outputs.public_subnets

  service_tg_name        = var.service_tg_name
  service_tg_port        = var.service_tg_port
  service_tg_protocol    = var.service_tg_protocol
  service_tg_target_type = var.service_tg_target_type
  service_tg_vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  service_hc_path                = var.service_hc_path
  service_hc_protocol            = var.service_hc_protocol
  service_hc_matcher             = var.service_hc_matcher
  service_hc_interval            = var.service_hc_interval
  service_hc_timeout             = var.service_hc_timeout
  service_hc_healthy_threshold   = var.service_hc_healthy_threshold
  service_hc_unhealthy_threshold = var.service_hc_unhealthy_threshold

  listener_port                = var.listener_port
  listener_protocol            = var.listener_protocol
  listener_default_action_type = var.listener_default_action_type

  ecs_service_name        = var.ecs_service_name
  ecs_desired_count       = var.ecs_desired_count
  ecs_launch_type         = var.ecs_launch_type
  ecs_assign_public_ip    = var.ecs_assign_public_ip
  ecs_container_name      = var.ecs_container_name
  ecs_container_port      = var.ecs_container_port
  ecs_cluster_arn         = data.terraform_remote_state.network.outputs.ecs_cluster_arn
  ecs_private_subnets     = data.terraform_remote_state.network.outputs.nat_private_subnets
  ecs_sg_id               = [data.terraform_remote_state.network.outputs.security_group_id]
  ecs_task_defination_arn = module.ecs_module.task_definition_arn

  as_max_capacity       = var.as_max_capacity
  as_min_capacity       = var.as_min_capacity
  as_scalable_dimension = var.as_scalable_dimension
  as_service_namespace  = var.as_service_namespace
  as_cluster_name       = data.terraform_remote_state.network.outputs.ecs_cluster_name

  cpu_policy_name        = var.cpu_policy_name
  cpu_policy_type        = var.cpu_policy_type
  cpu_predefined_metric  = var.cpu_predefined_metric
  cpu_target_value       = var.cpu_target_value
  cpu_scale_in_cooldown  = var.cpu_scale_in_cooldown
  cpu_scale_out_cooldown = var.cpu_scale_out_cooldown

  mem_policy_name        = var.mem_policy_name
  mem_policy_type        = var.mem_policy_type
  mem_predefined_metric  = var.mem_predefined_metric
  mem_target_value       = var.mem_target_value
  mem_scale_in_cooldown  = var.mem_scale_in_cooldown
  mem_scale_out_cooldown = var.mem_scale_out_cooldown
}

################################################################################################################
# Route53 Module
################################################################################################################
module "route53_module" {
  source = "../../modules/route53"

  domain_name               = var.domain_name
  record_name               = var.record_name
  record_type               = var.record_type
  lb_evaluate_target_health = var.evaluate_target_health

  lb_dns_name = module.service_module.alb_dns_name
  lb_zone_id  = module.service_module.alb_dns_zone_id
}
