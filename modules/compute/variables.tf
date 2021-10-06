variable "identifier" {
  type = string
}

variable "local_identifier" {
  type    = string
  default = "replicated"
}
variable "ssh_public_key" {
  description = "public key to be use when creating the bastion/replicated instance"
  type        = string
}
variable "ssh_user" {
  description = "user name to connect to bastion/replicated instance"
  type        = string
}

variable "zone" {
    type = string
}

variable "region" {
    type = string
}

variable "gce_vm" {
  type = map
  default = {
      instance_type = "n2-standard-2"
      os_project = "ubuntu-os-cloud"
      os_family = "ubuntu-1804-lts"
      boot_disk_size = 200
  }

}

variable "subnetwork" {
  type = string
}