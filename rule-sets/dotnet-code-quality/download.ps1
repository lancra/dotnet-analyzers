[CmdletBinding()]
param ()

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Format-Plaintext.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/Test-RuleSetDifference.ps1"

$jqQuery = '.runs[] | ' +
    '.rules | ' +
    'to_entries | ' +
    'map({ value: .value }) | ' +
    'map(. + .value | del(.value)) | ' +
    'map(. + .properties | del(.properties)) | ' +
    'map({ id, title: .shortDescription, category })'

$netAnalyzerUrl = 'https://raw.githubusercontent.com/dotnet/roslyn-analyzers/main/src/NetAnalyzers/Microsoft.CodeAnalysis.NetAnalyzers.sarif'
$rules = & curl --silent $netAnalyzerUrl |
    jq $jqQuery |
    jq -s 'add' |
    jq '[.[]] | unique_by(.id)' |
    ConvertFrom-Json

$textAnalyzerUrl = 'https://raw.githubusercontent.com/dotnet/roslyn/refs/heads/main/src/RoslynAnalyzers/Text.Analyzers/Text.Analyzers.sarif'
$rules += & curl --silent $textAnalyzerUrl |
    jq $jqQuery |
    jq -s 'add' |
    ConvertFrom-Json

$singleFileUrl = 'https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/single-file/warnings/overview.md'
$tableTitleHeader = '|Rule|Description|'

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
            category = 'SingleFile'
        }
        $rules += $rule
    }

$path = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'

$output = [ordered]@{}
$output.'$schema' = $env:DOTNET_ANALYZERS_SCHEMA
$output.timestamp = (Get-Date -Format 'o')
$output.rules = $rules | Sort-Object -Property @('category', 'id')

if (Test-RuleSetDifference -Path $path -Json ($output.rules | ConvertTo-Json)) {
    $output | ConvertTo-Json > $path
}
