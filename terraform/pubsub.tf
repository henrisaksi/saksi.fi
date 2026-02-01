resource "google_pubsub_topic" "contact_form_submission" {
  name    = "contact-form-submission"
  project = var.project_id
}
