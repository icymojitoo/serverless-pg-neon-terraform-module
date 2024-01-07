variable "database_name" {}
variable "admin_role_name" {}
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

provider "neon" {
  token = var.neon_token
}

variable "neon_token" {
  type      = string
  sensitive = true
}

module "this_database" {
  source = "../../modules/serverless-pg/database"

  database_name = var.database_name
  owner_name    = var.admin_role_name
  branch_id     = var.branch_id
  project_id    = var.project_id
}

output "database_id" {
  value = module.this_database.database_id
}
