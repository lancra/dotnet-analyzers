function Test-RuleSetDifference {
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(Mandatory)]
        [string]$Path,
        [Parameter(Mandatory)]
        [string]$Json
    )
    begin {
        $jsonDepth = 10
    }
    process {
        if (-not (Test-Path -Path $Path)) {
            return $true
        }

        $tempCurrentRulesPath = "$([System.IO.Path]::GetTempPath())$(New-Guid).json"
        Get-Content -Path $Path |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'rules' |
            ConvertTo-Json -Depth $jsonDepth |
            Set-Content -Path $tempCurrentRulesPath

        $tempNewRulesPath = "$([System.IO.Path]::GetTempPath())$(New-Guid).json"
        $Json |
            Set-Content $tempNewRulesPath

        git diff --exit-code --no-index $tempCurrentRulesPath $tempNewRulesPath |
            Out-Null
        $hasDifferences = $LASTEXITCODE -ne 0
        return $hasDifferences
    }
    end {
        if ($tempCurrentRulesPath) {
            Remove-Item -Path $tempCurrentRulesPath
        }

        if ($tempNewRulesPath) {
            Remove-Item -Path $tempNewRulesPath
        }
    }
}
