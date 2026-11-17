resource "google_compute_network" "composer_vpc" {
  project                 = var.project_id
  name                    = "${var.resource_prefix}-vpc"
  auto_create_subnetworks = false

  depends_on = [google_project_service.compute_api]
}

resource "google_compute_subnetwork" "composer_subnet" {
  project                  = var.project_id
  name                     = "${var.resource_prefix}-subnet"
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region
  network                  = google_compute_network.composer_vpc.id
  private_ip_google_access = true
}
