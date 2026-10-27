provider "kind" {}

# Create the kind Kubernetes cluster
resource "kind_cluster" "voting_app" {
  name            = var.cluster_name
  node_image      = "kindest/node:${var.kubernetes_version}"
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    # Control plane node
    node {
      role = "control-plane"

      # Expose vote app on host port 8080, result app on 8081
      extra_port_mappings {
        container_port = 30000
        host_port      = 30000
        protocol       = "TCP"
      }
      extra_port_mappings {
        container_port = 30001
        host_port      = 30001
        protocol       = "TCP"
      }
    }

    # Worker node — runs the actual app pods
    node {
      role = "worker"
    }
  }
}
