provider "azurerm"{
    version = "2.5.0"
    features {}
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "East US"
}

resource "azurerm_container_group" "tfcg_test"{
    name = "infrastucture-as-code-api"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "public"
    dns_name_label = ""
}