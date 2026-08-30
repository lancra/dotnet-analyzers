function Test-AnalyzerDifference {
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(Mandatory)]
        [string] $Path,

        [Parameter(Mandatory)]
        [string] $Json,

        [Parameter(Mandatory)]
        [string] $Property
    )
    begin {
        $jsonDepth = 10
    }
    process {
        if (-not (Test-Path -Path $Path)) {
            return $true
        }

        $tempCurrentPath = "$([System.IO.Path]::GetTempPath())$(New-Guid).json"
        Get-Content -Path $Path |
            ConvertFrom-Json |
            Select-Object -ExpandProperty $Property |
            ConvertTo-Json -Depth $jsonDepth |
            Set-Content -Path $tempCurrentPath

        $tempNewPath = "$([System.IO.Path]::GetTempPath())$(New-Guid).json"
        $Json |
            Set-Content $tempNewPath

        $currentHash = Get-FileHash -Path $tempCurrentPath -Algorithm SHA256 |
            Select-Object -ExpandProperty Hash
        $newHash = Get-FileHash -Path $tempNewPath -Algorithm SHA256 |
            Select-Object -ExpandProperty Hash
        $hasDifferences = $currentHash -ne $newHash
        return $hasDifferences
    }
    end {
        if ($tempCurrentPath) {
            Remove-Item -Path $tempCurrentPath
        }

        if ($tempNewPath) {
            Remove-Item -Path $tempNewPath
        }
    }
}
