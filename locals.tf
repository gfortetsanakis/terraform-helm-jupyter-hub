locals {
  jupyter_notebook_image_name   = split(":", var.jupyter_notebook_image)[0]
  jupyter_notebook_image_tag    = split(":", var.jupyter_notebook_image)[1]
  docker_registry_secret_name   = length(var.docker_registry_secret) != 0 ? "spark-docker-registry-secret" : ""
}