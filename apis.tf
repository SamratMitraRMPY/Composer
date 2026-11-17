resource "google_project_service" "composer_api" {
  project = var.project_id
  service = "composer.googleapis.com"

  # Leave the API enabled on destroy: other workloads in the project may use it.
  disable_on_destroy = false
}

resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"

  disable_on_destroy = false
}
