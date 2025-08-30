# Habilitar APIs necessárias
resource "google_project_service" "artifact_registry" {
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

# Artifact Registry Repository
resource "google_artifact_registry_repository" "main" {
  depends_on = [google_project_service.artifact_registry]
  
  location      = var.gcp_region
  repository_id = "app-${var.environment}"
  description   = "Repository Docker criado via Terraform"
  format        = "DOCKER"

  labels = {
    environment = var.environment
    provisioned = "terraform"
    cliente     = var.client_name
  }
}
