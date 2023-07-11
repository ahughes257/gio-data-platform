param (
    [Parameter(Mandatory = $true)]
    [string]$AccountName,

    [Parameter(Mandatory = $true)]
    [string]$ConfigFilePath,

    [Parameter(Mandatory = $true)]
    [string]$Environment
)

Import-Module $PSScriptRoot/../Modules/Purview/PurviewModule.psm1
$jsonFiles = Get-ChildItem -Path $ConfigFilePath -Filter "*.json" -Recurse

$baseUrl = "https://$AccountName.purview.azure.com"
$AccessToken = (Get-AzAccessToken -Resource "https://purview.azure.net").Token

Write-Host "Found" $jsonFiles.Length "files"

Write-Host $AccessToken

foreach ($file in $jsonFiles) {
  Write-Host $file.FullName
  $config = Get-Content $file.FullName | ConvertFrom-Json

Write-Host $config

  foreach ($classification in $config.Classifications) 
  {      
      Write-Host $classification.Name "----------" $classification.Description
      
      New-Classification -AccessToken $AccessToken -ClassificationName $classification.Name -ClassificationDescription $classification.Description -ApiVersion '2019-11-01-preview' -BaseUri $baseUrl
  }
}

