[CmdletBinding()]
param (
    [Parameter()]
    [string]$RuleSet
)

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
