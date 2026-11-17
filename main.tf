resource "google_composer_environment" "composer3" {
  provider = google-beta

  name    = var.environment_name
  region  = var.region
  project = var.project_id
  labels  = merge({ environment = var.environment_name, managed_by = "terraform" }, var.labels)

  config {
    enable_private_environment = var.enable_private_environment

    software_config {
      image_version = "composer-3-airflow-3"

      env_variables = {
        ENVIRONMENT = var.environment_name
      }

      pypi_packages = var.pypi_packages
    }

    node_config {
      network         = google_compute_network.composer_vpc.id
      subnetwork      = google_compute_subnetwork.composer_subnet.id
      service_account = google_service_account.composer_sa.email
    }

    workloads_config {
      scheduler {
        cpu        = 1
        memory_gb  = 2
        storage_gb = 5
        count      = 2
      }

      web_server {
        cpu        = 1
        memory_gb  = 2
        storage_gb = 5
      }

      worker {
        cpu        = 2
        memory_gb  = 4
        storage_gb = 10
        min_count  = var.worker_min_count
        max_count  = var.worker_max_count
      }
    }
  }

  # APIs must be enabled and the service account must hold its role before
  # Composer starts provisioning; neither is implied by attribute references.
  depends_on = [
    google_project_service.composer_api,
    google_project_service.compute_api,
    google_project_iam_member.composer_worker,
  ]

  lifecycle {
    precondition {
      condition     = var.worker_min_count <= var.worker_max_count
      error_message = "worker_min_count must be less than or equal to worker_max_count."
    }
  }
}
