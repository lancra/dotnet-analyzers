[CmdletBinding()]
param ()

if ($null -eq (Get-Command -Name 'pup' -ErrorAction SilentlyContinue)) {
    throw 'Downloading xUnit rules requires pup. Please download it from GitHub (https://github.com/ericchiang/pup) or ' +
        'via Go (go install github.com/ericchiang/pup@latest).'
}

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Test-RuleSetDifference.ps1"

$url = 'https://xunit.net/xunit.analyzers/rules/'

$rules = @()

enum RuleParserState {
    Header # Skipping the table category header
    Active # Parsing rules from the table
}
$state = [RuleParserState]::Active

$currentCategory = $null
(& curl --silent $url) |
    pup --plain 'html body div table tbody json{}' |
    ConvertFrom-Json |
    Select-Object -ExpandProperty 'children' |
    ForEach-Object {
        if ($state -eq [RuleParserState]::Header) {
            $state = [RuleParserState]::Active
            return
        }

        if ($_.children.Length -eq 1) {
            $currentCategory = $_.children[0].children[0].text -replace ' Analyzers', ''
            $state = [RuleParserState]::Header
            return
        }

        $rule = [ordered]@{}
        $rule.id = $_.children[0].children[0].children[0].text
        $rule.title = $_.children[1].text
        $rule.category = $currentCategory
        $rule.default = $_.children[0].children[1].text
        $rules += $rule
    }

$path = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'

$output = [ordered]@{}
$output.'$schema' = $env:DOTNET_ANALYZERS_SCHEMA
$output.timestamp = (Get-Date -Format 'o')
$output.rules = $rules

if (Test-RuleSetDifference -Path $path -Json ($output.rules | ConvertTo-Json)) {
    $output | ConvertTo-Json > $path
}
