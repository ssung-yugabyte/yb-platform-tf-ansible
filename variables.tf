variable "ssh_private_key" {
  description = "private key to connect to the bastion/replicated instance"
  type        = string
}

variable "ssh_public_key" {
  description = "public key to be use when creating the bastion/replicated instance"
  type        = string
}

variable "ssh_user" {
  description = "user name to connect to bastion/replicated instance"
  type        = string
}

variable "license_key" {
  description = "license key to activate the yugabyte platform"
  type        = string
}


# cloud inputs
variable "project" {
  description = "gcp project name"
  type        = string
}

variable "regions" {
  description = "gcp region to deploy the services to"
  default     = ["us-central1","us-east1", "us-west1"]
  type        = list
}
variable "zone" {
  description = "gcp region to deploy the services to"
  default     = "us-central1-c"
  type        = string
}

variable "vpc_network" {
  description = "network name to provision the services to"
  default     = "default"
  type        = string
}

variable "control_name" {
  description = "name of the replicated instance"
  type        = string
  default     = "replicated"
}

variable "identifier" {
  description = "identifier to prefix to all resources created"
  default     = "yugabyte"
  type        = string
}

variable "credentials" {
    type = string
}