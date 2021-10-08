locals {
  name = "${var.identifier}"
}

resource "random_password" "password" {
    length = 16
    special = true
    upper = true
    lower = true
    number = true
    override_special = "_%@!"
}

resource "google_compute_address" "platform_ip" {
    name = "platform-ip"
    region = var.region
}
resource "google_compute_address" "freeipa_ip" {
    name = "freeeipa-ip"
    region = var.region
}
resource "google_compute_instance" "yb-platform" {
  name = "${local.name}-platform"
  machine_type = var.gce_vm.instance_type
  zone = var.zone
  tags = ["yugaware"]
  boot_disk {
      auto_delete = true
      initialize_params {
        image = "${var.gce_vm.os_project}/${var.gce_vm.os_family}"
        size = var.gce_vm.boot_disk_size
      }

  }
  metadata = {
    sshKeys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }

  network_interface {
      subnetwork = var.subnetwork
      access_config {
        nat_ip = google_compute_address.platform_ip.address
      }
  }
}

resource "google_compute_instance" "freeipa" {
  name = "${local.name}-freeipa"
  machine_type = var.gce_vm.instance_type
  zone = var.zone
  tags = ["freeipa"]
  boot_disk {
      auto_delete = true
      initialize_params {
        image = "centos-cloud/centos-stream-8"
        size = var.gce_vm.boot_disk_size
      }

  }
  metadata = {
    sshKeys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }
  network_interface {
      subnetwork = var.subnetwork
      access_config {
        nat_ip = google_compute_address.freeipa_ip.address
      }
  }
}