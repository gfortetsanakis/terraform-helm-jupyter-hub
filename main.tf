locals {
  jupyter_notebook_image_name   = split(":", var.jupyter_notebook_image)[0]
  jupyter_notebook_image_tag    = split(":", var.jupyter_notebook_image)[1]
  create_docker_registry_secret = (var.docker_registry_username != "") && (var.docker_registry_password != "") ? true : false
  docker_registry_secret_name   = local.create_docker_registry_secret ? "spark-docker-registry-secret" : ""
}

resource "kubernetes_secret" "docker_registry_secret" {
  count = local.create_docker_registry_secret ? 1 : 0

  metadata {
    name      = local.docker_registry_secret_name
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.docker_registry_server}" = {
          "username" = var.docker_registry_username
          "password" = var.docker_registry_password
          "email"    = var.docker_registry_email
          "auth"     = base64encode("${var.docker_registry_username}:${var.docker_registry_password}")
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