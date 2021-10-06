terraform {
    required_providers {
      google = {
          source = "hashicorp/google"
          version = ">=3.82.0"
      }
    }
}

provider "google" {
    project = var.project
    credentials = file(var.credentials)
}

module "network" {
    source = "./modules/network"
    identifier = var.identifier
    regions = var.regions
    vpc_network = var.vpc_network
}

module "dns" {
    source = "./modules/dns"
    platform_ip = module.compute.public_ip
}
module "compute" {
    source = "./modules/compute"
    identifier = var.identifier
    region = var.regions[0]
    zone = var.zone
    subnetwork = module.network.control_subnet
    ssh_user = var.ssh_user
    ssh_public_key = var.ssh_public_key
}

resource "local_file" "ansible_host" {
    content = templatefile("ansible/templates/hosts.tpl",
        {
            ip = module.compute.public_ip
            user = var.ssh_user
            ssh_private_key = var.ssh_private_key
        }
    )
    filename = "${path.module}/hosts"
}

resource "null_resource" "andible_playbook_os" {
    depends_on = [
        local_file.ansible_host,
        module.compute.platform,
    ]
    provisioner "local-exec" {
        command = "ansible-playbook ansible/playbooks/os/main.yaml --extra-vars=\"license=$license console_password=$console_password fqdn=$fqdn public_ip=$public_ip\""
        environment = {
            license = var.license_key
            fqdn = module.dns.platform_dns
            public_ip = module.compute.public_ip
            console_password = module.compute.console_password
        }
    }
}