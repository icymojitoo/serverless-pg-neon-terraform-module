variable "neon_token" {
  type      = string
  sensitive = true
}
# Project
variable "project_name" {}
variable "project_region" {}
variable "pg_version" {}
# Admin
variable "admin_role_name" {}
# Master Branch
variable "master_branch_name" {}
variable "master_endpoint_max_cu" {
  default = 0.25
}
variable "master_endpoint_min_cu" {
  default = 0.25
}
variable "master_endpoint_suspend_timeout" {
  default = 300
}

terraform {
  required_providers {
    neon = {
      source  = "terraform-community-providers/neon"
      version = "0.1.4"
    }
  }
}

provider "neon" {
  # Configuration options
  token = var.neon_token
}

module "this_project" {
  source = "../../modules/serverless-pg/project"

  project_name   = var.project_name
  project_region = var.project_region
  pg_version     = var.pg_version
  # Branch
  branch_name = var.master_branch_name
  # Endpoint
  max_cu          = var.master_endpoint_max_cu
  min_cu          = var.master_endpoint_min_cu
  suspend_timeout = var.master_endpoint_suspend_timeout
}

module "this_role" {
  source     = "../../modules/serverless-pg/role"
  role_name  = var.admin_role_name
  project_id = module.this_project.project_id
  branch_id  = module.this_project.branch_id
}


output "project_id" {
  value = module.this_project.project_id
}

output "platform_id" {
  value = module.this_project.platform_id
}

output "master_branch_id" {
  value = module.this_project.branch_id
}

output "master_endpoint_compute_provisioner" {
  value = module.this_project.endpoint_compute_provisioner
}

output "master_endpoint_host" {
  value = module.this_project.endpoint_host
}

output "master_endpoint_id" {
  value = module.this_project.endpoint_id
}

output "admin_role_id" {
  value = module.this_role.role_id
}

output "admin_role_name" {
  value = module.this_role.role_name
}

output "admin_role_password" {
  value     = module.this_role.role_password
  sensitive = true
}

# create a local file to store the all outputs
resource "local_file" "all_outputs" {
  filename = "../../config/db-project-admin.txt"
  content  = <<EOF
project_id=${module.this_project.project_id}
platform_id=${module.this_project.platform_id}
master_branch_id=${module.this_project.branch_id}
master_endpoint_compute_provisioner=${module.this_project.endpoint_compute_provisioner}
master_endpoint_host=${module.this_project.endpoint_host}
master_endpoint_id=${module.this_project.endpoint_id}
admin_role_id=${module.this_role.role_id}
admin_role_name=${module.this_role.role_name}
admin_role_password=${module.this_role.role_password}
EOF
}