<#
.SYNOPSIS
Downloads TUnit rules.

.DESCRIPTION
The rules are parsed from the individual category tables in the Markdown index.
#>
[CmdletBinding()]
param ()

$indexUri = 'https://raw.githubusercontent.com/thomhurst/TUnit/refs/heads/main/TUnit.Analyzers/AnalyzerReleases.Shipped.md'
$headerPrefix = [string]::new('#', 4) + ' '
$headerSuffix = ' Rules'

$ruleSet = Get-RuleSet -Id ([uri]::new($PSScriptRoot).Segments[-1])
$categories = $ruleSet |
    Select-Object -ExpandProperty Categories

enum RuleParserState {
    Search         # Looking for the category header in the document.
    TableTitle     # Skipping the table title header.
    TableAlignment # Skipping the table alignment header.
    Active         # Parsing rules from the table
}
$state = [RuleParserState]::Search
$currentCategory = $null

$rules = @()
& curl --silent $indexUri |
    ForEach-Object {
        if ($state -eq [RuleParserState]::Search) {
            if ($_.StartsWith($headerPrefix)) {
                $state = [RuleParserState]::TableTitle

                $categoryName = $_.Substring($headerPrefix.Length, $_.Length - $headerPrefix.Length)
                if ($categoryName.EndsWith($headerSuffix)) {
                    $categoryName = $categoryName.Substring(0, $categoryName.Length - $headerSuffix.Length)
                }

                $currentCategory = $categories |
                    Where-Object -Property 'name' -EQ $categoryName
            }

            return
        }

        if ($state -eq [RuleParserState]::TableTitle) {
            $state = [RuleParserState]::TableAlignment
            return
        }

        if ($state -eq [RuleParserState]::TableAlignment) {
            $state = [RuleParserState]::Active
            return
        }

        if ($state -eq [RuleParserState]::Active -and -not $_) {
            $state = [RuleParserState]::Search
            return
        }

        $rowValues = ((Format-Plaintext $_) -split '\|').Trim()

        $rule = [PSCustomObject]@{
            id = $rowValues[0]
            title = $rowValues[3]
            helpUri = $currentCategory.indexUri
            category = $currentCategory.name
            default = $rowValues[2]
        }

        $rules += $rule
    }

$path = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'

# Sort the migration rules after others since they deviate from the identifier format.
$migrationRuleSortProperty = { $_.id.StartsWith('TUnit') ? 0 : 1 }
$output = [ordered]@{
    '$schema' = $env:DOTNET_ANALYZERS_SCHEMA
    timestamp = Get-Date -Format 'o'
    rules = $rules |
        Sort-Object -Property $migrationRuleSortProperty, 'id'
}

if (Test-RuleSetDifference -Path $path -Json ($output.rules | ConvertTo-Json)) {
    $output | ConvertTo-Json > $path
}
