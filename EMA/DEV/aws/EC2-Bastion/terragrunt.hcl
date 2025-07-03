include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  project_vars = read_terragrunt_config(find_in_parent_folders("projects-vars.hcl")).locals
  global_vars  = read_terragrunt_config(find_in_parent_folders("global-vars.hcl")).locals
  merged_tags = merge(local.project_vars.common_tags, local.global_vars.common_tags)
}

terraform {
  source = "../../../../../tf-modules/aws/EC2/"
}

dependency "VPC" {
  config_path = "../VPC"
  mock_outputs = {
          private_subnets = ["subnet-xyz"]
          public_subnets = ["subnet-xyz"]
          vpc_cidr_block = "10.0.0.0/16"
          vpc_id = "vpc-xyz"
      }
}

inputs = {
  instance_ami = "ami-0f918f7e67a3323f0"
  instance_type  = "t2.micro"
  # key_name = "firstVM"
  # vpc_security_group_ids = [""]
  subnet_id = dependency.VPC.outputs.public_subnets[0]
  create_security_group = "true"
  security_group_description = "Bastion Host SG"
  security_group_ingress_rules = {
  ssh = {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"
  }
  }
  security_group_name = "Bastion Host SG"
  security_group_vpc_id = dependency.VPC.outputs.vpc_id
  tags = local.merged_tags
}