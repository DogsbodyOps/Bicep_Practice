// pull in Parameters defined in config.bicepparam
param resourceGroup_name string
param resourceGroup_location string
param managedByUser string
param deploymentTime string

resource keyvault 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: '${resourceGroup_name}-kv'
  location: resourceGroup_location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
  }
  tags: {
    environment: 'bicep-learning'
    managedBy: managedByUser
    lastDeployed: deploymentTime
  }
}
