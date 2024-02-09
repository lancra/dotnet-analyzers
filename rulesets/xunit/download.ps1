[CmdletBinding()]
param ()

if ($null -eq (Get-Command -Name 'pup' -ErrorAction SilentlyContinue)) {
    throw 'Downloading xUnit rules requires pup. Please download it from GitHub (https://github.com/ericchiang/pup) or ' +
        'via Go (go install github.com/ericchiang/pup@latest).'
}

$url = 'https://xunit.net/xunit.analyzers/rules/'

$rules = @()

enum RuleParserState {
    Header # Skipping the table group header
    Active # Parsing rules from the table
}
$state = [RuleParserState]::Active

$currentGroup = $null
(& curl --silent $url) |
    pup 'html body div table tbody json{}' |
    ConvertFrom-Json |
    Select-Object -ExpandProperty 'children' |
    ForEach-Object {
        if ($state -eq [RuleParserState]::Header) {
            $state = [RuleParserState]::Active
            return
        }

        if ($_.children.Length -eq 1) {
            $currentGroup = $_.children[0].children[0].text -replace ' Analyzers', ''
            $state = [RuleParserState]::Header
            return
        }

        $rule = [ordered]@{}
        $rule.id = $_.children[0].children[0].children[0].text
        $rule.title = $_.children[1].text
        $rule.category = $currentGroup
        $rule.default = $_.children[0].children[1].text
        $rules += $rule
    }

$path = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'

$output = [ordered]@{}
$output.'$schema' = $env:DOTNET_ANALYZERS_SCHEMA
$output.timestamp = (Get-Date -Format 'o')
$output.rules = $rules

$output | ConvertTo-Json > $path
