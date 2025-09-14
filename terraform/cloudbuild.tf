resource "google_cloudbuildv2_connection" "github_conn" {
  location = var.region
  name     = "github-connection"
  github_config {
    app_installation_id = var.github_cloudbuild_installation_id
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github_pat_secret_version.id
    }
  }

  depends_on = [
    google_project_service.enabled_apis,
    google_project_iam_member.cloudbuild_github_secret_accessor
  ]
}

resource "google_cloudbuildv2_repository" "github_repo" {
  name              = var.github_repo
  parent_connection = google_cloudbuildv2_connection.github_conn.id
  remote_uri        = "https://github.com/${var.github_owner}/${var.github_repo}.git"

  depends_on = [
    google_cloudbuildv2_connection.github_conn,
    google_project_service.enabled_apis
  ]
}

resource "google_cloudbuild_trigger" "github_trigger" {
  name        = "sveltekit-trigger"
  description = "Build and push SvelteKit app"
  location    = var.region

  repository_event_config {
     repository = google_cloudbuildv2_repository.github_repo.id
     push {
       branch = "^main$"
     }
   }

  service_account = google_service_account.cloudbuild_service_account.id
  filename = "cloudbuild.yaml"

  depends_on = [
    google_project_iam_member.custom_build_run_admin,
    google_project_iam_member.custom_build_clouddeploy_runner,
    google_project_iam_member.custom_build_artifact_writer,
    google_project_iam_member.custom_build_sql_client,
    google_cloudbuildv2_repository.github_repo,
    google_project_service.enabled_apis
  ]
}