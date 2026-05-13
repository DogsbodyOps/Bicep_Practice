# Bicep Practice

A collection of Azure Bicep learning projects, each demonstrating a different set of Azure resources and concepts.

---

## Projects

### [vm_with_keyvault](vm_with_keyvault/)

Deploy a secure Linux VM that authenticates to Key Vault using a Managed Identity — no passwords or secrets stored in the template.

**Resources deployed:**
- Resource Group
- Virtual Network + Subnet
- Network Security Group (SSH inbound only)
- Public IP Address
- Network Interface
- Ubuntu 24.04 LTS VM with system-assigned Managed Identity
- Key Vault (RBAC mode)

**Concepts covered:** subscription-scoped deployments, module composition, `dependsOn`, module outputs, `@secure()` params, `.bicepparam` files

**Deploy:**
```bash
az deployment sub create \
  --template-file vm_with_keyvault/main.bicep \
  --location ukwest \
  --name testDeployment \
  --parameters vm_with_keyvault/config.bicepparam
```

**Tear down:**
```bash
az group delete --name bicep-learning --yes
```

---

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) — Bicep is bundled, no separate install needed
- An active Azure subscription
- Logged in: `az login`

## Params files

Each project has a `config.bicepparam.example` — copy it to `config.bicepparam` and fill in your values before deploying. The actual `config.bicepparam` files are gitignored to avoid committing credentials.
