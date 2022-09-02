locals {
  jupyter_notebook_image_name   = split(":", var.jupyter_notebook_image)[0]
  jupyter_notebook_image_tag    = split(":", var.jupyter_notebook_image)[1]
  create_docker_registry_secret = (var.docker_registry_username != "") && (var.docker_registry_password != "") ? true : false
  docker_registry_secret_name   = local.create_docker_registry_secret ? "spark-docker-registry-secret" : ""
}