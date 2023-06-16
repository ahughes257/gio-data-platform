#Sample Usage

Import-Module "$PSScriptRoot..\Purview\Modules\PurviewModule.psm1" -force
 

$baseUrl = "https://cap-defra-test.purview.azure.com"

 

# Usage:
$accessToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyIsImtpZCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyJ9.eyJhdWQiOiI3M2MyOTQ5ZS1kYTJkLTQ1N2EtOTYwNy1mY2M2NjUxOTg5NjciLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9mNmRkMTg1NC1hNDRkLTQ1YTUtOTUzNy1jODA5YTVkNzZjNzQvIiwiaWF0IjoxNjg2ODM5ODg5LCJuYmYiOjE2ODY4Mzk4ODksImV4cCI6MTY4Njg0NTE1NiwiYWNyIjoiMSIsImFpbyI6IkFUUUF5LzhUQUFBQXNsdTRSRExOcHVQdHlEMmg2MUNpZ1ZLT2hoSzBXMmZTVmx0aUt0TU9qcUh5MTcxUXJ2UTZnbFJ5ck5JN05HTDciLCJhbXIiOlsicHdkIl0sImFwcGlkIjoiNjMyZDgwM2EtYjBjMi00OWI0LWE5NDQtZTEzYzM4NGMwNGE4IiwiYXBwaWRhY3IiOiIwIiwiZmFtaWx5X25hbWUiOiJDdW5uaW5naGFtIiwiZ2l2ZW5fbmFtZSI6Ik1hcmsiLCJpcGFkZHIiOiI4Ni4xNTYuMTEwLjE4NiIsIm5hbWUiOiJNYXJrIEN1bm5pbmdoYW0iLCJvaWQiOiI3M2FkOWZhMy1hZjk1LTQ5ZjItYWQwNS1iNDNkOTFlNzM3ZDgiLCJwdWlkIjoiMTAwMzIwMDBEQTRCQ0QxOSIsInJoIjoiMC5BVjRBVkJqZDlrMmtwVVdWTjhnSnBkZHNkSjZVd25NdDJucEZsZ2Y4eG1VWmlXZGVBSE0uIiwic2NwIjoiZGVmYXVsdCIsInN1YiI6InR5YmRBZENMSTFEQ0dNLTFFcTdWS2pEQXFNY05xSFVRbWRnWjAtNm1CNmciLCJ0aWQiOiJmNmRkMTg1NC1hNDRkLTQ1YTUtOTUzNy1jODA5YTVkNzZjNzQiLCJ1bmlxdWVfbmFtZSI6Im1hcmsuY3VubmluZ2hhbUBjYXBnZW1pbmljc2R1ay5vbm1pY3Jvc29mdC5jb20iLCJ1cG4iOiJtYXJrLmN1bm5pbmdoYW1AY2FwZ2VtaW5pY3NkdWsub25taWNyb3NvZnQuY29tIiwidXRpIjoiaDEydjZHZTFPRUN6NVlDYWszc3lBQSIsInZlciI6IjEuMCJ9.ZxB7k4IRHFOdSt-CKimvWYvCBl37LflgK92Kfs0L2A9zsm--5VTYRqEgh1A0c3F51QN_cjwDsfhlFFWtSWqJHF7jNAYpZHNLr7N_8ijw_LWoq_nIElDbj0-4COXy9IMLKDzRT_p5LyZh6iTfJ055ySxkTW8zPyOButDJUTVvJeFSJ7nSvcWr8B8fLFbF8dHrHczH30_-kcFYZolxQSUj1y0PrQWB_uE7GGuwDC2y0zYeFs8RbVOv-mJbHtYMCpWRf3TLNFeNSrWCt3aOvoDZVOnc4Y5yL3NwHZXfAYjDL-g2X6r7UhlEOJXdwz57-3tIxPbcQl-SELS8YTPg8qSBRQ'

 

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

 
