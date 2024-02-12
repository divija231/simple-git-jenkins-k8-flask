# main.tf

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "vpc-subnet"
  ip_cidr_range = "10.2.0.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_firewall" "rules" {
  name        = "my-firewall-rule"
  network     = "vpc-network"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080", "1000-2000","22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
resource "google_container_cluster" "my_cluster" {
  name     = "my-gke-cluster"
  location = "us-west1"

  initial_node_count = 1
  network = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.vpc_subnet.id
  default_max_pods_per_node =8
  deletion_protection = false
  

  node_config {
    machine_type = "n1-standard-2"
    disk_size_gb = 75
    

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

master_auth {
  client_certificate_config {
    issue_client_certificate = false
  }
}

}
