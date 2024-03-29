terraform {
  backend "gcs" {
    bucket = "cloud-resume-tf-state-db"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }

  required_version = ">= 0.14"
}

provider "google" {
  project = "cloudops-388321"
}

# Reserve IP address
resource "google_compute_global_address" "default" {
  name = "resume"
}

# Create Bucket
resource "google_storage_bucket" "default" {
  name          = "davidbour-cloud-resume-db"
  location      = "us-east1"
  force_destroy = true

  uniform_bucket_level_access = true
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Make Bucket Public
resource "google_storage_bucket_iam_member" "default" {
  bucket = google_storage_bucket.default.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Create Backend Bucket (Not the same as the bucket itself)
resource "google_compute_backend_bucket" "default" {
  name        = "cloud-resume-db-backend-bucket"
  description = "cloud resume backend"
  bucket_name = google_storage_bucket.default.name
  enable_cdn  = true
  cdn_policy {
    cache_mode        = "CACHE_ALL_STATIC"
    client_ttl        = 3600
    default_ttl       = 3600
    max_ttl           = 3600
    negative_caching  = true
    serve_while_stale = 3600
  }
}

# Configure the Backend
resource "google_compute_url_map" "default" {
  name            = "http-lb"
  default_service = google_compute_backend_bucket.default.id
}

# SSL Managed Certificate
resource "google_compute_managed_ssl_certificate" "default" {
  name = "cloud-resume-cert-managed"

  managed {
    domains = ["davidbour.com", "api.davidbour.com", "www.davidbour.com"]
  }
}

# HTTP Proxy
resource "google_compute_target_https_proxy" "default" {
  name             = "cloud-https-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

# Forwarding Rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "https-lb-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

# Firebase Project
resource "google_firebase_project" "default" {
  provider = google-beta
}

# Firebase Database
resource "google_project_service" "firebase_database" {
  provider = google-beta
  service  = "firebasedatabase.googleapis.com"
}

resource "google_firebase_database_instance" "default" {
  provider    = google-beta
  region      = "us-central1"
  instance_id = "cloudops-388321-default-rtdb"
  type        = "DEFAULT_DATABASE"
  depends_on  = [google_project_service.firebase_database]
}

# Create service account to execute Cloud Run
resource "google_service_account" "service_account" {
  account_id   = "cloud-run-invoker"
  display_name = "Cloud Run Invoker"
  description  = "Used to run Cloud Run"
}

resource "google_project_iam_member" "cloudrun-invoker" {
  project = "cloudops-388321"
  role    = "roles/run.invoker"
  member  = google_service_account.service_account.member
}
