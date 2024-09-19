# Required provider
provider "google" {
  project = var.project
  region  = var.region
}

# Enable necessary APIs
resource "google_project_service" "logging_api" {
  project = var.project
  service = "logging.googleapis.com"
}

resource "google_project_service" "bigquery_api" {
  project = var.project
  service = "bigquery.googleapis.com"
}

resource "google_project_service" "storage_api" {
  project = var.project
  service = "storage.googleapis.com"
}

resource "google_project_service" "pubsub_api" {
  project = var.project
  service = "pubsub.googleapis.com"
}

resource "google_project_service" "iam_api" {
  project = var.project
  service = "iam.googleapis.com"
}