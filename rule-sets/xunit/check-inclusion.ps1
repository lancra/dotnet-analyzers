[CmdletBinding()]
[OutputType([bool])]
param(
    [Parameter(Mandatory)]
    [string] $Id
)
begin {
    $rulesPath = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'
    $configurationPath = Join-Path -Path $PSScriptRoot -ChildPath '..' -AdditionalChildPath '..', 'configuration.json'
}
process {
    $rule = Get-Content -Path $rulesPath |
        ConvertFrom-Json |
        Select-Object -ExpandProperty 'rules' |
        Where-Object -Property 'id' -EQ $Id

    $ruleSetProperties = Get-Content -Path $configurationPath |
        ConvertFrom-Json |
        Select-Object -ExpandProperty 'ruleSets' |
        Where-Object -Property 'id' -EQ 'xunit' |
        Select-Object -ExpandProperty 'properties'

    $script:include = $false
    $ruleSetProperties.PSObject.Properties |
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
