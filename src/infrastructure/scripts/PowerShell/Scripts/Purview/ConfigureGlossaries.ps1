param (
    [Parameter(Mandatory = $true)]
    [string]$AccountName,

    [Parameter(Mandatory = $true)]
    [string]$ConfigFilePath,

    [Parameter(Mandatory = $true)]
    [string]$Environment
)

Import-Module $PSScriptRoot/../../Modules/Purview/PurviewModule.psm1
$jsonFiles = Get-ChildItem -Path $ConfigFilePath -Filter "*.json" -Recurse

$baseUrl = "https://$AccountName.purview.azure.com"
$AccessToken = (Get-AzAccessToken -Resource "https://purview.azure.net").Token

foreach ($file in $jsonFiles) {
  Write-Host $file.FullName
  $config = Get-Content $file.FullName | ConvertFrom-Json

  Write-Host $config

  foreach ($glossary in $config.Glossaries) 
  {      
      Write-Host $glossary.Name "----------" $glossary.Description
   
        # Define experts and stewards as arrays of objects
        $experts = @()
        $stewards = @()

        foreach ($exp in $glossary.Experts)
        {
            $experts += @{
                    id = $exp.Id
                    info = $exp.Info
                }
        }

        foreach ($ste in $glossary.Stewards)
        {
            $stewards += @{
                    id = $ste.Id
                    info = $ste.Info
                }
        }

        Set-Glossary -accessToken $accessToken -glossaryName $glossary.Name -glossaryDescription $glossary.Description -experts $experts -stewards $stewards -BaseUri $baseUrl

  }
}
