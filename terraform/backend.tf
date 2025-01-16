
# The block below configures Terraform to use the 'remote' backend with Terraform Cloud.
# For more information, see https://www.terraform.io/docs/backends/types/remote.html
terraform {
  cloud {
    organization = "corbencreatives"
    workspaces {
      name = "actions-infra"
    }
  }
}

resource "azurerm_kubernetes_cluster" "cl-cicd" {
  name                = "cicdcluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "cicdcluster"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "Standard_B2s"
    upgrade_settings {
      drain_timeout_in_minutes = 0
      max_surge = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "local_file" "kubeconfig" {
  content  = kubeconfig_raw
  filename = "kubeconfig"
}

output "kubeconfig_file" {
  value = "${path.cwd}/kubeconfig"
}

data "terraform_remote_state" "kubeconfig_file" {
  backend = "remote"

  config = {
    organization = "hashicorp"
    workspaces = {
      name = "actions-infra"
    }
  }
#   backend = "local"
#
#   config = {
#     path = "${path.module}/../dirA/terraform.tfstate"
#   }
}

resource "kubernetes_namespace" "cicd-namespace" {
  metadata {
    name = "cicd"
  }
}
