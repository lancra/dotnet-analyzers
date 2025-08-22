function Get-RuleSet {
    [CmdletBinding()]
    param(
        [switch] $Enabled
    )
    process {
        $configurationPath = Join-Path -Path $PSScriptRoot -ChildPath '..' -AdditionalChildPath 'configuration.json'
        $properties = @(
            @{ Name = 'Id'; Expression = { $_.id } },
            @{ Name = 'Name'; Expression = { $_.name } },
            @{ Name = 'Enabled'; Expression = { $_.enabled } },
            @{ Name = 'Properties'; Expression = { $_.properties } }
        )

        Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'ruleSets' |
            Where-Object { -not $Enabled -or $_.enabled -eq $true } |
            Select-Object -Property $properties
    }
}
