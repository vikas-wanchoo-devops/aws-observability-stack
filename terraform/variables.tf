# terraform/variables.tf
# Input variables for ECS services

variable "vpc_id" {
  description = "VPC ID where ECS services run"
  type        = string
  default     = "vpc-0b5d7248bdde16ef7"   # replace with your actual VPC ID
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  type        = string
  default     = "arn:aws:iam::879696522469:role/PrometheusRole"  # replace with your actual role ARN
}

variable "task_role_arn" {
  description = "IAM role ARN for ECS task"
  type        = string
  default     = "arn:aws:iam::879696522469:role/PrometheusRole"  # replace with your actual role ARN
}

variable "app_image" {
  description = "Docker image for Assa Abloy App"
  type        = string
  default     = "879696522469.dkr.ecr.eu-north-1.amazonaws.com/assaabloy-app:latest"
}
