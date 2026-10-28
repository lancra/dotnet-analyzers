<#
.SYNOPSIS
Downloads TUnit rules.

.DESCRIPTION
Uses the Markdown index to parse the complete list of rules.
#>
[CmdletBinding()]
param ()

$ruleSet = Get-RuleSet -CurrentDirectory

enum RuleParserState {
    HeaderSearch # Searching for an analyzer table header.
    Header # Skipping the table header.
    Active # Parsing rules from the table.
    Complete # Finished parsing.
}
$state = [RuleParserState]::HeaderSearch

$rules = @()
& curl --silent 'https://raw.githubusercontent.com/thomhurst/TUnit/refs/heads/main/src/TUnit.Analyzers/AnalyzerReleases.Shipped.md' |
    ForEach-Object {
        if ($state -eq [RuleParserState]::HeaderSearch) {
            if ($_.StartsWith('Rule ID |')) {
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

        $rowValues = ((Format-Plaintext $_) -split '\|').Trim()

        $rule = [PSCustomObject]@{
            id = $rowValues[0]
            title = $rowValues[3]
            helpUri = $ruleSet.HelpUriFormat
            default = $rowValues[2]
        }

        $rules += $rule
    }

# Sort the migration rules after others since they deviate from the identifier format.
$migrationRuleSortProperty = { $_.id.StartsWith('TUnit') ? 0 : 1 }
New-AnalyzerSpecification -Kind 'rules' -Item $rules -Sort $migrationRuleSortProperty
