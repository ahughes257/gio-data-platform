param purviewAccountName string
param location string = resourceGroup().location

resource purviewAccount 'Microsoft.Purview/accounts@2021-07-01-preview' = {
  name: purviewAccountName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

output purviewAccountResourceId string = purviewAccount.id
