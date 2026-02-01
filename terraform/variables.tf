variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Default region"
  default     = "europe-north1"
}

variable "github_owner" {
  type        = string
  description = "GitHub organization or username"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name"
}

variable "terraform_state_bucket_name" {
  type = string
}

variable "github_cloudbuild_installation_id" {
  type = number
}

variable "github_pat" {
  type = string
}

variable "domain_name" {
  type        = string
  description = "Custom domain name"
}