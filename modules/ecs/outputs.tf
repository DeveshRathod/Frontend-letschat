output "task_definition_arn" {
  value = aws_ecs_task_definition.ecs.arn
  description = "frontend task definition arn"
}

output "task_definition_id" {
  value = aws_ecs_task_definition.ecs.id
  description = "frontend task definition id"
}