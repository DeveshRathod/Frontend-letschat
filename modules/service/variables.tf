variable "service_lb_name" {
  type        = string
  description = "Name of the Application Load Balancer for the service."
}

variable "service_lb_internal" {
  type        = bool
  description = "Whether the load balancer is internal (true) or internet-facing (false)."
}

variable "service_lb_type" {
  type        = string
  description = "Type of load balancer to create (e.g., application, network)."
}

variable "service_lb_sgs" {
  type        = list(string)
  description = "List of security group IDs to attach to the load balancer."
}

variable "service_lb_psubnets" {
  type        = list(string)
  description = "List of public subnet IDs where the ALB will be deployed."
}

variable "service_tg_name" {
  type        = string
  description = "Name of the target group associated with the service."
}

variable "service_tg_port" {
  type        = number
  description = "Port on which the target group receives incoming traffic."
}

variable "service_tg_protocol" {
  type        = string
  description = "Protocol for the target group (HTTP, HTTPS, TCP)."
}

variable "service_tg_target_type" {
  type        = string
  description = "Target type: instance, ip, or lambda."
}

variable "service_tg_vpc_id" {
  type        = string
  description = "VPC ID where the target group will be created."
}

variable "service_hc_path" {
  type        = string
  description = "HTTP path used for ALB health checks (e.g., /health)."
}

variable "service_hc_protocol" {
  type        = string
  description = "Protocol used for health checks (HTTP or HTTPS)."
}

variable "service_hc_matcher" {
  type        = string
  description = "HTTP response codes considered healthy (e.g., 200-399)."
}

variable "service_hc_interval" {
  type        = number
  description = "Interval between health checks (seconds)."
}

variable "service_hc_timeout" {
  type        = number
  description = "Health check timeout value (seconds)."
}

variable "service_hc_healthy_threshold" {
  type        = number
  description = "Number of consecutive successful checks to consider a target healthy."
}

variable "service_hc_unhealthy_threshold" {
  type        = number
  description = "Number of consecutive failed checks to consider a target unhealthy."
}

variable "listener_port" {
  type        = number
  description = "Port for the ALB listener (e.g., 80 or 443)."
}

variable "listener_protocol" {
  type        = string
  description = "Protocol for the ALB listener (HTTP or HTTPS)."
}

variable "listener_default_action_type" {
  type        = string
  description = "Default action for the listener (usually 'forward')."
}

variable "ecs_service_name" {
  type        = string
  description = "Name of the ECS service to create."
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
  description = "Whether to assign a public IP to ECS tasks running in public subnets."
}

variable "ecs_container_name" {
  type        = string
  description = "Name of the container defined in the ECS task definition."
}

variable "ecs_container_port" {
  type        = number
  description = "Port exposed by the ECS container."
}

variable "ecs_cluster_arn" {
  type        = string
  description = "ARN of the ECS cluster where the service will run."
}

variable "ecs_private_subnets" {
  type        = list(string)
  description = "List of private subnet IDs used for ECS task networking."
}

variable "ecs_sg_id" {
  type        = list(string)
  description = "List of security group IDs assigned to ECS tasks."
}

variable "ecs_task_defination_arn" {
  type        = string
  description = "ARN of the ECS task definition used by the service."
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
  description = "Scalable dimension, such as ecs:service:DesiredCount."
}

variable "as_service_namespace" {
  type        = string
  description = "AWS service namespace for autoscaling (e.g., ecs)."
}

variable "as_cluster_name" {
  type        = string
  description = "Name of the ECS cluster associated with autoscaling."
}

variable "cpu_policy_name" {
  type        = string
  description = "Name of the CPU-based autoscaling policy."
}

variable "cpu_policy_type" {
  type        = string
  description = "Type of scaling policy (such as TargetTrackingScaling)."
}

variable "cpu_predefined_metric" {
  type        = string
  description = "Predefined CloudWatch metric for CPU scaling."
}

variable "cpu_target_value" {
  type        = number
  description = "Target CPU utilization percentage for autoscaling."
}

variable "cpu_scale_in_cooldown" {
  type        = number
  description = "Cooldown period after scaling-in events."
}

variable "cpu_scale_out_cooldown" {
  type        = number
  description = "Cooldown period after scaling-out events."
}

variable "mem_policy_name" {
  type        = string
  description = "Name of the memory-based autoscaling policy."
}

variable "mem_policy_type" {
  type        = string
  description = "Type of scaling policy for memory-based autoscaling."
}

variable "mem_predefined_metric" {
  type        = string
  description = "Predefined CloudWatch metric for memory scaling."
}

variable "mem_target_value" {
  type        = number
  description = "Target memory utilization percentage for autoscaling."
}

variable "mem_scale_in_cooldown" {
  type        = number
  description = "Cooldown period after memory scale-in."
}

variable "mem_scale_out_cooldown" {
  type        = number
  description = "Cooldown period after memory scale-out."
}
