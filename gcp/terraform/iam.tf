# Service Account para a VM
resource "google_service_account" "main" {
  account_id   = "vm-${var.client_name}-${var.environment}"
  display_name = "Service Account para VM ${var.client_name} ${var.environment}"
  description  = "Service Account criada via Terraform"
}

# IAM Binding para Container Registry
resource "google_project_iam_member" "storage_object_viewer" {
  project = var.gcp_project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.main.email}"
}

resource "google_project_iam_member" "storage_object_admin" {
  project = var.gcp_project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.main.email}"
}

# IAM Binding para Artifact Registry
resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.gcp_project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.main.email}"
}

resource "google_project_iam_member" "artifact_registry_writer" {
  project = var.gcp_project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.main.email}"
}
