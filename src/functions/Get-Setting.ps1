function Get-Setting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )
    process {
        (Test-Path -Path $Path) `
            ? (Import-Csv -Path $Path) `
            : @()
    }
}
