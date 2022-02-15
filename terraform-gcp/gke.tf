resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.region
  network = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.private.name
  depends_on = [
    google_compute_subnetwork.private
  ]
  #enable_autopilot = false


  ip_allocation_policy{
    cluster_ipv4_cidr_block = "10.3.0.0/16"
    services_ipv4_cidr_block = "10.4.0.0/16"
}

  private_cluster_config {
      enable_private_nodes = true
      enable_private_endpoint = true
      master_ipv4_cidr_block = "172.16.0.0/28"
      master_global_access_config {
          enabled = false
      }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.1.0.0/16"
      display_name = "access-cluster-with-subnet-management"
    }
  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
    remove_default_node_pool = true
    initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1
  autoscaling {
    min_node_count = "1"
    max_node_count = "2"
  }
  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.vm.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}