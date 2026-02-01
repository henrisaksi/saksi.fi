
resource "google_pubsub_topic_iam_member" "cloud_run_pubsub_publisher" {
  project = var.project_id
  topic   = google_pubsub_topic.contact_form_submission.name
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}
