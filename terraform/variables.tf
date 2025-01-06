variable "environment" {
  description = "Name of the environment"
  type    = string
  default = "test"
}

variable "ARM_SUBSCRIPTION_ID" {
  description = "Azure Subscription ID"
  type = string
  sensitive = true
}

variable "ARM_TENANT_ID" {
  description = "Azure Tenant ID"
  type = string
  sensitive = true
}

variable "ARM_CLIENT_ID" {
  description = "Azure Client ID"
  type = string
  sensitive = true
}

variable "ARM_CLIENT_SECRET" {
  description = "Azure Client Secret"
  type = string
  sensitive = true
}

# variable "kube_config" {
#   type        = string
#   description = "The kubernetes config"
# }
