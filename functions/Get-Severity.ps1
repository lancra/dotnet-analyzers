function Get-Severity {
    [CmdletBinding()]
    param()
    process {
        $configurationPath = Join-Path -Path $PSScriptRoot -ChildPath '..' -AdditionalChildPath 'configuration.json'
        $properties = @(
            @{ Name = 'Id'; Expression = { $_.id } },
            @{ Name = 'Name'; Expression = { $_.name } },
            @{ Name = 'Description'; Expression = { $_.description } }
        )

        Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'severities' |
            Select-Object -Property $properties
    }
}
