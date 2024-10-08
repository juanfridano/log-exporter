variable "project" {
  type = string
  description = "Name of the project in GCP."
}

variable "region" {
  type    = string
  description = "Region where project is located in GCP."
}

variable "global_location" {
  type = string
  description = "Multi-region availability for GCP Project."
}

variable "dataset_name" {
  type        = string
  description = "BigQuery Dataset name to save logs to."
}

variable "pubsub_topic_name" {
  type        = string
  description = "Pub/sub topic name to publish logs to."
}

variable "bucket_name" {
  type        = string
  description = "Bucket name to save logs to."
}

variable "logs_filter" {
  type        = string
  description = "Filter for cloud logs"
}

variable "service_account" {
  description = "Service account name"
}

variable "cloud_function_bucket_name" {
  description = "Bucket to store cloud function code"
}

variable "teams_webhook_url" {
  description = "Webhook for Teams Channel to forward alerts"
}