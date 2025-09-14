resource "google_sql_database_instance" "postgres" {
  name             = "svelte-postgres-staging"
  database_version = "POSTGRES_15"
  region           = var.region

  deletion_protection = true

  settings {
    tier              = "db-f1-micro" # cheapest
    availability_type = "ZONAL"
    disk_autoresize   = false

    backup_configuration {
      point_in_time_recovery_enabled = false
    }
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }

  depends_on = [google_project_service.enabled_apis]
}

resource "google_sql_database" "staging_db" {
  name     = "appdb_staging"
  instance = google_sql_database_instance.postgres.name
  depends_on = [
    google_sql_database_instance.postgres,
    google_project_service.enabled_apis
  ]
}

resource "google_sql_database" "prod_db" {
  name     = "appdb_prod"
  instance = google_sql_database_instance.postgres.name
  depends_on = [
    google_sql_database_instance.postgres,
    google_project_service.enabled_apis
  ]
}

resource "google_sql_user" "staging_user" {
  # trimsuffix is used due to Postgres username length limits and GCP requirement to drop ".gserviceaccount.com"
  name     = trimsuffix(google_service_account.staging_sa.email, ".gserviceaccount.com")
  instance = google_sql_database_instance.postgres.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
  depends_on = [
    google_sql_database_instance.postgres,
    google_project_service.enabled_apis
  ]
}

resource "google_sql_user" "prod_user" {
  # trimsuffix is used due to Postgres username length limits and GCP requirement to drop ".gserviceaccount.com"
  name     = trimsuffix(google_service_account.prod_sa.email, ".gserviceaccount.com")
  instance = google_sql_database_instance.postgres.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
  depends_on = [
    google_sql_database_instance.postgres,
    google_project_service.enabled_apis
  ]
}