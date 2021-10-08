output "public_ip" {
  value = google_compute_address.platform_ip.address
}
output "freeipa_ip"{
  value = google_compute_address.freeipa_ip.address
}

output "platform" {
    value = google_compute_instance.yb-platform.self_link
}

output "console_password" {
    sensitive = true
    value = random_password.password.result
}