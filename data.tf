data "azurerm_resource_group" "rg" {
  name = "devops-stuff"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "dev-django-rest-api-cluster"
  resource_group_name = data.azurerm_resource_group.rg.name
}