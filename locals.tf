locals {
  default_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    CostCenter  = "1"
    Application = "X"
    Owner       = "dameda@test.com"
  }

  primary_region = "switzerlandnorth"
  resource_suffix = "prod-nch"

  vnets = {
    main = {
      resource_group_name = azurerm_resource_group.rg.name
      location            = local.primary_region
      cidr_block          = "10.0.0.0/16"
    }
  }

  subnets = {
    web = {
      resource_group_name = azurerm_resource_group.rg.name
      cidr_block          = "10.0.0.0/24"
      vnet_name           = azurerm_virtual_network.vnet["main"].name
    },
    business = {
      resource_group_name = azurerm_resource_group.rg.name
      cidr_block          = "10.0.1.0/24"
      vnet_name           = azurerm_virtual_network.vnet["main"].name
    },
    data = {
      resource_group_name = azurerm_resource_group.rg.name
      cidr_block          = "10.0.2.0/24"
      vnet_name           = azurerm_virtual_network.vnet["main"].name
    }
  }
}