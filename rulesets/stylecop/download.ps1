[CmdletBinding()]
param ()

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Format-Plaintext.ps1"

$ruleCategories = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/groups.csv" |
    Where-Object -Property Group -EQ 'StyleCop' |
    Select-Object -ExpandProperty 'Category'
$ruleCategoryUrlFormat = 'https://raw.githubusercontent.com/DotNetAnalyzers/StyleCopAnalyzers/master/documentation/{0}Rules.md'
$tableTitleHeader = 'Identifier | Name | Description'

enum RuleParserState {
    Search # Looking for a table title header in the document
    Header # Skipping the table alignment header
    Active # Parsing rules from the table
}
$state = [RuleParserState]::Search

$rules = @()

$ruleCategories |
    ForEach-Object {
        $ruleCategory = $_
        $ruleCategoryUrl = $ruleCategoryUrlFormat -f $ruleCategory

        & curl --silent $ruleCategoryUrl |
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

                $rowValues = ((Format-Plaintext $_) -split '\|').Trim()

                $rule = [ordered]@{}
                $rule.id = $rowValues[0]
                $rule.title = $rowValues[2]
                $rule.category = $ruleCategory
                $rules += $rule
            }

        $state = [RuleParserState]::Search
    }

$path = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'

$output = [ordered]@{}
$output.'$schema' = $env:DOTNET_ANALYZERS_SCHEMA
$output.timestamp = (Get-Date -Format 'o')
$output.rules = $rules

$output | ConvertTo-Json > $path
