/*

Template: postgreSqlServerFirewallRules.bicep

*/

// Standard Parameters.
param postgreSqlServerName string
param postgreSqlServerFirewallRuleName string
param postgreSqlServerFirewallRuleStartIp string
param postgreSqlServerFirewallRuleEndIp string

resource postgreSqlServerFirewallRule 'Microsoft.DBforPostgreSQL/servers/firewallRules@2017-12-01' = {
  name: '${postgreSqlServerName}/${postgreSqlServerFirewallRuleName}'
  properties: {
    startIpAddress: postgreSqlServerFirewallRuleStartIp
    endIpAddress: postgreSqlServerFirewallRuleEndIp
  }
}
