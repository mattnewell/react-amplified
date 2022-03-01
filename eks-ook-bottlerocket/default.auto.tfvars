aws_region      = "us-east-2"
azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
use_default_vpc = false
name            = "mn-eks-bottlerocket"
tags = {
  env = "dev"
}
kubernetes_version  = "1.21"
managed_node_groups = []
node_groups = [
  {
    name          = "bottlerocket"
    instance_type = "t3.small"
    ami_type      = "BOTTLEROCKET_x86_64"
  },
]


# allowed values for 'ami_type'
#  - AL2_x86_64
#  - AL2_x86_64_GPU
#  - AL2_ARM_64
#  - CUSTOM
#  - BOTTLEROCKET_ARM_64
#  - BOTTLEROCKET_x86_64
