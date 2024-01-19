terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.85"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.16.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.7.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = var.host
  username               = var.username
  password               = var.password
  client_key             = base64decode(var.client_key)
  client_certificate     = base64decode(var.client_certificate)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = var.host
    username               = var.username
    password               = var.password
    client_key             = base64decode(var.client_key)
    client_certificate     = base64decode(var.client_certificate)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

provider "kubectl" {
  host                   = var.host
  username               = var.username
  password               = var.password
  client_key             = base64decode(var.client_key)
  client_certificate     = base64decode(var.client_certificate)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}