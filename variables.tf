variable subscription_id {
  type = string
}

variable resource_group_int_name {
  type = string
  default = "rg-int"
}

variable resource_group_location {
  type = string
  default = "West Europe"
}

variable vnetint_name {
  type = string
  default = "vnet-int"

}

variable snetint_name {
  type = string
  default = "snet-int"
}

variable dns_zone_pg_name {
  type = string
  default = "plink.postgres.database.azure.com"
}

variable vnetlink_pg_name {
  type = string
  default = "vnetlink-pg"
}

variable tenant_id {
  type = string
  default = "c9ad96a7-2bac-49a7-abf6-8e932f60bf2b"
}

variable vnetext_name {
  type = string
  default = "vnet-ext"
}

variable snetext_name {
  type = string
  default = "snet-ext"
}

variable dns_zone_ext_name {
  type = string
  default = "plink.ext.azurewebsites.net"
}

variable vnetlink_ext_name {
  type = string
  default = "vnetlink-ext"
}