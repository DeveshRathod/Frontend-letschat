# Letschat Frontend -- Terraform Infrastructure

This repository contains the complete Terraform configuration for
deploying the Letschat Frontend (React/Next.js) on AWS using ECS
Fargate, ALB, Route53 DNS, and shared networking sourced from Terraform
remote state.

## 📁 Repository Structure

    .
    ├── environments
    │   ├── dev
    │   ├── qa
    │   └── prod
    │        ├── backend.hcl
    │        ├── backend.tf
    │        ├── main.tf
    │        ├── variables.tf
    │        └── outputs.tf
    │
    ├── modules
    │   ├── ecs/           → ECS task + execution role + container definition
    │   ├── service/       → ECS service + target group + ALB routing
    │   └── route53/       → DNS records for environment
    │
    └── tfvars
        ├── dev.tfvars
        ├── qa.tfvars
        └── prod.tfvars

Each environment folder contains only the wiring; all logic lives inside
modules.

## ☁️ Remote State (Shared Networking From Backend Project)

The frontend does **not** create VPC, Subnets, Security Groups, or ECS
Cluster.\
These are fetched dynamically from the backend Terraform state:

``` hcl
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.remote_bucket
    key    = var.remote_key
    region = var.aws_region
  }
}
```

This provides: - VPC ID
- Public/Private Subnets
- ECS Cluster
- Security Groups
- Backend API URL

This ensures the frontend and backend run in the same network without
duplication.

## 📦 Modules Overview

### 1. modules/ecs

Creates: - ECS task definition
- Execution + task role
- Log group
- Container definition with dynamic image input

Inputs: - ecs_image
- container_port
- cpu/memory
- env variables

### 2. modules/service

Handles: - ECS service
- Target group
- ALB listener rules
- Auto-scaling support

### 3. modules/route53

Creates DNS entries like:

    dev.frontend.example.com → ALB DNS

## 🔧 How to Use

### Initialize (per environment)

    cd environments/dev
    terraform init -backend-config=backend.hcl

### Plan

    terraform plan -var-file=../../tfvars/dev.tfvars

### Apply

    terraform apply -var-file=../../tfvars/dev.tfvars

## 📝 Example dev.tfvars

``` hcl
remote_bucket = "letschat-backend-tfstate"
remote_key    = "network/dev/terraform.tfstate"

domain = "dev.letschat.app"

ecs_image      = "frontendimage:tag"
container_port = 3000
desired_count  = 1
```


## ✔️ Summary

This repo provides: - Fully modular frontend infrastructure
- Multi-environment Terraform layout
- Shared VPC/Security Groups via remote state
- ECS Fargate deployment
- ALB + Route53 routing
- CI/CD friendly image replacement
