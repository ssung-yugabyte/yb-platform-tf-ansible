variable "regions" {
    type = list
}

variable "vpc_network" {
  type = string
}

variable "identifier" {
  type = string
}

variable "default-subnets" {
  type = bool
  default = false
}