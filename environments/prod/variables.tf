################################################################################################################
# GLOBAL VARIABLES
################################################################################################################
variable "remote_bucket" {
  type = string
}

variable "remote_key" {
  type = string
}

variable "aws_region" {
  type = string
}

################################################################################################################
# ECS VARIABLES
################################################################################################################
variable "ecs_name" {
  description = "Name of the ECS task definition and container."
}

variable "ecs_frontend_image" {
  description = "Docker image URI for the ECS frontend container."
}

variable "ecs_cpu" {
  description = "CPU units to allocate for the ECS task definition."
}

variable "ecs_memory" {
  description = "Memory allocated (in MiB) for the ECS task definition."
}

variable "ecs_container_port" {
  description = "Port exposed by the container inside ECS."
}

variable "ecs_backend_port" {
  description = "Port on which the backend service is exposed for communication."
}

variable "ecs_network_mode" {
  description = "Network mode for ECS task definition (e.g. awsvpc)."
}

variable "ecs_requires_compatibilities" {
  type        = list(string)
  description = "Launch types supported by the ECS task (e.g. FARGATE)."
}

variable "ecs_os_family" {
  description = "Operating system family for ECS runtime platform (e.g. LINUX)."
}

variable "ecs_cpu_arch" {
  description = "CPU architecture for ECS tasks (e.g. X86_64 or ARM64)."
}

variable "ecs_log_group_name" {
  description = "CloudWatch log group name for ECS logs."
}

variable "ecs_log_stream_prefix" {
  description = "Prefix for CloudWatch log stream within the log group."
}

variable "ecs_log_retention_days" {
  description = "Number of days to retain CloudWatch logs."
}


variable "healthcheck_command" {
  type        = list(string)
  description = "Command executed inside the container to determine container health."
}

variable "healthcheck_interval" {
  type        = number
  description = "Time (in seconds) between each container health check execution."
}

variable "healthcheck_timeout" {
  type        = number
  description = "Time (in seconds) allowed for a health check command to complete."
}

variable "healthcheck_retries" {
  type        = number
  description = "Number of failed health checks before the container is marked unhealthy."
}

variable "healthcheck_start_period" {
  type        = number
  description = "Grace period (seconds) before starting health checks after container startup."
}

################################################################################################################
# SERVICE VARIABLES
################################################################################################################
variable "service_lb_name" {
  type        = string
  description = "Name of the Application Load Balancer for the service."
}

variable "service_lb_internal" {
  type        = bool
  description = "Determines whether the load balancer is internal (true) or internet-facing (false)."
}

variable "service_lb_type" {
  type        = string
  description = "Type of AWS load balancer (e.g., application, network)."
}

variable "service_tg_name" {
  type        = string
  description = "Name of the target group used by the service."
}

variable "service_tg_port" {
  type        = number
  description = "Port on which the target group receives traffic."
}

variable "service_tg_protocol" {
  type        = string
  description = "Protocol used by the target group (e.g., HTTP, HTTPS)."
}

variable "service_tg_target_type" {
  type        = string
  description = "Type of target to register (instance, ip, lambda)."
}

variable "service_hc_path" {
  type        = string
  description = "HTTP path used for ALB target group health checks."
}

variable "service_hc_protocol" {
  type        = string
  description = "Protocol for health checks (HTTP or HTTPS)."
}

variable "service_hc_matcher" {
  type        = string
  description = "HTTP response code range that marks healthy targets (e.g., 200-399)."
}

variable "service_hc_interval" {
  type        = number
  description = "Interval between health checks (in seconds)."
}

variable "service_hc_timeout" {
  type        = number
  description = "Health check timeout value (in seconds)."
}

variable "service_hc_healthy_threshold" {
  type        = number
  description = "Number of consecutive successful health checks before a target is considered healthy."
}

variable "service_hc_unhealthy_threshold" {
  type        = number
  description = "Number of consecutive failed health checks before a target is considered unhealthy."
}

variable "listener_port" {
  type        = number
  description = "Listener port for the ALB (e.g., 80 or 443)."
}

variable "listener_protocol" {
  type        = string
  description = "Listener protocol (HTTP or HTTPS)."
}

variable "listener_default_action_type" {
  type        = string
  description = "Default listener action type (typically 'forward')."
}

variable "ecs_service_name" {
  type        = string
  description = "Name of the ECS service."
}

variable "ecs_desired_count" {
  type        = number
  description = "Desired number of ECS tasks to run."
}

variable "ecs_launch_type" {
  type        = string
  description = "Launch type for ECS tasks (FARGATE or EC2)."
}

variable "ecs_assign_public_ip" {
  type        = bool
  description = "Whether to assign a public IP to ECS tasks."
}

variable "ecs_container_name" {
  type        = string
  description = "Name of the container defined in the ECS task definition."
}

variable "as_max_capacity" {
  type        = number
  description = "Maximum number of ECS tasks allowed by autoscaling."
}

variable "as_min_capacity" {
  type        = number
  description = "Minimum number of ECS tasks allowed by autoscaling."
}

variable "as_scalable_dimension" {
  type        = string
  description = "Scalable dimension for App Auto Scaling (e.g., ecs:service:DesiredCount)."
}

variable "as_service_namespace" {
  type        = string
  description = "AWS service namespace for scaling (e.g., ecs)."
}

variable "cpu_policy_name" {
  type        = string
  description = "Name of the CPU-based autoscaling policy."
}

variable "cpu_policy_type" {
  type        = string
  description = "Type of autoscaling policy (e.g., TargetTrackingScaling)."
}

variable "cpu_predefined_metric" {
  type        = string
  description = "Predefined CloudWatch metric for CPU scaling."
}

variable "cpu_target_value" {
  type        = number
  description = "Target CPU utilization percentage for scaling."
}

variable "cpu_scale_in_cooldown" {
  type        = number
  description = "Cooldown period after scaling in."
}

variable "cpu_scale_out_cooldown" {
  type        = number
  description = "Cooldown period after scaling out."
}

variable "mem_policy_name" {
  type        = string
  description = "Name of the memory-based autoscaling policy."
}

variable "mem_policy_type" {
  type        = string
  description = "Type of memory autoscaling policy."
}

variable "mem_predefined_metric" {
  type        = string
  description = "Predefined CloudWatch metric for memory scaling."
}

variable "mem_target_value" {
  type        = number
  description = "Target memory utilization percentage for scaling."
}

variable "mem_scale_in_cooldown" {
  type        = number
  description = "Cooldown period after scaling in."
}

variable "mem_scale_out_cooldown" {
  type        = number
  description = "Cooldown period after scaling out."
}



variable "domain_name" {
  description = "Domain name for frontend"
  type        = string
}

variable "record_name" {
  description = "Record name for frontend"
  type        = string
}

variable "record_type" {
  description = "Record type for lb"
  type        = string
}


variable "evaluate_target_health" {
  description = "Evaluate target health"
  type        = bool
}


