resource "google_clouddeploy_delivery_pipeline" "svelte_pipeline" {
  depends_on = [
    google_clouddeploy_target.run_target,
    google_project_service.enabled_apis
  ]
  name        = "sveltekit-pipeline"
  location    = var.region
  description = "CD pipeline for SvelteKit app"

  serial_pipeline {
    stages {
      target_id = google_clouddeploy_target.run_target.name
      profiles  = []
    }
  }
}

resource "google_clouddeploy_target" "run_target" {
  name     = "sveltekit-run-target"
  location = var.region
  project  = var.project_id

  run {
    location = "projects/${var.project_id}/locations/${var.region}"
  }

  depends_on = [
    google_cloud_run_service.svelte_app,
    google_project_service.enabled_apis
  ]
}