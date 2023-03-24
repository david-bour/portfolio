variable project_id {
  type        = string
  default     = ""
  description = "project id"
}

variable zone {
    type        = string
    default     = ""
    description = "gcp zone"
}

variable region {
    description = "region"
}

provider google {
    project = var.project_id
    region  = var.region
}

resource google_compute_network vpc {
    name                    = "${var.project_id}-vpc"
    auto_create_subnetworks = "false"
}

resource google_compute_subnetwork subnet {
    name          = "${var.project_id}-subnet"
    region        = var.region
    network       = google_compute_network.vpc.name
    # First IP: 10.10.0.0, Last IP: 10.10.0.255 - Total host: 256
    ip_cidr_range = "10.10.0.0/24"
}

