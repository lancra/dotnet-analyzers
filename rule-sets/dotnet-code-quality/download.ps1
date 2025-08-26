[CmdletBinding()]
param ()

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Format-Plaintext.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/Test-RuleSetDifference.ps1"

function Get-Rule {
    [CmdletBinding()]
    [OutputType([PSCustomObject[]])]
    param(
        [Parameter(Mandatory)]
        [uri] $Uri
    )
    begin {
        $ruleProperties = @(
            'id'
            'helpUri'
            @{ Name = 'title'; Expression = { $_.shortDescription } },
            @{ Name = 'category'; Expression = { $_.properties.category } }
        )
    }
    process {
        $rules = @()

        @(
            'curl',
            '--silent',
            # Skip the UTF byte order mark included from GitHub, since it interferes with PowerShell JSON deserialization.
            '--range 3-',
            $Uri
        ) -join ' ' |
            Invoke-Expression |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'runs' |
            Select-Object -ExpandProperty 'rules' |
            ForEach-Object {
                $_.PSObject.Properties |
                    ForEach-Object {
                        $rule = $_.Value |
                            Select-Object -Property $ruleProperties

                        if (-not ($rules |
                            Where-Object -Property id -EQ $rule.id)) {
                                $rules += ,$rule
                            }
                    }
            }

        return $rules
    }
}

$rules = @()
$rules += Get-Rule -Uri 'https://raw.githubusercontent.com/dotnet/sdk/main/src/Microsoft.CodeAnalysis.NetAnalyzers/src/Microsoft.CodeAnalysis.NetAnalyzers.sarif'
$rules += Get-Rule -Uri 'https://raw.githubusercontent.com/dotnet/roslyn/main/src/RoslynAnalyzers/Text.Analyzers/Text.Analyzers.sarif'

$singleFileUrl = 'https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/single-file/warnings/overview.md'
$tableTitleHeader = '|Rule|Description|'

$ruleSet = Get-RuleSet -Id ([uri]::new($PSScriptRoot).Segments[-1])

enum RuleParserState {
    Search # Looking for a table title header in the document
    Header # Skipping the table alignment header
    Active # Parsing rules from the table
}
$state = [RuleParserState]::Search

& curl --silent $singleFileUrl |
    ForEach-Object {
        if ($state -eq [RuleParserState]::Search) {
            if ($_ -eq $tableTitleHeader) {
                $state = [RuleParserState]::Header
            }

            return
        }

        if ($state -eq [RuleParserState]::Header) {
            $state = [RuleParserState]::Active
            return
        }

        # Remove '|' from the beginning of the line and '|' from the end.
        $rawLine = $_.Substring(1, $_.Length - 2)
        $rowValues = ((Format-Plaintext $rawLine) -split '\|').Trim()

        $rawId = $rowValues[0]
        $id = $rawId.Substring(0, $rawId.IndexOf(' '))

        $rule = [PSCustomObject]@{
            id = $id
            title = $rowValues[1]
            helpUri = $ruleSet.HelpUriFormat -f $id.ToLower()
            category = 'SingleFile'
        }
        $rules += $rule
    }

$path = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'

$output = [ordered]@{
    '$schema' = $env:DOTNET_ANALYZERS_SCHEMA
    timestamp = Get-Date -Format 'o'
    rules = $rules |
        Sort-Object -Property 'id'
}

if (Test-RuleSetDifference -Path $path -Json ($output.rules | ConvertTo-Json)) {
    $output | ConvertTo-Json > $path
}
