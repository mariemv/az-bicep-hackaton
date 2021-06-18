/*

Template: keyVault.bicep

*/

// Standard Parameters.
param kvName string
param azLoc string
param tenantId string
param kvAccessPolicies array

// Tag Parameters.
param kvTagName string
param kvTagEnvName string
param kvTagDeployedBy string

// Keyvault Template 
resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: kvName
  location: azLoc
  properties: {
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    accessPolicies: kvAccessPolicies
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: tenantId
    enableSoftDelete: true
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
  tags: {
    Name: kvTagName
    Environment: kvTagEnvName
    DeployedBy: kvTagDeployedBy
  }
}
