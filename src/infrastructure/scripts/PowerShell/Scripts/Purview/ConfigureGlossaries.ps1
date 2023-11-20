param (
    [Parameter(Mandatory = $true)]
    [string]$AccountName,

    [Parameter(Mandatory = $true)]
    [string]$ConfigFilePath,
    
    [Parameter(Mandatory = $true)]
    [string]$Environment
)

Import-Module $PSScriptRoot/../../Modules/Purview/PurviewModule.psm1 -Force
$jsonFiles = Get-ChildItem -Path $ConfigFilePath -Filter "*.json" -Recurse

$baseUrl = "https://$AccountName.purview.azure.com"

$AccessToken = (Get-AzAccessToken -Resource "https://purview.azure.net").Token


foreach ($file in $jsonFiles) 
{
  $config = Get-Content $file.FullName | ConvertFrom-Json

  foreach ($glossary in $config.Glossaries) 
  {  
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

        $id = Set-Glossary -accessToken $accessToken -glossaryName $glossary.Name -glossaryDescription $glossary.Description -experts $experts -stewards $stewards -BaseUri $baseUrl
      
        Write-Host "Setting GlossaryTerms"
        foreach($term in $glossary.Terms)
        {
            Set-GlossaryTerm -accessToken $accessToken -glossaryName $glossary.Name -BaseUri $baseUrl -TermObject $term -GlossaryId $id.guid
        } 

        Write-Host "Setting Glossary Workflows"
        foreach($workflow in $glossary.WorkFlows)
        {
            Set-Workflow -AccessToken $AccessToken -WorkFlow $workflow -BaseUri $baseUrl -GlossaryId $id.guid
        }         

  }
}
