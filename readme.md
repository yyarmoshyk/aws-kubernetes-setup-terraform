This terraform code can be used to provision EKS cluster and required resources such as basic security group and IAM roles.

Requirements:
1. [Terraform v0.12.29](https://releases.hashicorp.com/terraform/0.12.29/)
2. [Configured aws authentication](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) on the mashine that is used to run the infrastructure update
3. [Default VPC](https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html) in the selected region

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
