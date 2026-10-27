variable "cluster_name" {
  description = "Name of the kind Kubernetes cluster"
  type        = string
  default     = "voting-app-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes node image version to use for the cluster"
  type        = string
  default     = "v1.32.2"
}
