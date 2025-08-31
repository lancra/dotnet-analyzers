function Get-RuleSet {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Id,

        [switch] $Enabled
    )
    process {
        $configurationPath = Join-Path -Path $PSScriptRoot -ChildPath '..' -AdditionalChildPath 'configuration.json'
        $categoryProperties = @(
            @{ Name = 'Name'; Expression = { $_.name } },
            @{ Name = 'IndexUri'; Expression = { $_.indexUri } }
        )
        $ruleSetProperties = @(
            @{ Name = 'Id'; Expression = { $_.id } },
            @{ Name = 'Name'; Expression = { $_.name } },
            @{ Name = 'IndexUri'; Expression = { $_.indexUri }},
            @{ Name = 'HelpUriFormat'; Expression = { $_.helpUriFormat } },
            @{
                Name = 'Categories'
                Expression = {
                    $_.categories |
                        Select-Object -Property $categoryProperties
                }
            },
            @{ Name = 'Enabled'; Expression = { $_.enabled } },
            @{ Name = 'Properties'; Expression = { $_.properties } }
        )

        Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'ruleSets' |
            Select-Object -Property $ruleSetProperties |
            Where-Object { -not $Enabled -or $_.Enabled -eq $true } |
            Where-Object { -not $Id -or $_.Id -eq $Id }
    }
}
