module "eks-iam" {
  source                    = "./includes/iam/"
  name                      = "sample-eks"
}

module "eks-sg" {
  source                    = "./includes/security-group/"
  name                      = "sample-eks"

  nework_cidr               = "0.0.0.0/0"
  egress_tcp_ports          = ["0"]
  protocol                  = "-1"

}

module "eks-sample-cluster" {
  source                    = "./includes/eks-cluster/"
  name                      = "sample-eks"
  namespaces                = ["default"]
}
