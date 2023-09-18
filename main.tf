resource "azurerm_resource_group" "rg" {
  location = local.primary_region
  name     = "rg-${local.resource_suffix}"

  tags = merge(local.default_tags, { Name = "rg-${local.resource_suffix}" })
}

resource "azurerm_virtual_network" "vnet" {
  for_each = local.vnets

  name                = "vnet-${each.key}.${local.resource_suffix}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = [each.value.cidr_block]

  tags = merge(local.default_tags, { Name = "vnet-${each.key}.${local.resource_suffix}" })
}

resource "azurerm_subnet" "snet" {
  for_each = local.subnets

  name                 = "snet-${each.key}-${local.resource_suffix}"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = [each.value.cidr_block]
}