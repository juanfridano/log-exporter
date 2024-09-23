project = "log-exporter-436111"
region = "europe-west3"
global_location = "EU"
pubsub_topic_name = "log-export-topic"
bucket_name = "log-export-bucket_new"
dataset_name = "log_export_dataset"

logs_filter = "resource.type= cloud_run_revision"
service_account = "logging-sa"