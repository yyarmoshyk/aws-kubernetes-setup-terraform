## Purpose
The primary purpose of this code is to setup a k8s cluster with provisioning in AWS

## Description
This terraform code can be used to provision EKS cluster and required resources such as basic security group and IAM roles.
The code structure is not optimal and it was made for purpose. Please PM me for optimal infrastructure code organisation.

## Requirements:
1. [Terraform v0.12.29](https://releases.hashicorp.com/terraform/0.12.29/)
2. [Configured aws authentication](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) on the machine that is used to run the infrastructure update

## Steps
The order of commands to be executed to create the EKS cluster:
```bash
terraform apply -auto-approve -target module.vpc -var region=us-east-1
terraform apply -auto-approve -target module.eks-iam -var region=us-east-1
terraform apply -auto-approve -target module.eks-sg -var region=us-east-1
terraform apply -auto-approve -var region=us-east-1
```

When destroying, the cluster should go first:
```bash
terraform destroy -force -target module.eks-sample-cluster
```

Configure your system to work with the new cluster:
```bash
aws eks update-kubeconfig --name sample-eks-eks-cluster
```

Optionally you can enable EFS driver for EKS
```bash
kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"
```
