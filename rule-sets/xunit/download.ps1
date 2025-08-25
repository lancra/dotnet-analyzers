[CmdletBinding()]
param ()

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Test-RuleSetDifference.ps1"

function Get-RegexMatch {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory)]
        [string] $Text,

        [Parameter(Mandatory)]
        [string] $Pattern
    )
    begin {
        $groupName = 'match'
    }
    process {
        $namedPattern = $Pattern -f $groupName
        $Text |
            Select-String -Pattern $namedPattern |
            Select-Object -ExpandProperty Matches |
            Select-Object -ExpandProperty Groups |
            Where-Object -Property Name -EQ $groupName |
            Select-Object -ExpandProperty Value
    }
}

$ruleSet = Get-RuleSet -Id ([uri]::new($PSScriptRoot).Segments[-1])

enum RuleParserState {
    HeadingSearch # Searching for an analyzer category heading.
    HeaderSearch # Searching for an analyzer table header.
    Header # Skipping the table header.
    Active # Parsing rules from the table.
}
$state = [RuleParserState]::HeadingSearch

$rules = @()
$currentCategory = $null

& curl --silent 'https://raw.githubusercontent.com/xunit/xunit.net/refs/heads/main/site/xunit.analyzers/rules/index.md' |
    ForEach-Object {
        if ($state -eq [RuleParserState]::HeadingSearch) {
            if ($_.StartsWith('##')) {
                $currentCategory = Get-RegexMatch -Text $_ -Pattern '## (?<{0}>.*?) Analyzers \(\dxxx\)'
                $state = [RuleParserState]::HeaderSearch
            }

            return
        }

        if ($state -eq [RuleParserState]::HeaderSearch) {
            if ($_.StartsWith('| ID')) {
                $state = [RuleParserState]::Header
            }

            return
        }

        if ($state -eq [RuleParserState]::Header) {
            $state = [RuleParserState]::Active
            return
        }

        if (-not $_) {
            $state = [RuleParserState]::HeadingSearch
            return
        }

        $segments = $_.Substring(2) -split '\|' |
            ForEach-Object { $_.Trim() }
        $id = Get-RegexMatch -Text $segments[0] -Pattern '\[(?<{0}>.*?)\]\(.*\)'

        $rule = [PSCustomObject]@{
            id = $id
            title = $segments[3]
            helpUri = $ruleSet.HelpUriFormat -f $id
            category = $currentCategory
            default = Get-RegexMatch -Text $segments[2] -Pattern '::(?<{0}>.*?)::.*'
            versions = [ordered]@{}
        }

        $versionIdGroupName = 'name'
        $versionValueGroupName = 'value'
        $segments[1] |
            Select-String -AllMatches -Pattern "::(?<$versionIdGroupName>.*?)::\{.*?\.label-version-(?<$versionValueGroupName>.*?)\}" |
            Select-Object -ExpandProperty Matches |
            ForEach-Object {
                $groups = $_ |
                    Select-Object -ExpandProperty Groups
                $versionId = $groups |
                    Where-Object -Property Name -EQ $versionIdGroupName |
                    Select-Object -ExpandProperty Value
                $versionValue = $groups |
                    Where-Object -Property Name -EQ $versionValueGroupName |
                    Select-Object -ExpandProperty Value

                $rule.versions[$versionId] = [bool]::Parse($versionValue)
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

$jsonDepth = 3
if (Test-RuleSetDifference -Path $path -Json ($output.rules | ConvertTo-Json -Depth $jsonDepth)) {
    $output | ConvertTo-Json -Depth $jsonDepth > $path
}
