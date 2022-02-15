variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

module "eks" {
  name = "mn-ook-test"
  source  = "../../terraform-aws-eks"
#  version = "1.7.0"
  kubernetes_version = "1.21"
  subnets = ["subnet-02ac0a17015778d0f", "subnet-0c063bc4f1c897d0a", "subnet-0c842dea988ae67bd"]
}