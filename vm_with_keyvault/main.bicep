// set scope
targetScope = 'subscription'

// Various required parameters
param resourceGroup_name string
param resourceGroup_location string
param managedByUser string
param lastDeployed string = utcNow()
param adminUsername string

@secure()
param adminPassword string


module rg 'modules/resourceGroup.bicep' = {
  name: 'resourceGroupDeployment'
  params: {
    resourceGroup_name: resourceGroup_name
    resourceGroup_location: resourceGroup_location
    managedByUser: managedByUser
    deploymentTime: lastDeployed
  }
}

module vnet 'modules/vnet.bicep' = {
  name: 'vnetDeployment'
  scope: resourceGroup(resourceGroup_name)
  dependsOn: [rg]
  params: {
    resourceGroup_name: resourceGroup_name
    resourceGroup_location: resourceGroup_location
    managedByUser: managedByUser
    deploymentTime: lastDeployed
  }
}

module keyvault 'modules/keyvault.bicep' = {
  name: 'keyvaultDeployment'
  scope: resourceGroup(resourceGroup_name)
  dependsOn: [rg]
  params: {
    resourceGroup_name: resourceGroup_name
    resourceGroup_location: resourceGroup_location
    managedByUser: managedByUser
    deploymentTime: lastDeployed
  }
}

module nsg 'modules/nsg.bicep' = {
  name: 'nsgDeployment'
  scope: resourceGroup(resourceGroup_name)
  dependsOn: [rg]
  params: {
    resourceGroup_name: resourceGroup_name
    resourceGroup_location: resourceGroup_location
    managedByUser: managedByUser
    deploymentTime: lastDeployed
  }
}

module vm 'modules/vm.bicep' = {
  name: 'vmDeployment'
  scope: resourceGroup(resourceGroup_name)
  dependsOn: [
    rg
    vnet
    nsg
  ]
  params: {
    resourceGroup_name: resourceGroup_name
    resourceGroup_location: resourceGroup_location
    managedByUser: managedByUser
    deploymentTime: lastDeployed
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}


output vmPublicIp string = vm.outputs.publicIpAddress
