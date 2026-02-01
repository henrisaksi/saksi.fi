output "cloud_run_url" {
  description = "Public URL of the SvelteKit Cloud Run service"
  value       = google_cloud_run_service.svelte_app.status[0].url
}
