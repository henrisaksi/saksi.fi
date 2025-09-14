resource "google_artifact_registry_repository" "app_repo" {
  location      = var.region
  repository_id = "artifacts"
  format        = "DOCKER"

  depends_on = [google_project_service.enabled_apis]
}