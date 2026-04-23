[CmdletBinding()]
param(
    [Parameter()]
    [string] $Id,

    [switch] $SkipBuild,

    [switch] $ErrorsOnly
)

function Get-ColorCode {
    [CmdletBinding()]
    [OutputType([int])]
    param(
        [Parameter(Mandatory)]
        [bool] $ErrorCondition,

        [switch] $SuccessColor
    )
    begin {
        $defaultForegroundAnsiCode = 39
        $brightRedForegroundAnsiCode = 91
        $brightGreenForegroundAnsiCode = 92
    }
    process {
        $successColorCode = $SuccessColor ? $brightGreenForegroundAnsiCode : $defaultForegroundAnsiCode
        $ErrorCondition ? $brightRedForegroundAnsiCode : $successColorCode
    }
}

enum OutputStyle {
    Disabled
    Failed
    Passed
    Standard
}

function Get-StyledOutput {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory)]
        [OutputStyle] $Style,

        [Parameter()]
        [string] $Text
    )
    process {
        $code = switch ($Style) {
            ([OutputStyle]::Disabled) { 93 }
            ([OutputStyle]::Failed) { 91 }
            ([OutputStyle]::Passed) { 92 }
            ([OutputStyle]::Standard) { 39 }
        }

        "`e[${code}m$Text`e[0m"
    }
}

$solutionDirectory = "$PSScriptRoot/../tests"

if (-not $SkipBuild) {
    & dotnet build $solutionDirectory |
        Tee-Object -Variable 'buildOutput' |
        Out-Null
    $buildFailed = $LASTEXITCODE -ne 0
    if ($buildFailed) {
        Get-StyledOutput -Style ([OutputStyle]::Failed) -Text 'The build failed for the smoke testing solution:' |
            Write-Output
        Write-Output $buildOutput
        exit 1
    }
}

function Get-FileRuleId {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )
    process {
        $uri = [uri]::new($Path)
        $fileName = $uri.Segments[-1]

        $dotIndex = $fileName.LastIndexOf('.')
        $extension = $fileName.Substring($dotIndex + 1)
        switch ($extension) {
            'cs' { return $fileName.Substring(0, $dotIndex) }
            'txt' {
                return Get-Content -Path $uri.LocalPath |
                    Select-Object -First 1 |
                    ForEach-Object {
                        $_.Substring(2)
                    }
            }
            default { throw "Unrecognized extension '$extension' for smoke test file '$Path'." }
        }
    }
}

$diagnosticProperties = @(
    @{ Name = 'FileRuleId'; Expression = { Get-FileRuleId -Path $_.locations[0].resultFile.uri } },
    @{ Name = 'WarningRuleId'; Expression = { $_.ruleId } },
    @{ Name = 'Line'; Expression = { $_.locations[0].resultFile.region.startLine } },
    @{ Name = 'Message'; Expression = { $_.message } }
)
$projectNames = Get-ChildItem -Path $solutionDirectory -Directory |
    Select-Object -ExpandProperty Name |
    ForEach-Object {
        $_.ToLowerInvariant()
    }
$diagnostics = $projectNames |
    ForEach-Object {
        $diagnosticsRuns = Get-Content -Path "$PSScriptRoot/../artifacts/diagnostics.$_.sarif" |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'runs'

        $diagnosticsRuns |
            Select-Object -ExpandProperty 'results' |
            Where-Object -Property 'suppressionStates' -EQ $null |
            Select-Object -Property $diagnosticProperties |
            ForEach-Object {
                if (-not $_.Message) {
                    $diagnosticsRules = $diagnosticsRuns |
                        Select-Object -ExpandProperty 'rules'
                    $_.Message = $diagnosticsRules.$($_.WarningRuleId) |
                        Select-Object -ExpandProperty 'shortDescription'
                }

                $_
            } |
            Where-Object { -not $Id -or $_.FileRuleId -EQ $Id }
    }

$minimumHyphensForLine = 4
$maximumRuleIdLength = Get-Content -Path "$PSScriptRoot/../src/data-sets/rule-settings.csv" |
    ConvertFrom-Csv |
    Select-Object -ExpandProperty Id |
    Measure-Object -Property Length -Maximum |
    Select-Object -ExpandProperty Maximum

$fileIncludes = @(
    '*.cs',
    '*.txt'
)
$fileProperties = @(
    @{ Name = 'RuleId'; Expression = { Get-FileRuleId -Path $_.FullName } },
    @{ Name = 'Path'; Expression = { $_.FullName } }
)
$files = Get-ChildItem -Path $solutionDirectory -File -Recurse -Include $fileIncludes |
    Select-Object -Property $fileProperties |
    Sort-Object -Property RuleId

