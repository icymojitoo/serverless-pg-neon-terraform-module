variable "role_name" {}
variable "project_id" {}
variable "branch_id" {}

terraform {
  required_providers {
    neon = {
      source = "terraform-community-providers/neon"
      version = "0.1.4"
    }
  }
}

resource "neon_role" "base_role" {
  name       = var.role_name
  branch_id  = var.branch_id
  project_id = var.project_id
}

output "role_id" {
  value = neon_role.base_role.id
}

output "role_name" {
  value = var.role_name
}

output "role_password" {
  value = neon_role.base_role.password
  sensitive = true
}
