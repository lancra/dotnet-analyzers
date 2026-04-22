function New-RuleSpecification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject[]] $Rule,

        [Parameter()]
        [scriptblock[]] $Sort = @()
    )
    begin {
        $jsonDepth = 10
        $schema = 'https://raw.githubusercontent.com/lancra/dotnet-analyzers/refs/heads/main/analyzer-rules.schema.json'
        $timestamp = Get-Date -Format 'o'
    }
    process {
        $callStackFrames = Get-PSCallStack
        if (-not $callStackFrames -or -not $callStackFrames -is [array] -or $callStackFrames.Length -le 1) {
            throw "Unable to find the executing script from the current call stack."
        }

        $callingPath = $callStackFrames[1].ScriptName
        $callingDirectory = [System.IO.Path]::GetDirectoryName($callingPath)
        $path = $path = Join-Path -Path $callingDirectory -ChildPath 'rules.json'

        $fullSort = @($Sort) + { $_.id }
        $sortedRules = $Rule |
            Sort-Object -Property $fullSort

        $output = [ordered]@{
            '$schema' = $schema
            timestamp = $timestamp
            rules = $sortedRules
        }

        $inMemoryRulesJson = $output['rules'] |
            ConvertTo-Json -Depth $jsonDepth
        $hasChanges = Test-RuleSetDifference -Path $path -Json $inMemoryRulesJson
        if ($hasChanges) {
            $output |
                ConvertTo-Json -Depth $jsonDepth |
                Set-Content -Path $path
        }
    }
}
