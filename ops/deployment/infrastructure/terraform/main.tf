terraform {
    backend "gcs" {
        bucket = "cloud-resume-tf-state"
        prefix = "terraform/state"
    }
    required_providers {
      google = {
        source  = "hashicorp/google"
        version = "4.58.0"
      }
    }
    
}

provider "google" {
    project = "cloudresume-380001"
}

resource "google_storage_bucket" "cloud-resume-site" {
    name          = "test-cloud-resume-site"
    location      = "US"
    force_destroy = true

    uniform_bucket_level_access = true
}