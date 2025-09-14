output "cloud_run_url" {
  description = "Public URL of the SvelteKit Cloud Run service"
  value       = google_cloud_run_service.svelte_app.status[0].url
}

output "cloud_sql_connection_name" {
  description = "Connection name for the Cloud SQL Postgres instance"
  value       = google_sql_database_instance.postgres.connection_name
}

output "cloud_sql_instance_public_ip" {
  description = "Public IP address of the Cloud SQL Postgres instance"
  value       = google_sql_database_instance.postgres.public_ip_address
}

output "staging_db_name" {
  description = "Name of the staging database"
  value       = google_sql_database.staging_db.name
}

output "prod_db_name" {
  description = "Name of the production database"
  value       = google_sql_database.prod_db.name
}