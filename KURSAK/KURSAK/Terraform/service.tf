resource "azurerm_resource_group" "terra" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_app_service_plan" "terra" {
  name                = "${var.prefix}-asp"
  location            = azurerm_resource_group.terra.location
  resource_group_name = azurerm_resource_group.terra.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-appservice"
  location            = azurerm_resource_group.terra.location
  resource_group_name = azurerm_resource_group.terra.name
  app_service_plan_id = azurerm_app_service_plan.terra.id

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|mcnac/lab3:latest"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
  }
}

