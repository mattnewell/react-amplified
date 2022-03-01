provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source  = "Young-ook/sagemaker/aws//modules/vpc"
  version = "> 0.0.6"
  name    = "mn-eks-ook"
  vpc_config = {
    azs         = ["us-east-2a", "us-east-2b", "us-east-2c"]
    cidr        = "10.10.0.0/16"
    subnet_type = "private"
    single_ngw  = true
  }
}

module "eks" {
  name   = "mn-ook-test"
  source = "../../terraform-aws-eks"
  #  version = "1.7.0"
  kubernetes_version = "1.21"
  subnets            = slice(values(module.vpc.subnets["private"]), 0, 3)
  node_groups = [
    # Doesn't seem to work, needs investigation
    #    {
    #      name          = "bottlerocket"
    #      instance_type = "t3.small"
    #      ami_type      = "BOTTLEROCKET_x86_64"
    #    },
    #    {
    #      name          = "regular"
    #      instance_type = "t3.small"
    #      ami_type      = "AL2_x86_64"
    #    }
  ]
  managed_node_groups = [
    {
      name          = "fixed-size"
      desired_size  = 2
      instance_type = "t3.small"
    }
  ]
}

provider "helm" {
  debug = true
  kubernetes {
    host                   = module.eks.helmconfig.host
    token                  = module.eks.helmconfig.token
    cluster_ca_certificate = base64decode(module.eks.helmconfig.ca)
  }
}

module "alb-ingress" {
  source       = "../../terraform-aws-eks/modules/alb-ingress"
  cluster_name = module.eks.cluster.name
  oidc         = module.eks.oidc
  helm = {
    name            = "aws-load-balancer-controller"
    repository      = "https://aws.github.io/eks-charts"
    chart           = "aws-load-balancer-controller"
    namespace       = "kube-system"
    cleanup_on_fail = true
  }
}