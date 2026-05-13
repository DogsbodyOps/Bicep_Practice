// Sets the scope of the bicep deployment
targetScope = 'subscription'

//Parameters for the Resource group
param resourceGroup_name string
param resourceGroup_location string
param managedByUser string
param deploymentTime string

// Defines the Resource group to be used
resource bicepLearning 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  location: resourceGroup_location
  name: resourceGroup_name
  managedBy: managedByUser
  tags: {
    environment: 'bicep-learning'
    managedBy: managedByUser
    lastDeployed: deploymentTime
  }
}
