//Parameters for the Resource group
param resourceGroup_name string
param resourceGroup_location string
param managedByUser string
param deploymentTime string

resource nsg 'Microsoft.Network/networkSecurityGroups@2025-01-01' = {
  name: '${resourceGroup_name}-nsg'
  location: resourceGroup_location
  tags: {
    environment: 'bicep-learning'
    managedBy: managedByUser
    lastDeployed: deploymentTime
  }
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '217.155.49.58/32'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
        }
      }
    ]
  }
}
