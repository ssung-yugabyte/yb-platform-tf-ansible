output "control_subnet" {
  value = google_compute_subnetwork.yb_subnets[0].self_link
}