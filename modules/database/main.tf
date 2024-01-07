variable "database_name" {}
variable "owner_name" {}
variable "branch_id" {}
variable "project_id" {}

terraform {
  required_providers {
    neon = {
      source = "terraform-community-providers/neon"
      version = "0.1.4"
    }
  }
}

resource "neon_database" "base_database" {
  name       = var.database_name
  owner_name = var.owner_name
  branch_id  = var.branch_id
  project_id = var.project_id
}

output "database_id" {
  value = neon_database.base_database.id
}
