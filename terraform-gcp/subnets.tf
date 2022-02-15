resource "google_compute_subnetwork" "private" {
  name          = "management"
  ip_cidr_range = "10.1.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}



# NAT gateway for management

# router
resource "google_compute_router" "router" {
  name    = "router-management"
  region  = google_compute_subnetwork.private.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_address" "address" {
  count  = 1
  name   = "nat-manual-ip-${count.index}"
  region = google_compute_subnetwork.private.region
}

# router connection to nat
resource "google_compute_router_nat" "nat_manual" {
  name   = "my-router-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.address.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}