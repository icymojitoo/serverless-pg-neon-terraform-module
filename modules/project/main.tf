variable "project_region" {}
variable "branch_name" {}
variable "project_name" {}

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

variable "pg_version" {
  type = number
  default = 15
}


terraform {
  required_providers {
    neon = {
      source = "terraform-community-providers/neon"
      version = "0.1.4"
    }
  }
}

resource "neon_project" "something" {
  name   = var.project_name
  region_id = var.project_region
  pg_version = 15
  branch = {
    endpoint = {
      max_cu = var.max_cu
      min_cu = var.min_cu
      suspend_timeout = var.suspend_timeout
    }
    name = var.branch_name
  }
}

output "project_id" {
  value = neon_project.something.id
}

output "platform_id" {
  value = neon_project.something.platform_id
}

output "branch_id" {
    value = neon_project.something.branch.id
}

output "endpoint_compute_provisioner" {
  value = neon_project.something.branch.endpoint.compute_provisioner
}

output "endpoint_host" {
  value = neon_project.something.branch.endpoint.host
}

output "endpoint_id" {
  value = neon_project.something.branch.endpoint.id
}