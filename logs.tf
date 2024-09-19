# Required provider
provider "google" {
  project = var.project
  region  = var.region
}

# BigQuery Dataset
resource "google_bigquery_dataset" "log_dataset" {
  dataset_id = var.dataset_name
  location   = var.region
}

# Cloud Storage Bucket
resource "google_storage_bucket" "log_bucket" {
  name          = var.bucket_name
  location      = var.global_location
  force_destroy = true
}

# Pub/Sub Topic
resource "google_pubsub_topic" "log_topic" {
  name = var.pubsub_topic_name
}

# Logging Sink for exporting logs to BigQuery
resource "google_logging_project_sink" "log_sink_bigquery" {
  name        = "log-export-sink-bigquery"
  destination = "bigquery.googleapis.com/projects/${var.project}/datasets/${google_bigquery_dataset.log_dataset.dataset_id}"
  filter      = var.logs_filter

  bigquery_options {
    use_partitioned_tables = true
  }
}

# Logging Sink for exporting logs to Cloud Storage
resource "google_logging_project_sink" "log_sink_storage" {
  name        = "log-export-sink-storage"
  destination = "storage.googleapis.com/${google_storage_bucket.log_bucket.name}"
  filter      = var.logs_filter
}

# Logging Sink for exporting logs to Pub/Sub
resource "google_logging_project_sink" "log_sink_pubsub" {
  name        = "log-export-sink-pubsub"
  destination = "pubsub.googleapis.com/projects/${var.project}/topics/${google_pubsub_topic.log_topic.name}"
  filter      = var.logs_filter
}

# Grant Logging Service Account Permissions for BigQuery, Cloud Storage, and Pub/Sub
resource "google_service_account" "logging_sa" {
  account_id   = "logging-sa"
  display_name = "Logging Service Account"
}

resource "google_project_iam_binding" "bigquery_log_writer" {
  project = var.project
  role    = "roles/bigquery.dataEditor"
  members = [
    "serviceAccount:${google_service_account.logging_sa.email}",
  ]
}

resource "google_project_iam_binding" "storage_log_writer" {
  project = var.project
  role    = "roles/storage.objectCreator"
  members = [
    "serviceAccount:${google_service_account.logging_sa.email}",
  ]
}

resource "google_project_iam_binding" "pubsub_log_writer" {
  project = var.project
  role    = "roles/pubsub.publisher"
  members = [
    "serviceAccount:${google_service_account.logging_sa.email}",
  ]
}