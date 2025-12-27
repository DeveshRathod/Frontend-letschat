variable "ecs_name" {
  type        = string
  description = "Name of the ECS task definition and container."
}

variable "ecs_frontend_image" {
  type        = string
  description = "Docker image URI for the ECS frontend container."
}

variable "ecs_cpu" {
  type        = number
  description = "CPU units to allocate for the ECS task definition."
}

variable "ecs_memory" {
  type        = number
  description = "Memory allocated (in MiB) for the ECS task definition."
}

variable "ecs_container_port" {
  type        = number
  description = "Port exposed by the container inside ECS."
}

variable "ecs_backend_port" {
  type        = number
  description = "Port on which the backend service is exposed for communication."
}

variable "ecs_network_mode" {
  type        = string
  description = "Network mode for ECS task definition (e.g. awsvpc)."
}

variable "ecs_requires_compatibilities" {
  type        = list(string)
  description = "Launch types supported by the ECS task (e.g. FARGATE)."
}

variable "ecs_os_family" {
  type        = string
  description = "Operating system family for ECS runtime platform (e.g. LINUX)."
}

variable "ecs_cpu_arch" {
  type        = string
  description = "CPU architecture for ECS tasks (e.g. X86_64 or ARM64)."
}

variable "ecs_log_group_name" {
  type        = string
  description = "CloudWatch log group name for ECS logs."
}

variable "ecs_log_stream_prefix" {
  type        = string
  description = "Prefix for CloudWatch log stream within the log group."
}

variable "ecs_log_retention_days" {
  type        = number
  description = "Number of days to retain CloudWatch logs."
}

variable "ecs_region" {
  type        = string
  description = "AWS region where ECS resources are deployed."
}

variable "ecs_task_role_arn" {
  type        = string
  description = "IAM Task Role ARN for ECS task."
}

variable "ecs_backend_service_discovery_name" {
  type        = string
  description = "Backend service discovery name (from remote state)."
}

variable "ecs_namespace_name" {
  type        = string
  description = "Service discovery namespace name (from remote state)."
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
