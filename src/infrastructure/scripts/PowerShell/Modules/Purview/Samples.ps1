#Sample Usage

Import-Module "$PSScriptRoot..\Purview\Modules\PurviewModule.psm1" -force
 

$baseUrl = "https://cap-defra-test.purview.azure.com"

 

# Usage:
$accessToken = 'BEARER TOKEN HERE'
 

# Get collections
$collections = Get-PurviewCollections -AccessToken $accessToken -ApiVersion '2019-11-01-preview' -BaseUri $baseUrl

 

$collectionName = 'NewCollection200'

 

# Create a new collection
New-PurviewCollection -AccessToken $accessToken -CollectionName $collectionName -ApiVersion '2019-11-01-preview' -BaseUri $baseUrl -ParentCollectionName "cap-defra-test"

 

# Get policies
$policies = Get-PurviewPolicies -AccessToken $accessToken -ApiVersion '2021-07-01-preview' -BaseUri $baseUrl

  

# Get policy for a specific collection
 

$policy = Get-PurviewPolicyByCollectionName -AccessToken $accessToken -CollectionName $collectionName -ApiVersion '2021-07-01-preview' -BaseUri $baseUrl


$jsonPolicy = $policy | ConvertTo-Json -Depth 100

 


# Update a policy
$policyId = $policy.values[0].id
#Update-PurviewPolicy -AccessToken $accessToken -PolicyId $policyId -CollectionName $collectionName -BaseUri $baseUrl -ApiVersion '2021-07-01-preview'

 

#Assign a group to a role
Add-PurviewPolicyRole -AccessToken $accessToken -BaseUri $baseUrl -ApiVersion '2021-07-01-preview' -Policy $policy.values[0] -RoleName 'data-source-administrator' -GroupId '3a3d99a1-57aa-46fa-bcc6-671c83cc0df4' -CollectionName $collectionName

 
