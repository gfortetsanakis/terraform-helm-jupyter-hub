resource "kubernetes_secret" "docker_registry_secret" {
  count = length(var.docker_registry_secret) != 0 ? 1 : 0

  metadata {
    name      = local.docker_registry_secret_name
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.docker_registry_secret["server"]}" = {
          "username" = var.docker_registry_secret["username"]
          "password" = var.docker_registry_secret["password"]
          "email"    = var.docker_registry_secret["email"]
          "auth"     = base64encode("${var.docker_registry_secret["username"]}:${var.docker_registry_secret["password"]}")
        }
      }
    })
  }
}

resource "helm_release" "jupyterhub" {
  chart            = "jupyterhub"
  name             = "jupyterhub"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://jupyterhub.github.io/helm-chart/"
  version          = "1.2.0"
  wait             = true

  values = [
    templatefile("${path.module}/templates/jupyterhub.yaml", {
      node_selector                     = var.node_selector
      storage_class                     = var.storage_class
      jupyter_service_account           = var.jupyter_service_account
      jupyter_notebook_image_name       = local.jupyter_notebook_image_name
      jupyter_notebook_image_tag        = local.jupyter_notebook_image_tag
      certificate_issuer                = var.certificate_issuer
      domain                            = var.domain
      spark_docker_registry_secret_name = local.docker_registry_secret_name
    })
  ]

  depends_on = [kubernetes_secret.docker_registry_secret]
}