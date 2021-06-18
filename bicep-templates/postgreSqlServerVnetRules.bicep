/*

Template: postgreSqlServerVnetRules.bicep

*/

// Standard Parameters.
param postgreSqlServerName string
param postgreSqlServerVirtualNetworkSubnetName string
param virtualNetworkSubnetId string

resource postgreSqlServerVnetRule 'Microsoft.DBforPostgreSQL/servers/virtualNetworkRules@2017-12-01' = {
  name: '${postgreSqlServerName}/${postgreSqlServerVirtualNetworkSubnetName}'
  properties: {
    virtualNetworkSubnetId: virtualNetworkSubnetId
    ignoreMissingVnetServiceEndpoint: true
  }
}
