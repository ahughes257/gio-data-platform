param (
    [Parameter(Mandatory = $true)]
    [string]$AccountName,

    [Parameter(Mandatory = $true)]
    [string]$ConfigFilePath
)

Import-Module $PSScriptRoot/../../Modules/Purview/PurviewModule.psm1

$config = Get-Content -Path $ConfigFilePath | ConvertFrom-Json

$baseUrl = "https://$AccountName.purview.azure.com"

$AccessToken = (Get-AzAccessToken -Resource "https://purview.azure.net").Token

foreach ($collection in $config) 
{
    Set-Collection -AccessToken $AccessToken -Collection $collection -ApiVersion 2019-11-01-preview -BaseUri $baseUrl 
}