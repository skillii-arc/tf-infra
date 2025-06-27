include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../tf-modules/aws/EC2/"
}

inputs = {
  instance_ami = "ami-0f918f7e67a3323f0"
  instance_type  = "t2.micro"
  key_name = "firstVM"
  vpc_security_group_ids = ["sg-0550c60dd27ee8d6d"]
  subnet_id = "subnet-0b74cf2dbe7666432"
#   tags = local.common_tags
}