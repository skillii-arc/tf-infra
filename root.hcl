# generate "locals" {
#     path = "locals.tf"
#     if_exists = "overwrite_terragrunt"
#     contents = <<EOF
# locals {
#   project_vars = (read_terragrunt_config(find_in_parent_folders("projects-vars.hcl"))).locals
#   global_vars = (read_terragrunt_config(find_in_parent_folders("global-vars.hcl"))).locals
#   merged_tags = merge(local.project_vars.common_tags, local.global_vars.common_tags)
# }
# EOF
# }

generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
provider "aws" {
  region = "ap-south-1"
}
EOF
}

generate "terraform" {
    path      = "terraform.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
  required_version = "v1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "skillii-devops-25b1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}