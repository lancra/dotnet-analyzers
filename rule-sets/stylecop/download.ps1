[CmdletBinding()]
param ()

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Format-Plaintext.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/Test-RuleSetDifference.ps1"

$categories = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/categories.csv" |
    Where-Object -Property 'RuleSet' -EQ 'StyleCop' |
    Select-Object -ExpandProperty 'Category'
$categoryUrlFormat = 'https://raw.githubusercontent.com/DotNetAnalyzers/StyleCopAnalyzers/master/documentation/{0}Rules.md'
$tableTitleHeader = 'Identifier | Name | Description'

enum RuleParserState {
    Search # Looking for a table title header in the document
    Header # Skipping the table alignment header
    Active # Parsing rules from the table
}
$state = [RuleParserState]::Search

$rules = @()

$categories |
    ForEach-Object {
        $category = $_
        $categoryUrl = $categoryUrlFormat -f $category

        & curl --silent $categoryUrl |
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

                $rule = [PSCustomObject]@{
                    id = $rowValues[0]
                    title = $rowValues[2]
                    category = $category
                }

                $rules += $rule
            }

        $state = [RuleParserState]::Search
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
