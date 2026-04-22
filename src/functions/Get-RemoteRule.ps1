function Get-RemoteRule {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string] $RuleSet
    )

    Get-RuleSet |
        ForEach-Object {
            if ($RuleSet -and $_.Id -ne $RuleSet) {
                Write-Output "Skipping download for $($_.Name) rules"
                return
            }

            $ruleSetDownloadPath = Get-RuleSetFile -RuleSet $_.Id -File 'download.ps1'

            Write-Output "Downloading $($_.Name) rules"
            & $ruleSetDownloadPath
        }
}
