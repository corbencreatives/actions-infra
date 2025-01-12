
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
  }
}

# Configure the GitHub Provider
provider "github" {}

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
