param (
    [Parameter(Mandatory = $true)]
    [string]$AccountName,

    [Parameter(Mandatory = $true)]
    [string]$ConfigFilePath
)

Import-Module $PSScriptRoot/../../Modules/Purview/PurviewModule.psm1

$jsonFiles = Get-ChildItem -Path $ConfigFilePath -Filter "*.json" -Recurse

$baseUrl = "https://$AccountName.purview.azure.com"

$AccessToken = (Get-AzAccessToken -Resource "https://purview.azure.net").Token

foreach ($file in $jsonFiles) {
  Write-Host $file.FullName
  $config = Get-Content $file.FullName 

  foreach ($collection in $config.Collections) 
  {
      foreach ($permission in $collection.Permissions) 
      {      
        foreach($permissionGroup in $permission.GroupNames)   
        {
          Write-Host "Updating Policy for $permissionGroup"
          $policy = Get-PurviewPolicyByCollectionName -AccessToken $AccessToken -CollectionName $collection.Name -ApiVersion '2021-07-01-preview' -BaseUri $baseUrl
         
          #Assign a group to a role
          Add-PurviewPolicyRole -AccessToken $AccessToken -BaseUri $baseUrl -ApiVersion '2021-07-01-preview' -Policy $policy.values[0] -RoleName $permission.Group -GroupId $permissionGroup -CollectionName $collection.Name
          Write-Host "Added group with id $permissionGroup to the $permissionGroup role"
        }
      }
  }
}

