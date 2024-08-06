provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id
}


resource "azurerm_resource_group" "rgint" {
  name     = var.resource_group_int_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "vnetint" {
  name                = var.vnetint_name
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rgint.name
  address_space       = ["10.3.0.0/16"]
}

resource "azurerm_subnet" "snetpgsql" {
  name                 = var.snetint_name
  resource_group_name = azurerm_resource_group.rgint.name
  virtual_network_name = azurerm_virtual_network.vnetint.name
  address_prefixes     = ["10.3.1.0/24"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      }
  }
}

resource "azurerm_private_dns_zone" "dnszonepgsql"  {
  name                = var.dns_zone_pg_name
  resource_group_name = azurerm_resource_group.rgint.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vlinkpgsql" {
  name                  = var.vnetlink_pg_name
  private_dns_zone_name = azurerm_private_dns_zone.dnszonepgsql.name
  virtual_network_id    = azurerm_virtual_network.vnetint.id
  resource_group_name =   azurerm_resource_group.rgint.name
}

resource "azurerm_virtual_network" "vnetext" {
  name                = var.vnetext_name
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rgint.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "snetusersmanagement" {
  name                 = var.snetext_name
  resource_group_name = azurerm_resource_group.rgint.name
  virtual_network_name = azurerm_virtual_network.vnetext.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_private_dns_zone" "dnszoneusersmanagement"  {
  name                = var.dns_zone_ext_name
  resource_group_name = azurerm_resource_group.rgint.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vlinkusersmanagement" {
  name                  = var.vnetlink_ext_name
  resource_group_name = azurerm_resource_group.rgint.name
  private_dns_zone_name = azurerm_private_dns_zone.dnszoneusersmanagement.name
  virtual_network_id    = azurerm_virtual_network.vnetext.id
}

# resource "azurerm_private_endpoint" "peext" {
#   name                = var.pe_usermanagement
#   location            = var.resource_group_location
#   resource_group_name = azurerm_resource_group.rgint.name
#   subnet_id           = azurerm_subnet.snetusersmanagement.id

#   private_service_connection {
#     name                           = var.pe_connection_name
#     private_connection_resource_id = azurerm_linux_web_app.wausersmanagement.id
#     is_manual_connection           = false
#     subresource_names              = ["sites"]
#   }
# }
