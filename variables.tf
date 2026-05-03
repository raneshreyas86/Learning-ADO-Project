variable "ado_org_url" {
  type        = string
  description = "The full URL of your Azure DevOps Organization (e.g., https://dev.azure.com/YourOrg)"
}

variable "ado_pat" {
  type        = string
  description = "Personal Access Token with appropriate permissions"
  sensitive   = true
}

variable "project_name" {
  type    = string
  default = "Learning-ADO-Project"
}