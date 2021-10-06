output "public_ip" {
  value = google_compute_instance.yb-platform.network_interface.0.access_config.0.nat_ip
}

output "platform" {
    value = google_compute_instance.yb-platform.self_link
}

output "console_password" {
    sensitive = true
    value = random_password.password.result
}