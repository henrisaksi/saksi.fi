/*
  This file manages IAM bindings for Cloud Build's default service account.

  The following roles are granted:
    - Cloud Run Admin (roles/run.admin): Allows Cloud Build to deploy and manage Cloud Run services.
    - Cloud Deploy Job Runner (roles/clouddeploy.jobRunner): Permits Cloud Build to trigger Cloud Deploy delivery pipelines.
    - Artifact Registry Writer (roles/artifactregistry.writer): Enables Cloud Build to push images and artifacts to Artifact Registry.
  The data "google_project" resource is used to fetch project metadata such as the project ID and project number,
  which are required to correctly reference the Cloud Build service account in IAM member bindings.
*/

data "google_project" "project" {
  project_id = var.project_id
}


resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run-sa"
  display_name = "Cloud Run Service Account"
  depends_on   = [google_project_service.enabled_apis]
}


# Grant Secret Manager access to the Cloud Build GitHub connection service agent.
# This is required because the Cloud Build GitHub connection needs permission to access
# the GitHub PAT secret stored in Secret Manager.
resource "google_project_iam_member" "cloudbuild_github_secret_accessor" {
  project    = data.google_project.project.project_id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
  depends_on = [google_project_service.enabled_apis]
}

resource "google_service_account" "cloudbuild_service_account" {
  account_id   = "cloudbuild-sa"
  display_name = "cloudbuild-sa"
  description  = "Cloud build service account"
}

# Grant permissions to the dedicated Cloud Build service account
resource "google_project_iam_member" "custom_build_run_admin" {
  project    = data.google_project.project.project_id
  role       = "roles/run.admin"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}

resource "google_project_iam_member" "custom_build_clouddeploy_runner" {
  project    = data.google_project.project.project_id
  role       = "roles/clouddeploy.jobRunner"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}

resource "google_project_iam_member" "custom_build_artifact_writer" {
  project    = data.google_project.project.project_id
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}

resource "google_project_iam_member" "custom_build_log_writer" {
  project    = data.google_project.project.project_id
  role       = "roles/logging.logWriter"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}

# Grant Cloud Deploy Viewer role to the dedicated Cloud Build service account.
# This is needed for Cloud Build to be able to read delivery pipelines (required by `gcloud deploy releases create`).
resource "google_project_iam_member" "custom_build_clouddeploy_viewer" {
  project    = data.google_project.project.project_id
  role       = "roles/clouddeploy.viewer"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}
# Grant Storage Admin role to the dedicated Cloud Build service account.
# This is required because Cloud Deploy may create temporary buckets or artifacts during release creation.
resource "google_project_iam_member" "custom_build_storage_admin" {
  project    = data.google_project.project.project_id
  role       = "roles/storage.admin"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}

# Grant Service Account User role to allow Cloud Build to impersonate other service accounts for deployments.
resource "google_project_iam_member" "custom_build_service_account_user" {
  project    = data.google_project.project.project_id
  role       = "roles/iam.serviceAccountUser"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}

# Grant Cloud Deploy Releaser role to allow Cloud Build to create and promote releases in Cloud Deploy.
resource "google_project_iam_member" "custom_build_clouddeploy_releaser" {
  project    = data.google_project.project.project_id
  role       = "roles/clouddeploy.releaser"
  member     = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  depends_on = [google_project_service.enabled_apis]
}

# Allow unauthenticated (public) access to the Cloud Run service.
resource "google_cloud_run_v2_service_iam_member" "allow_unauthenticated" {
  name     = google_cloud_run_v2_service.svelte_app_v2.name
  location = var.region
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
