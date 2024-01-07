variable "max_cu" {
  type = number
  default = 0.25
}

variable "min_cu" {
  type = number
  default = 0.25
}

variable "suspend_timeout" {
  type = number
  default = 300
}

variable "branch_id" {}
variable "project_id" {}

terraform {
  required_providers {
    neon = {
      source  = "terraform-community-providers/neon"
      version = "0.1.4"
    }
  }
}

resource "neon_endpoint" "endpoint" {
  branch_id       = var.branch_id
  project_id      = var.project_id
  max_cu          = var.max_cu
  min_cu          = var.min_cu
  suspend_timeout = var.suspend_timeout
}

output "endpoint_compute_provisioner" {
  value =neon_endpoint.endpoint.compute_provisioner
}

output "endpoint_host" {
  value = neon_endpoint.endpoint.host
}

output "endpoint_id" {
  value = neon_endpoint.endpoint.id
}
