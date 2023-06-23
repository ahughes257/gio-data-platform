param (
    [Parameter(Mandatory = $true)]
    [string]$AccessToken,

    [Parameter(Mandatory = $true)]
    [string]$AccountName,

    [Parameter(Mandatory = $true)]
    [string]$ConfigFilePath,

    [Parameter(Mandatory = $true)]
    [string]$Environment
)

Import-Module $PSScriptRoot/../Modules/Purview/PurviewModule.psm1
Import-Module $PSScriptRoot/../Modules/ActiveDirectory/UsersAndGroups/ADGroups.psm1

$baseUrl = "https://$AccountName.purview.azure.com"

$config = Get-Content $ConfigFilePath 
$config = $config.Replace("__ENVIRONMENT__", $Environment) | ConvertFrom-Json

foreach ($collection in $config.Collections) 
{
    New-PurviewCollection -AccessToken $AccessToken -CollectionName $collection.Name -ApiVersion '2019-11-01-preview' -BaseUri $baseUrl -ParentCollectionName $collection.ParentCollectionName

    foreach ($permission in $collection.Permissions) 
    {      
      foreach($permissionGroup in $permission.GroupNames)   
      {
        #You need to get the policy each time to avoid 409 conflicts
        $policy = Get-PurviewPolicyByCollectionName -AccessToken $AccessToken -CollectionName $collection.Name -ApiVersion '2021-07-01-preview' -BaseUri $baseUrl
        $policyId = $policy.values[0].id
        $groupObjectId = Get-AdGroupObjectId -GroupName $permissionGroup

        #Assign a group to a role
        Add-PurviewPolicyRole -AccessToken $AccessToken -BaseUri $baseUrl -ApiVersion '2021-07-01-preview' -Policy $policy.values[0] -RoleName $permission.Group -GroupId $groupObjectId -CollectionName $collection.Name
      }
    }
}

