function New-AnalyzerSpecification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('options', 'rules')]
        [string] $Kind,

        [Parameter(Mandatory)]
        [pscustomobject[]] $Item,

        [Parameter()]
        [scriptblock[]] $Sort = @()
    )
    begin {
        $jsonDepth = 10
        $schema = "https://raw.githubusercontent.com/lancra/dotnet-analyzers/refs/heads/main/$Kind.schema.json"
        $timestamp = Get-Date -Format 'o'

        $defaultSort = switch ($Kind) {
            'options' { { $_.name } }
            'rules' { { $_.id } }
        }
    }
    process {
        $callStackFrames = Get-PSCallStack
        if (-not $callStackFrames -or -not $callStackFrames -is [array] -or $callStackFrames.Length -le 1) {
            throw "Unable to find the executing script from the current call stack."
        }

        $callingPath = $callStackFrames[1].ScriptName
        $callingDirectory = [System.IO.Path]::GetDirectoryName($callingPath)
        $path = $path = Join-Path -Path $callingDirectory -ChildPath "$Kind.json"

        $fullSort = @($Sort) + $defaultSort
        $sortedItems = $Item |
            Sort-Object -Property $fullSort

        $output = [ordered]@{
            '$schema' = $schema
            timestamp = $timestamp
            "$Kind" = $sortedItems
        }

        $inMemoryItemsJson = $output[$Kind] |
            ConvertTo-Json -Depth $jsonDepth
        $hasChanges = Test-AnalyzerDifference -Path $path -Json $inMemoryItemsJson -Property $Kind
        if ($hasChanges) {
            $output |
                ConvertTo-Json -Depth $jsonDepth |
                Set-Content -Path $path
        }
    }
}
