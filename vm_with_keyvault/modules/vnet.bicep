

// pull in Parameters defined in config.bicepparam
param resourceGroup_name string
param resourceGroup_location string
param managedByUser string
param deploymentTime string

resource vnet 'Microsoft.Network/virtualNetworks@2025-01-01' = {
  name: '${resourceGroup_name}-vnet'
  location: resourceGroup_location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  tags: {
    environment: 'bicep-learning'
    managedBy: managedByUser
    lastDeployed: deploymentTime
  }
  resource subnet 'subnets' = {
    name: '${resourceGroup_name}-subnet'
    properties: {
      addressPrefix: '10.0.0.0/24'
    }
  }
}
