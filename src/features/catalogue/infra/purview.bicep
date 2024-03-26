param purviewAccountName string
param location string = resourceGroup().location

resource purviewAccount 'Microsoft.Purview/accounts@2021-12-01' = {
  name: purviewAccountName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

output purviewAccountResourceId string = purviewAccount.id
