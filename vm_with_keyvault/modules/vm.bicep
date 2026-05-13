//Parameters for the Resource group
param resourceGroup_name string
param resourceGroup_location string
param managedByUser string
param deploymentTime string
param adminUsername string

@secure()
param adminPassword string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: '${resourceGroup_name}-vm'
  location: resourceGroup_location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: '${resourceGroup_name}-vm'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
  tags: {
    environment: 'bicep-learning'
    managedBy: managedByUser
    lastDeployed: deploymentTime
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2025-01-01' = {
  name: '${resourceGroup_name}-pip'
  location: resourceGroup_location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  tags: {
    environment: 'bicep-learning'
    managedBy: managedByUser
    lastDeployed: deploymentTime
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2025-01-01' = {
  name: '${resourceGroup_name}-nic'
  location: resourceGroup_location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', '${resourceGroup_name}-vnet', '${resourceGroup_name}-subnet')
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', '${resourceGroup_name}-nsg')
    }
  }
}

output publicIpAddress string = publicIp.properties.ipAddress
