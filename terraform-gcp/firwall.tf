resource "google_compute_firewall" "firewall" {
  name    = "management"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22","443"]
  }
  source_ranges = [
        "35.235.240.0/20"
  ]
  direction = "INGRESS"

  target_tags = ["foo"]
}
