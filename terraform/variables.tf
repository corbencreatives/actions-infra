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

variable "kube_config" {
  type        = string
  description = "Kubernetes config"
  default = "./kube_config"
}

variable "repository_name" {
  type        = string
  description = "GitHub repository name"
  default = "actions-infra"
}

variable "docker_username" {
  type        = string
  description = "Docker registry username"
  default = "corbencreatives"
}

variable "docker_server" {
  type        = string
  description = "Docker registry server"
  default = "https://ghcr.io"
}

variable "docker_password" {
  type        = string
  description = "Docker registry password"
  sensitive = true
}
