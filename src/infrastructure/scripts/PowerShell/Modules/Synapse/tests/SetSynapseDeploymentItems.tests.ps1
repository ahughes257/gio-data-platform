# Before running this script ensure az module is installed and you are logged in to Azure

Describe "SetSynapseDeploymentItemsTest" {
    Context "Exists" {

            It "Runs" {

                Copy-Item "$PSScriptRoot\testFiles\TemplateForWorkspace.json" -Destination "$PSScriptRoot\testFiles\TemplateForWorkspaceTest.json" -Force

                $scriptPath = "$PSScriptRoot\..\SetSynapseDeploymentItems.ps1"

                & "$scriptPath" `
                    -IncludedTypes "Microsoft.Synapse/workspaces/pipelines,Microsoft.Synapse/workspaces/notebooks,Microsoft.Synapse/workspaces/dataflows" `
                    -SourceFileFullPath "$PSScriptRoot\testFiles\TemplateForWorkspaceTest.json" `
                    -IncludedFolders "Ingestion"
            }
    }
}
