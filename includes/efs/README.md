## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| app-component | The name to the component to to run in the EKS cluster | `string` | n/a | yes |
| app-name | The application name tfor the cluster | `string` | n/a | yes |
| environment | The name of the environment | `string` | n/a | yes |
| git\_branch | The name of the branch that executed the pipline | `string` | n/a | yes |
| infrastructure-component | The component of the infrastrcuture. One of application, core or temporary | `string` | n/a | yes |
| infrastructure\_version | The version of the infrastructure that is being applied | `string` | `"unversioned"` | no |
| network\_type | We consider 2 type of networks to be used: NAT and Isolated. This variable allows to define the type of the network to make EFS share available | `string` | `"isolated"` | no |
| repo\_url | The URL to the repository where the infrastructure code is located. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| efs\_id | n/a |

## Exmple usage
```toml
variable "region" {}
variable "git_branch" {}
variable "infrastructure_version" {}
variable "repo_url" {}

module "gitlab-data-efs" {
  source              = "git@gitlab.to-the.cloud:infrastructure/resources.git//efs/"
  environment         = "shared"
  app-name            = "ppt"
  app-component       = "efs-name"

  infrastructure_version    = var.infrastructure_version
  repo_url                  = var.repo_url
  git_branch                = var.git_branch
  infrastructure-component  = "core"
}
```

The variables should be send to terraform:
```bash
terraform plan -refresh=true -out=plan.tfplan
  -var region=us-east-1
  -var "repo_url=https://gitlab.to-the.cloud/reponame.git"
  -var "git_branch=master"
  -var "infrastructure_version=v1.0.0"
terraform apply plan.tfplan
```
