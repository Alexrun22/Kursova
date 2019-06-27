resource "azurerm_resource_group" "terra" {
  name     = "terragroup"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "terra" {
  name                = "terra-serviceplan"
  location            = "${azurerm_resource_group.terra.location}"
  resource_group_name = "${azurerm_resource_group.terra.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "terra" {
  name                = "terra-app-service"
  location            = "${azurerm_resource_group.terra.location}"
  resource_group_name = "${azurerm_resource_group.terra.name}"
  app_service_plan_id = "${azurerm_app_service_plan.terra.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
 
  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}