resource "google_cloud_run_service" "svelte_app" {
  name     = "svelte-app"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloud_run_sa.email
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    google_artifact_registry_repository.app_repo,
    google_project_service.enabled_apis
  ]
}