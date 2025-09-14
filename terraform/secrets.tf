resource "google_secret_manager_secret" "github_pat_secret" {
  secret_id = "github-pat-secret"
  replication {
    auto {}
  }
}

# classic token needed https://issuetracker.google.com/issues/343223837?pli=1
resource "google_secret_manager_secret_version" "github_pat_secret_version" {
  secret      = google_secret_manager_secret.github_pat_secret.id
  secret_data = var.github_pat
}