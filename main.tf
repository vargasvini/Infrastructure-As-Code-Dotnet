provider "azurerm"{
    version = "2.5.0"
    features {}
}

# terraform{
#     backend "azurerm" {
#         resource_group_name = "tf_rg_blobstorage"
#         storage_ccount_name = "tf_blobstorage"
#         container_name ="tfstate"
#         key = "terraform.tfstate"
#     }
    
# }

resource "azurerm_resource_group" "tf_rg_test" {
    name = "tfmainrg"
    location = "East US"
}

resource "azurerm_app_service_plan" "tf_plan_test" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.tf_rg_test.location
  resource_group_name = azurerm_resource_group.tf_rg_test.name
  kind                = "Linux"
  sku {
    tier = "Free"
    size = "F1"
  }
  reserved = true
}

resource "azurerm_app_service" "tf_as_test" {
  name                = "exampleappservicetf"
  location            = azurerm_resource_group.tf_rg_test.location
  resource_group_name = azurerm_resource_group.tf_rg_test.name
  app_service_plan_id = "${azurerm_app_service_plan.tf_plan_test.id}"
  enabled = true

  #https://github.com/hashicorp/terraform-provider-azurerm/issues/1560
  #só funciona em B1 PRA CIMA
  # site_config {
  #   dotnet_framework_version = "v4.0"
  #   scm_type                 = "LocalGit"
  #   use_32_bit_worker_process = false
  # }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
  
}