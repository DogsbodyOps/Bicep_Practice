Deploy a secure Linux VM that authenticates to Key Vault without any passwords or secrets.
Specifically, by the end you should have:

A Resource Group to contain everything
A Virtual Network + Subnet for the VM to live in
A Network Security Group attached to the subnet, with rules allowing SSH inbound (and nothing else)
A Linux VM (Ubuntu) with:

A system-assigned Managed Identity enabled on it
SSH key authentication only (no password login)


A Key Vault with:

Azure RBAC mode enabled (not the older Access Policies model)
A role assignment granting the VM's Managed Identity the Key Vault Secrets User role


A test secret stored in the Key Vault
Parameterised so VM size, location, admin username, and Key Vault name can all be swapped out without touching the template itself

## Deploy Resources
```
az deployment sub create --template-file vm_with_keyvault/main.bicep --location ukwest --name testDeployment --parameters vm_with_keyvault/config.bicepparam
```

## Delete Resources
```
az group delete --name bicep-learning
```