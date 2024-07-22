variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_ids" {
  description = "List of EC2 instance IDs to start and stop"
  type        = list(string)
}

variable "start_schedule" {
  description = "Cron expression for the start schedule"
  type        = string
}

variable "stop_schedule" {
  description = "Cron expression for the stop schedule"
  type        = string
}
