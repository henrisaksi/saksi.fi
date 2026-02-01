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

variable "cloud_run_service_name" {
  type        = string
  description = "The name of the Cloud Run service"
  default     = "svelte-app"
}

variable "cloud_build_connection_name" {
  type        = string
  description = "The name of the Cloud Build connection"
  default     = "github-connection"
}

variable "cloud_build_trigger_name" {
  type        = string
  description = "The name of the Cloud Build trigger"
  default     = "sveltekit-trigger"
}

variable "cloud_deploy_pipeline_name" {
  type        = string
  description = "The name of the Cloud Deploy delivery pipeline"
  default     = "sveltekit-pipeline"
}

variable "cloud_deploy_target_name" {
  type        = string
  description = "The name of the Cloud Deploy target"
  default     = "sveltekit-run-target"
}

variable "artifact_repository_id" {
  type        = string
  description = "The ID of the Artifact Registry repository"
  default     = "artifacts"
}

variable "secret_id" {
  type        = string
  description = "The ID of the Secret Manager secret for GitHub PAT"
  default     = "github-pat-secret"
}
