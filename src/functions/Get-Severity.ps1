function Get-Severity {
    [CmdletBinding()]
    param()
    process {
        $configurationPath = Join-Path -Path $PSScriptRoot -ChildPath '..' -AdditionalChildPath '..', 'configuration.json'
        $properties = @(
            @{ Name = 'Id'; Expression = { $_.id } },
            @{ Name = 'AlternateId'; Expression = { $_.alternateId } },
            @{ Name = 'Name'; Expression = { $_.name } },
            @{ Name = 'Letter'; Expression = { $_.letter } },
            @{ Name = 'Description'; Expression = { $_.description } }
        )

        Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'severities' |
            Select-Object -Property $properties
    }
}
