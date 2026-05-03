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

# 1. THE PROJECT
# Logic: Agile template natively supports: Epic -> Feature -> User Story -> Task
resource "azuredevops_project" "main" {
  name               = "Platform-Engineering"
  work_item_template = "Agile" 
  version_control    = "Git"
  visibility         = "private"
  description        = "Infrastructure and Platform Engineering tracking"

  # FIX: Changed "repos" to "repositories" to match provider schema
  features = {
    "testplans"    = "disabled"
    "boards"       = "enabled"
    "repositories" = "enabled" 
    "pipelines"    = "enabled"
  }
}

# 2. THE TEAM
resource "azuredevops_team" "infra_team" {
  project_id = azuredevops_project.main.id
  name       = "Infrastructure-Ops"
}

# 3. PROJECT PERMISSIONS
# Grants the team permission to manage children and work items at the root area path
resource "azuredevops_area_permissions" "root_permissions" {
  project_id = azuredevops_project.main.id
  principal  = azuredevops_team.infra_team.descriptor
  path       = "/"
  permissions = {
    CREATE_CHILDREN   = "Allow"
    GENERIC_READ = "Allow"
    DELETE = "Allow"
  }
}