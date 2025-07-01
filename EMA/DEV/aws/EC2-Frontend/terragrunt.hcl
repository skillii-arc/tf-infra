include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../tf-modules/aws/EC2/"
}

# dependency "VPC" {
#   config_path = "../VPC"
#   mock_outputs = {
#           vpc_private_subnets = "mock-VPC-output"
#           vpc_public_subnets = "xyz"
#       }
# }

inputs = {
  instance_ami = "ami-0f918f7e67a3323f0"
  instance_type  = "t2.micro"
  key_name = "firstVM"
  vpc_security_group_ids = ["sg-0550c60dd27ee8d6d"]
  subnet_id = "subnet-0b74cf2dbe7666432"
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
  https = {
    description = "https access"
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"
  }
  }
  security_group_name = "Bastion Host SG"
  security_group_vpc_id = "vpc-0ef93e7e3b82b981d"
#   tags = local.common_tags
}