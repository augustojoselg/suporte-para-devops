# Outputs importantes
output "project_id" {
  description = "ID do projeto GCP"
  value       = var.gcp_project_id
}

output "instance_id" {
  description = "ID da instância Compute Engine"
  value       = google_compute_instance.main.id
}

output "instance_name" {
  description = "Nome da instância Compute Engine"
  value       = google_compute_instance.main.name
}

output "instance_external_ip" {
  description = "IP externo da instância"
  value       = google_compute_address.main.address
}

output "instance_internal_ip" {
  description = "IP interno da instância"
  value       = google_compute_instance.main.network_interface.0.network_ip
}

output "vpc_id" {
  description = "ID da VPC criada"
  value       = google_compute_network.main.id
}

output "subnet_id" {
  description = "ID da subnet criada"
  value       = google_compute_subnetwork.main.id
}

output "service_account_email" {
  description = "Email da Service Account"
  value       = google_service_account.main.email
}

output "artifact_registry_url" {
  description = "URL do Artifact Registry"
  value       = "${var.gcp_region}-docker.pkg.dev/${var.gcp_project_id}/${google_artifact_registry_repository.main.repository_id}"
}

output "ssh_connection" {
  description = "Comando para conectar via SSH"
  value       = "ssh -i ~/.ssh/gcp-key.pem ${var.client_name}@${google_compute_address.main.address}"
}

output "gcloud_ssh_connection" {
  description = "Comando gcloud para conectar via SSH"
  value       = "gcloud compute ssh ${google_compute_instance.main.name} --zone=${var.gcp_zone} --project=${var.gcp_project_id}"
}
