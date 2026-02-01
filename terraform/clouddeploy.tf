resource "google_clouddeploy_delivery_pipeline" "svelte_pipeline" {
  depends_on = [
    google_clouddeploy_target.run_target,
    google_project_service.enabled_apis
  ]
  name        = var.cloud_deploy_pipeline_name
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
  name     = var.cloud_deploy_target_name
  location = var.region
  project  = var.project_id

  run {
    location = "projects/${var.project_id}/locations/${var.region}"
  }

  depends_on = [
    google_cloud_run_v2_service.svelte_app_v2,
    google_project_service.enabled_apis
  ]
}
