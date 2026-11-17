output "environment_name" {
  description = "Name of the Composer environment."
  value       = google_composer_environment.composer3.name
}

output "airflow_uri" {
  description = "URL of the Airflow web UI."
  value       = google_composer_environment.composer3.config[0].airflow_uri
}

output "dag_gcs_prefix" {
  description = "GCS path to upload DAG files to."
  value       = google_composer_environment.composer3.config[0].dag_gcs_prefix
}

output "service_account_email" {
  description = "Service account the Composer workloads run as. Grant it data-access roles your DAGs need."
  value       = google_service_account.composer_sa.email
}

output "network_id" {
  description = "ID of the dedicated VPC."
  value       = google_compute_network.composer_vpc.id
}

output "subnetwork_id" {
  description = "ID of the Composer subnet."
  value       = google_compute_subnetwork.composer_subnet.id
}
