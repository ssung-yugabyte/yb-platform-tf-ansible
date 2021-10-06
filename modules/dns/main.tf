resource "google_dns_managed_zone" "dns_zone" {
    name = "ybtest"
    dns_name =  "yb-${random_id.rnd.hex}.com."
}

resource "random_id" "rnd"{
    byte_length = 4
}

resource "google_dns_record_set" "platform" {
    name = "ybpl.${google_dns_managed_zone.dns_zone.dns_name}"
    type = "A"
    ttl = 300
    managed_zone = google_dns_managed_zone.dns_zone.name
    rrdatas = [var.platform_ip]
}
