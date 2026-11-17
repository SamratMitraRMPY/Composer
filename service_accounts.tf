resource "google_service_account" "composer_sa" {
  project      = var.project_id
  account_id   = "${var.resource_prefix}-sa"
  display_name = "Composer 3 service account (${var.environment_name})"
}

# The only role Composer 3 needs to run. Grant data-access roles
# (BigQuery, GCS, Secret Manager) separately, scoped to what your DAGs use.
resource "google_project_iam_member" "composer_worker" {
  project = var.project_id
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}
