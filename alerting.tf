# Cloud Function Bucket
resource "google_storage_bucket" "function_bucket" {
  name          = var.cloud_function_bucket_name
  location      = var.global_location
  force_destroy = true
}

resource "google_storage_bucket_object" "archive" {
  name   = "teams_mapper.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "./cloud_functions/teams_mapper.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "alert-teams-mapper"
  description = "Maps alerts into active Cards for MS Teams"
  runtime     = "go122"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "WebhookMapper"
  environment_variables = {
    WEBHOOK_URL = var.teams_webhook_url
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# Notification channel for Webhook
resource "google_monitoring_notification_channel" "webhook_channel" {
  display_name = "Webhook Notification"
  type         = "webhook_tokenauth"
  labels = {
    url = "${google_cloudfunctions_function.function.https_trigger_url}"
  }
}