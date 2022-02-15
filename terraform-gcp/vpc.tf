resource "google_compute_network" "vpc_network" {
  name                    = "final-project"
  auto_create_subnetworks = false
}