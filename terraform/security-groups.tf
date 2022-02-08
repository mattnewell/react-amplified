
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8"
#      "67.23.104.250/32",
#      "134.238.78.3/32",
#      "134.238.140.223/32",
#      "134.238.224.13/32",
#      "165.1.215.121/32",
#      "208.127.80.33/32",
#      "208.127.231.5/32"
    ]
  }
}

#resource "aws_security_group" "worker_group_mgmt_two" {
#  name_prefix = "worker_group_mgmt_two"
#  vpc_id      = module.vpc.vpc_id
#
#  ingress {
#    from_port = 22
#    to_port   = 22
#    protocol  = "tcp"
#
#    cidr_blocks = [
#      "192.168.0.0/16",
#    ]
#  }
#}
#
#resource "aws_security_group" "all_worker_mgmt" {
#  name_prefix = "all_worker_management"
#  vpc_id      = module.vpc.vpc_id
#
#  ingress {
#    from_port = 22
#    to_port   = 22
#    protocol  = "tcp"
#
#    cidr_blocks = [
#      "10.0.0.0/8",
#      "172.16.0.0/12",
#      "192.168.0.0/16",
#    ]
#  }
#}
