resource "google_compute_instance" "management" {
  name         = "vm-management"
  machine_type = "e2-medium"
  zone         = "us-central1-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  depends_on = [
    google_service_account.vm
  ]

  // Local SSD disk
  # scratch_disk {
  #   interface = "SCSI"
  # }

  network_interface {
    network = "final-project"
    subnetwork = "management"

    # access_config {
    #   // Ephemeral public IP
    # }
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.vm.email
    scopes = ["cloud-platform"]
  }
}
