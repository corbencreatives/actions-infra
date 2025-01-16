
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

provider "kubernetes" {
  config_path = "~/.kube/config"
#   config_path = var.kube_config
#   config_context = "cicdcluster"
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
