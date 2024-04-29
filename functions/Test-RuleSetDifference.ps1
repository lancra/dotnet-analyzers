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
        $tempPath = [System.IO.Path]::GetTempFileName()
        $tempJsonPath = "$tempPath.json"
        Rename-Item -Path $tempPath -NewName $tempJsonPath
        & jq '.rules' $Path > $tempJsonPath
    }
    process {
        if ($null -eq (Get-Command -Name 'jd' -ErrorAction SilentlyContinue)) {
            Write-Warning 'Checking for rule-set differences requires jd. Please download it from GitHub ' +
                '(https://github.com/josephburnett/jd) or via Go (go install github.com/josephburnett/jd@latest).'
            return $true
        }

        $hasDifferences = $null -ne ($Json | jd -set $tempJsonPath)
        return $hasDifferences
    }
    end {
        Remove-Item -Path $tempJsonPath
    }
}
