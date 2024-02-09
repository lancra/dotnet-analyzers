[CmdletBinding()]
param (
    [Parameter()]
    [string]$RuleSet
)

Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-sets.csv" |
    ForEach-Object {
        if ($RuleSet -and $RuleSet -notin ($_.Name, $_.Directory)) {
            Write-Output "Skipping download for $($_.Name) rules"
            return
        }

        $ruleSetDownloadPath = "$env:DOTNET_ANALYZERS_RULE_SETS/$($_.Directory)/download.ps1"

        Write-Output "Downloading $($_.Name) rules"
        & $ruleSetDownloadPath
    }
