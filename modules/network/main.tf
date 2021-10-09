locals {
  name = "${var.identifier}-${var.vpc_network}"
}

data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

resource "google_compute_network" "vpc" {
  name = var.vpc_network
  auto_create_subnetworks = var.default-subnets
}

resource "google_compute_subnetwork" "yb_subnets" {
    count = var.default-subnets? 0 : 3
    name = "${local.name}-${count.index+1}"
    ip_cidr_range = "10.${count.index+1}.0.0/16"
    network = google_compute_network.vpc.id
    region = var.regions[count.index]
}

resource "google_compute_firewall" "yb_internal" {
  name = "${local.name}-iinternal"
  network = google_compute_network.vpc.id
  allow {
    protocol = "sctp"
  }
   allow {
    protocol = "ipip"
  }
   allow {
    protocol = "tcp"
  }
   allow {
    protocol = "udp"
  }
   allow {
    protocol = "icmp"
  }
}
resource "google_compute_firewall" "yb_external" {
  name = "${local.name}-external"
  network = google_compute_network.vpc.id
  allow {
      protocol = "TCP"
      ports = ["22","80","443","8800","9000","7000","9042","5433"]
  }
  source_ranges = [lookup(data.external.myipaddr.result,"ip")]
}