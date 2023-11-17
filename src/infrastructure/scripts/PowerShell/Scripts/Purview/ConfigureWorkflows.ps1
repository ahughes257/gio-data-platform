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

foreach ($file in $jsonFiles) 
{
  $workflow = Get-Content $file.FullName | ConvertFrom-Json

  Set-Workflow -AccessToken $AccessToken -WorkFlow $workflow -BaseUri $baseUrl     
}