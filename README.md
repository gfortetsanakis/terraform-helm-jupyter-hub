# Terraform module for jupyterhub

This module deploys the following helm chart on a kubernetes cluster:

| Name       | Repository                               | Version |
| ---------- | ---------------------------------------- | ------- |
| jupyterhub | https://jupyterhub.github.io/helm-chart/ | 1.2.0   |

## Module input parameters

| Parameter               | Type     | Description                                                                                                                               |
| ----------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| namespace               | Required | The kubernetes namespace at which the jupyterhub chart will be deployed                                                                   |
| domain                  | Required | The external DNS domain of the kubernetes cluster                                                                                         |
| certificate_issuer      | Required | The name of the certificate issuer that will be used to issue certificate for the jupyter notebook UI                                     |
| storage_class           | Required | The storage class used to created persistent volume claims for the chart                                                                  |
| jupyter_service_account | Required | The kubernetes service account used in the jupyter notebook pod                                                                           |
| jupyter_notebook_image  | Required | The jupyter notebook image to be deployed by the chart                                                                                    |
| docker_registry_secret  | Optional | A map variable containing an image pull secret for connecting to the docker registry from which the jupyter notebook image will be pulled |
| node_selector           | Optional | A map variable with nodeSelector labels applied when placing pods of the chart on the cluster                                             |

The structure of the input variable "docker_registry_secret" is as follows:

```
docker_registry_secret = {
  server   = <docker_registry_server>
  username = <docker_registry_username>
  password = <docker_registry_password>
  email    = <docker_registry_email_account>
}
```

## Module output parameters

| Parameter            | Description                              |
| -------------------- | ---------------------------------------- |
| jupyter_notebook_url | The URL of the deployed jupyter notebook |