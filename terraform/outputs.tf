# The kubeconfig Terraform writes after creating the cluster.
# Use this to connect kubectl to the cluster:
#   $env:KUBECONFIG = (terraform output -raw kubeconfig_path)
output "kubeconfig_path" {
  description = "Path to the kubeconfig file for the kind cluster"
  value       = kind_cluster.voting_app.kubeconfig_path
}

output "cluster_name" {
  description = "Name of the created kind cluster"
  value       = kind_cluster.voting_app.name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = kind_cluster.voting_app.endpoint
}
