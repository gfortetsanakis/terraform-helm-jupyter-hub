# Terraform module for jupyterhub

This module deploys a jupyterhub on a kubernetes cluster. 

## Module input parameters

| Parameter                | Type     | Description                                                                              |
| ------------------------ |--------- | ---------------------------------------------------------------------------------------- |
| namespace                | Required | The kubernetes namespace at which the jupyterhub chart will be deployed                  |
| domain                   | Required | The external DNS domain of the kubernetes cluster                                        |
| certificate_issuer       | Required | The name of the certificate issuer that will be used to issue certificate for the jupyter notebook UI |
| storage_class            | Required | The storage class used to created persistent volume claims for the chart                 |
| jupyter_service_account  | Required | The kubernetes service account used in the jupyter notebook pod                          |
| jupyter_notebook_image   | Required | The jupyter notebook image to be deployed by the chart                                   |
| docker_registry_server   | Optional | The docker registry from which to pull the jupyter notebook image. Default is docker hub |
| docker_registry_username | Optional | The username used to connect to the docker registry                                      |
| docker_registry_password | Optional | The password used to connect to the docker registry                                      |
| docker_registry_email    | Optional | The email account associated with the docker registry                                    |
| node_selector            | Optional | A map variable with nodeSelector labels applied when placing pods of the chart on the cluster |


## Module output parameters

| Parameter            | Description                              |
| -------------------- | ---------------------------------------- |
| jupyter_notebook_url | The URL of the deployed jupyter notebook |