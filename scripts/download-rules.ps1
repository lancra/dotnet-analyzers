[CmdletBinding()]
param (
    [Parameter()]
    [string]$RuleSet
)

Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/rulesets.csv" |
    ForEach-Object {
        if ($RuleSet -and $RuleSet -notin ($_.Name, $_.Directory)) {
            Write-Output "Skipping download for $($_.Name) rules"
            return
        }

        $rulesetDownloadPath = "$env:DOTNET_ANALYZERS_RULESETS/$($_.Directory)/download.ps1"

        Write-Output "Downloading $($_.Name) rules"
        & $rulesetDownloadPath
    }
