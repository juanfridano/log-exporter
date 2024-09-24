project = "log-exporter-436111"
region = "europe-west3"
global_location = "EU"
pubsub_topic_name = "log-export-topic"
bucket_name = "log-export-bucket_23"
dataset_name = "log_export_dataset"

logs_filter = "resource.type= cloud_run_revision"
service_account = "logging-sa"

cloud_function_bucket_name = "gcf_code"
teams_webhook_url = "https://webhook.site/2b764d89-dbdd-444a-b4b3-a1d1cfb13c5d"