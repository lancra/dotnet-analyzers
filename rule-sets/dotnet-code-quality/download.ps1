<#
.SYNOPSIS
Downloads .NET Code Quality rules.

.DESCRIPTION
Uses two approaches for downloading the complete list of rules. The generic
rules and text rules are parsed from SARIF files, and the single file rules are
parsed from the relevant Markdown index.
#>
[CmdletBinding()]
param ()

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

$ruleSet = Get-RuleSet -Id ([uri]::new($PSScriptRoot).Segments[-1])

enum RuleParserState {
    Search # Looking for a table title header in the document
    Header # Skipping the table alignment header
    Active # Parsing rules from the table
}
$state = [RuleParserState]::Search

& curl --silent 'https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/single-file/warnings/overview.md' |
    ForEach-Object {
        if ($state -eq [RuleParserState]::Search) {
            if ($_ -eq '|Rule|Description|') {
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
