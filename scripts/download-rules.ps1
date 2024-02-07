[CmdletBinding()]
param ()

Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/rulesets.csv" |
    ForEach-Object {
        $rulesetDownloadPath = "$env:DOTNET_ANALYZERS_RULESETS/$($_.Directory)/download.ps1"

        Write-Output "Downloading $($_.Name) rules"
        & $rulesetDownloadPath
    }
