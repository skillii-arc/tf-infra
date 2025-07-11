# tf-infra

This repository contains the Terraform and Terragrunt infrastructure code for managing AWS resources for the Skillii project.

## Structure

- `global-vars.hcl`, `root.hcl`: Global and root-level configuration files.
- `EMA/`: Environment-specific configurations.
  - `projects-vars.hcl`: Project-level variables.
  - `DEV/aws/`: Development environment AWS resources.
    - `EC2-Backend/`, `EC2-Bastion/`, `EC2-Frontend/`, `VPC/`: Each contains a `terragrunt.hcl` for managing respective AWS resources.
- `tf-modules/`: Reusable Terraform modules.
  - `aws/EC2/`, `aws/VPC/`: Modules for EC2 and VPC resources, each with `main.tf`, `outputs.tf`, and `variables.tf`.

## Usage

1. Install [Terraform](https://www.terraform.io/) and [Terragrunt](https://terragrunt.gruntwork.io/).
2. Configure your AWS credentials.
3. Navigate to the desired environment and resource directory (e.g., `tf-infra/EMA/DEV/aws/EC2-Backend/`).
4. Run `terragrunt init` and `terragrunt apply` to provision resources.

## Requirements
- Terraform >= 1.0.0
- Terragrunt >= 0.35.0
- AWS CLI (for authentication)

## License
MIT License