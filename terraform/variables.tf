# terraform/variables.tf
# Input variables for ECS services

variable "vpc_id" {
  description = "VPC ID where ECS services run"
  type        = string
  default     = "vpc-0b5d7248bdde16ef7"
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  type        = string
  default     = "arn:aws:iam::879696522469:role/PrometheusRole"
}

variable "task_role_arn" {
  description = "IAM role ARN for ECS task"
  type        = string
  default     = "arn:aws:iam::879696522469:role/PrometheusRole"
}

# --- Application Image ---
variable "app_image" {
  description = "Docker image for Assa Abloy App"
  type        = string
  default     = "879696522469.dkr.ecr.eu-north-1.amazonaws.com/assaabloy-app:latest"
}

# --- Prometheus Image ---
variable "prometheus_image" {
  description = "Docker image for Prometheus"
  type        = string
  default     = "prom/prometheus:latest"
}

# --- Grafana Image ---
variable "grafana_image" {
  description = "Docker image for Grafana"
  type        = string
  default     = "grafana/grafana:latest"
}

# --- CloudWatch Exporter Image ---
variable "cloudwatch_exporter_image" {
  description = "Docker image for CloudWatch Exporter"
  type        = string
  default     = "prom/cloudwatch-exporter:latest"
}

# --- Kafka Image (if used) ---
variable "kafka_image" {
  description = "Docker image for Kafka"
  type        = string
  default     = "confluentinc/cp-kafka:latest"
}
