/*

Template: postgreSqlServer.bicep

*/

// Standard Parameters.
param azLoc string
param postgreSqlServerName string
param postgreSqlServerSkuName string
param postgreSqlServerSkuTier string
param postgreSqlServerSkuCapacity int
param postgreSqlServerSkuFamily string
param postgreSqlServerBackupRetentionDays int
param postgreSqlServerGeoRedundantBackup string
param postgreSqlServerStorageMb int
param postgreSqlServerStorageAutogrow string
param postgreSqlServerAdministratorLogin string
param postgreSqlServerVersion string
param postgreSqlServerSslEnforcement string
param postgreSqlServerMinimalTlsVersion string
param postgreSqlServerInfrastructureEncryption string
param postgreSqlServerPublicNetworkAccess string

// Secured Parameters.
@secure()
param postgreSqlServerAdministratorLoginPassword string

// Tag Parameters.
param tagName string
param tagEnvName string
param tagDeployedBy string

resource postgreSqlServer 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
  name: postgreSqlServerName
  location: azLoc
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: postgreSqlServerSkuName
    tier: postgreSqlServerSkuTier
    capacity: postgreSqlServerSkuCapacity
    family: postgreSqlServerSkuFamily
  }
  properties: {
    storageProfile: {
      backupRetentionDays: postgreSqlServerBackupRetentionDays
      geoRedundantBackup: postgreSqlServerGeoRedundantBackup
      storageMB: postgreSqlServerStorageMb
      storageAutogrow: postgreSqlServerStorageAutogrow
    }
    createMode: 'Default'
    administratorLogin: postgreSqlServerAdministratorLogin
    administratorLoginPassword: postgreSqlServerAdministratorLoginPassword
    version: postgreSqlServerVersion
    sslEnforcement: postgreSqlServerSslEnforcement
    minimalTlsVersion: postgreSqlServerMinimalTlsVersion
    infrastructureEncryption: postgreSqlServerInfrastructureEncryption
    publicNetworkAccess: postgreSqlServerPublicNetworkAccess
  }
  tags: {
    Name: tagName
    Environment: tagEnvName
    DeployedBy: tagDeployedBy
  }
}
