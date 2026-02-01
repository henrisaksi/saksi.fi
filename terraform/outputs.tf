output "cloud_run_url" {
  description = "Public URL of the SvelteKit Cloud Run service"
  value       = google_cloud_run_v2_service.svelte_app_v2.uri
}