function Get-DisabledMessage {
    [CmdletBinding()]
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )
    begin {
        $prefix = '// DISABLED: '
    }
    process {
        $lines = @(Get-Content -Path $Path)
        if (-not $lines[0].StartsWith($prefix)) {
            return $null
        }

        $messageLines = @()
        for ($i = 0; $i -lt $lines.Length; $i++) {
            $currentLine = $lines[$i]
            if (-not $currentLine.StartsWith('//')) {
                break
            }

            $messageLines += $currentLine.Substring($prefix.Length)
        }

        return $messageLines
    }
}

$script:passedCount = 0
$script:disabledCount = 0
$script:failedCount = 0

$indent = '    '

$fileDiagnosticProperties = @(
    'WarningRuleId',
    'Message',
    'Line',
    @{ Name = 'Unmatched'; Expression = { $_.WarningRuleId -ne $_.FileRuleId } }
)
$files |
    Where-Object { -not $Id -or $_.RuleId -eq $Id } |
    ForEach-Object {
        $fileDiagnostics = $diagnostics |
            Where-Object -Property FileRuleId -EQ $_.RuleId |
            Select-Object -Property $fileDiagnosticProperties |
            Sort-Object -Property Line

        $unmatchedFileDiagnostics = $fileDiagnostics |
            Where-Object -Property Unmatched -EQ $true

        $ruleStyle = [OutputStyle]::Passed
        $ruleDetail = @()

        $fileSucceeded = $fileDiagnostics -and -not $unmatchedFileDiagnostics
        if (-not $fileSucceeded) {
            $disabledMessageLines = @(Get-DisabledMessage -Path $_.Path)
            if ($disabledMessageLines) {
                $ruleStyle = [OutputStyle]::Disabled
                $ruleDetail = $disabledMessageLines
                $script:disabledCount++
            } else {
                $ruleStyle = [OutputStyle]::Failed
                $ruleDetail = -not $fileDiagnostics ? @('No diagnostics surfaced within this file.') : @()
                $script:failedCount++
            }
        } else {
            $script:passedCount++
        }

        if ($ruleStyle -ne ([OutputStyle]::Failed) -and $ErrorsOnly) {
            return $null
        }

        "$($_.RuleId): $(Get-StyledOutput -Style $ruleStyle -Text ($ruleStyle.ToString()))" |
            Write-Output

        $ruleDetail |
            ForEach-Object {
                Get-StyledOutput -Style $ruleStyle -Text "  $_" |
                    Write-Output
            }

        $fileDiagnostics |
            ForEach-Object {
                $diagnosticStyle = $_.Unmatched ? ([OutputStyle]::Failed) : ([OutputStyle]::Standard)
                $line = $_.Line.ToString().PadLeft(3, '0')
                $prefix = "L$line$($_.WarningRuleId.PadLeft($maximumRuleIdLength + $minimumHyphensForLine, '-')):"
                Get-StyledOutput -Style $diagnosticStyle -Text "$indent$prefix $($_.Message)" |
                    Write-Output
            }
    }

$totalCount = $script:passedCount + $script:disabledCount + $script:failedCount
$anyFailed = $script:failedCount -gt 0
$skipNewlinePrefix = (-not $anyFailed -and $ErrorsOnly) -or $totalCount -eq 0

$totalText = -not $skipNewlinePrefix ? "`n" : ''
if ($anyFailed) {
    $totalText += Get-StyledOutput -Style ([OutputStyle]::Failed) -Text 'Failed'
} elseif ($script:passedCount -gt 0) {
    $totalText += Get-StyledOutput -Style ([OutputStyle]::Passed) -Text 'Passed'
} elseif ($script:disabledCount -gt 0) {
    $totalText += Get-StyledOutput -Style ([OutputStyle]::Disabled) -Text 'Disabled'
} else {
    $totalText += 'None'
}

$totalText += " ($totalCount)"
$totalText |
    Write-Output

Get-StyledOutput -Style ([OutputStyle]::Passed) -Text "${indent}Passed ($($script:passedCount))"
Get-StyledOutput -Style ([OutputStyle]::Disabled) -Text "${indent}Disabled ($($script:disabledCount))"
Get-StyledOutput -Style ([OutputStyle]::Failed) -Text "${indent}Failed ($($script:failedCount))"

$exitCode = $anyFailed ? 1 : 0
exit $exitCode
