terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.11.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = var.ado_org_url
  personal_access_token = var.ado_pat
}

resource "azuredevops_project" "test_project" {
  name       = var.project_name
  visibility = "private"
  features = {
    "testplans" = "disabled" # Prevents accidental paid license prompts
  }
}