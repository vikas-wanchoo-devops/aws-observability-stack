# AWS Observability Stack

This repo contains Docker Compose configs for Prometheus, Grafana, and Kafka.

## Usage
1. Run: docker-compose up -d
2. Prometheus: http://localhost:9090
3. Grafana: http://localhost:3000 (admin/admin)
4. Kafka: localhost:9092

Prometheus scrapes metrics from your Flask app (/metrics).
Kafka streams logs from your app into topics.
Grafana visualizes metrics and logs.
