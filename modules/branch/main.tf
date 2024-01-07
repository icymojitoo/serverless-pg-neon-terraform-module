variable "branch_name" {}
variable "parent_branch_id" {}
variable "project_id" {}

terraform {
  required_providers {
    neon = {
      source = "terraform-community-providers/neon"
      version = "0.1.4"
    }
  }
}

resource "neon_branch" "branch" {
  name       = var.branch_name
  parent_id  = var.parent_branch_id
  project_id = var.project_id
}

output "branch_id" {
    value = neon_branch.branch.id
}
