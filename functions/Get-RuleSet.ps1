function Get-RuleSet {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Id,

        [switch] $Enabled
    )
    process {
        $rootDirectoryPath = Join-Path -Path $PSScriptRoot -ChildPath '..'
        $configurationPath = Join-Path -Path $rootDirectoryPath -ChildPath 'configuration.json'
        $preferencesPath = Join-Path -Path $rootDirectoryPath -ChildPath '.preferences.json'

        $preferencesSpecification = Get-Content -Path $preferencesPath |
            ConvertFrom-Json
        $preferences = $preferencesSpecification.PSObject.Properties |
            Where-Object { -not $Id -or $_.Name -eq $Id } |
            ForEach-Object {
                [pscustomobject]@{
                    Id = $_.Name
                    Enabled = $_.Value.enabled
                    Properties = $_.Value.properties
                }
            }

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
            @{
                Name = 'Enabled'
                Expression = {
                    $preferences |
                        Where-Object -Property Id -EQ $_.id |
                        Select-Object -ExpandProperty Enabled
                }
            },
            @{
                Name = 'Properties'
                Expression = {
                    $preferences |
                        Where-Object -Property Id -EQ $_.id |
                        Select-Object -ExpandProperty Properties
                }
            }
        )

        Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'ruleSets' |
            Select-Object -Property $ruleSetProperties |
            Where-Object { -not $Enabled -or $_.Enabled -eq $true } |
            Where-Object { -not $Id -or $_.Id -eq $Id }
    }
}
