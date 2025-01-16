
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.4.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.35.1"
    }

  }
}

# Configure the GitHub Provider
provider "github" {}

# provider "kubernetes" {
#   config_path = "~/.kube/config"
#   config_context = "cicdcluster"
# }

data "azurerm_kubernetes_cluster" "credentials" {
  name                = azurerm_kubernetes_cluster.cl-cicd.name
  resource_group_name = azurerm_resource_group.rg.name
}

provider "kubernetes" {
  config_path            = "~/.kube/config"
  host                   = data.azurerm_kubernetes_cluster.credentials.kube_config[0].host
  username               = data.azurerm_kubernetes_cluster.credentials.kube_config[0].username
  password               = data.azurerm_kubernetes_cluster.credentials.kube_config[0].password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config[0].client_certificate, )
  client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config[0].client_key, )
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config[0].cluster_ca_certificate, )
}

# provider "helm" {
#   kubernetes {
#     config_path = var.kube_config
#   }
# }

provider "azurerm" {
  features {}
  subscription_id = var.ARM_SUBSCRIPTION_ID
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-cicd-apps"
  location = local.location
}

locals {
  env      = var.environment
  location = "West Europe"
}
