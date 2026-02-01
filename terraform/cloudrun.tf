resource "google_cloud_run_service" "svelte_app" {
  name     = "svelte-app"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloud_run_sa.email
      containers {
        image = "gcr.io/cloudrun/hello" // placeholder
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

  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image,
      template[0].spec[0].service_account_name,
      traffic,
    ]
  }
}

#resource "google_cloud_run_domain_mapping" "default" {
#  name     = "verified-domain.com"
#  location = google_cloud_run_v2_service.default.location
#  metadata {
#    namespace = data.google_project.project.project_id
#  }
#  spec {
#    route_name = google_cloud_run_v2_service.default.name
#  }
#}
