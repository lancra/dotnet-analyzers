[CmdletBinding()]
[OutputType([bool])]
param(
    [Parameter(Mandatory)]
    [string] $Id
)
begin {
    $rulesPath = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'
}
process {
    $rule = Get-Content -Path $rulesPath |
        ConvertFrom-Json |
        Select-Object -ExpandProperty 'rules' |
        Where-Object -Property 'id' -EQ $Id

    $ruleSet = Get-RuleSet -CurrentDirectory

    if (-not $ruleSet.Properties.versionFilter) {
        return $true
    }

    $script:include = $false
    $ruleSet.Properties.PSObject.Properties |
        ForEach-Object {
            if (-not $_.Value) {
                return
            }

            $version = $_.Name
            if ($rule.versions.$version) {
                $script:include = $true
            }
        }

    return $script:include
}
