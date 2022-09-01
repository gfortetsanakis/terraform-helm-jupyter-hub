variable "namespace" {
  description = "The kubernetes namespace at which the jupyterhub chart will be deployed."
}

variable "domain" {
  description = "The domain of the kubernetes cluster."
}

variable "certificate_issuer" {
  description = "he name of the certificate issuer that will be used to issue certificate for the jupyter notebook UI."
}

variable "storage_class" {
  description = "The storage class used to created persistent volume claims for the chart."
}

variable "jupyter_service_account" {
  description = "The kubernetes service account used in the jupyter notebook pod."
}

variable "jupyter_notebook_image" {
  description = "The jupyter notebook image to be deployed by the chart."
}

variable "docker_registry_server" {
  description = "The docker registry from which to pull the jupyter notebook image. Default is docker hub."
  default     = "https://index.docker.io/v1/"
}

variable "docker_registry_username" {
  description = "The username used to connect to the docker registry."
  default     = ""
}

variable "docker_registry_password" {
  description = "The password used to connect to the docker registry."
  default     = ""
}

variable "docker_registry_email" {
  description = "The email account associated with the docker registry"
  default     = ""
}

variable "node_selector" {
  description = "A map variable with nodeSelector labels applied when placing pods of the chart on the cluster."
  default     = {}
}