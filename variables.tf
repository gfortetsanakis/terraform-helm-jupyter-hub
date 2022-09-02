variable "namespace" {
  description = "The kubernetes namespace at which the jupyterhub chart will be deployed."
}

variable "domain" {
  description = "The domain of the kubernetes cluster."
}

variable "certificate_issuer" {
  description = "The name of the certificate issuer that will be used to issue certificate for the jupyter notebook UI."
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

variable "docker_registry_secret" {
  description = "A map variable containing an image pull secret for connecting to the docker registry from which the jupyter notebook will be pulled."
  default     = {}
}

variable "node_selector" {
  description = "A map variable with nodeSelector labels applied when placing pods of the chart on the cluster."
  default     = {}
}