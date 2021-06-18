/*

Template: postgreSqlServerDb.bicep

*/

// Standard Parameters.
param postgreSqlServerName string
param postgreSqlServerDbName string

resource postgreSqlServerDb 'Microsoft.DBForPostgreSQL/servers/databases@2017-12-01' = {
  name: '${postgreSqlServerName}/${postgreSqlServerDbName}'
  properties:{
    collation: 'nb_NO.UTF8'
  }
}
