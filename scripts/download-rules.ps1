<#
.SYNOPSIS
Downloads configured ruleset metadata from their remote sources.

.DESCRIPTION
Executes the download script for all rulesets provided in the dataset file, or
the selected ruleset if provided as a parameter. Rulesets are stored as JSON
within their respective directories.

.PARAMETER RuleSet
Specifies the ruleset to download metadata for. Metadata is downloaded for all
rulesets when this is not provided.
#>
[CmdletBinding()]
param (
    [Parameter()]
    [string] $RuleSet
)

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Get-RuleSet.ps1"

Get-RuleSet |
    ForEach-Object {
        if ($RuleSet -and $_.Id -ne $RuleSet) {
            Write-Output "Skipping download for $($_.Name) rules"
            return
        }

        $ruleSetDownloadPath = "$env:DOTNET_ANALYZERS_RULE_SETS/$($_.Id)/download.ps1"

        Write-Output "Downloading $($_.Name) rules"
        & $ruleSetDownloadPath
    }
