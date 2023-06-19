# Module manifest
$ModuleVersion = '1.0.0'
$Author = 'Your Name'
$Description = 'Module to retrieve Ad Group object ID'

# Required modules
RequiredModules = 'AzureAD'

# Functions
Function Get-AdGroupObjectId {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [String]$GroupName
    )

    # Connect to Azure AD
    Connect-AzureAD

    # Get the group object
    $group = Get-AzureADGroup -Filter "DisplayName eq '$GroupName'"

    # Check if the group object is found
    if ($group) {
        # Display the group object ID
        Write-Output "Group Object ID: $($group.ObjectId)"
    } else {
        Write-Output "Group not found."
    }
}
