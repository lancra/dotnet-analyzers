<#
.SYNOPSIS
Downloads Visual Studio Threading rules.

.DESCRIPTION
Uses the Markdown index to parse the complete list of rules.
#>
[CmdletBinding()]
param()

$ruleSet = Get-RuleSet -CurrentDirectory

enum RuleParserState {
    HeaderSearch # Searching for an analyzer table header.
    Header # Skipping the table header.
    Active # Parsing rules from the table.
    Complete # Finished parsing.
}
$state = [RuleParserState]::HeaderSearch

$rules = @()

& curl --silent 'https://raw.githubusercontent.com/microsoft/vs-threading/refs/heads/main/docfx/analyzers/index.md' |
    ForEach-Object {
        if ($state -eq [RuleParserState]::HeaderSearch) {
            if ($_.StartsWith('ID |')) {
                $state = [RuleParserState]::Header
            }

            return
        }

        if ($state -eq [RuleParserState]::Header) {
            $state = [RuleParserState]::Active
            return
        }

        if ($state -eq [RuleParserState]::Active -and [string]::IsNullOrEmpty($_)) {
            $state = [RuleParserState]::Complete
            return
        }

        if ($state -eq [RuleParserState]::Complete) {
            return
        }

        $segments = $_ -split '\|' |
            ForEach-Object { $_.Trim() }
        $id = Format-Plaintext -Text $segments[0]
        $title = Format-Plaintext -Text $segments[1]
        $severity = Format-Plaintext -Text $segments[4]

        $rule = [pscustomobject]@{
            id = $id
            title = $title
            helpUri = $ruleSet.HelpUriFormat -f $id
            default = $severity
        }

        $rules += $rule
    }

New-RuleSpecification -Rule $rules
