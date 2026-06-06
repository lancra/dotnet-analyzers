<#
.SYNOPSIS
Downloads .NET Code Analysis rules.

.DESCRIPTION
The rules are parsed from the individual tables in the Markdown index.
#>
[CmdletBinding()]
param()

$indexUri = 'https://raw.githubusercontent.com/dotnet/roslyn/main/src/RoslynAnalyzers/Microsoft.CodeAnalysis.Analyzers/Microsoft.CodeAnalysis.Analyzers.md'
$headerPrefix = [string]::new('#', 2) + ' '
$tableTitleHeader = '|Item|Value|'
$tableAlignmentHeader = '|-|-|'
$tableCategoryPrefix = '|Category|'
$categoryPrefix = 'MicrosoftCodeAnalysis'
$tableSeverityPrefix = '|Severity|'

$idGroupName = 'id'
$titleGroupName = 'title'
$headerPattern = "^## (?<$idGroupName>.*?): (?<$titleGroupName>.*)$"

$ruleSet = Get-RuleSet -CurrentDirectory

enum RuleParserState {
    Search         # Looking for the category header in the document.
    TableTitle     # Skipping the table title header.
    TableAlignment # Skipping the table alignment header.
    Category       # Parsing category from the table
    Severity       # Parsing severity from the table
}
$state = [RuleParserState]::Search

$currentAnchor = $null
$currentId = $null
$currentTitle = $null
$currentCategory = $null

$rules = @()
& curl --silent $indexUri |
    ForEach-Object {
        if ($state -eq [RuleParserState]::Search) {
            if ($_.StartsWith($headerPrefix)) {
                $state = [RuleParserState]::TableTitle

                $header = Format-Plaintext -Text $_
                $currentAnchor = Format-MarkdownAnchor -Text ($header.Substring($headerPrefix.Length))

                $headerGroups = $header |
                    Select-String -Pattern $headerPattern |
                    Select-Object -ExpandProperty Matches |
                    Select-Object -ExpandProperty Groups
                $currentId = $headerGroups |
                    Where-Object -Property Name -EQ $idGroupName |
                    Select-Object -ExpandProperty Value
                $currentTitle = $headerGroups |
                    Where-Object -Property Name -EQ $titleGroupName |
                    Select-Object -ExpandProperty Value

                }

            return
        }

        if ($state -eq [RuleParserState]::TableTitle) {
            if ($_ -eq $tableTitleHeader) {
                $state = [RuleParserState]::TableAlignment
            }

            return
        }

        if ($state -eq [RuleParserState]::TableAlignment) {
            if ($_ -eq $tableAlignmentHeader) {
                $state = [RuleParserState]::Category
            }

            return
        }

        if ($state -eq [RuleParserState]::Category) {
            if ($_.StartsWith($tableCategoryPrefix)) {
                $state = [RuleParserState]::Severity

                $currentCategory = $_.Substring($tableCategoryPrefix.Length).TrimEnd('|')
                if ($currentCategory.StartsWith($categoryPrefix)) {
                    $currentCategory = $currentCategory.Substring($categoryPrefix.Length)
                }
            }

            return
        }

        if ($state -eq [RuleParserState]::Severity) {
            if ($_.StartsWith($tableSeverityPrefix)) {
                $state = [RuleParserState]::Search

                $severity = $_.Substring($tableSeverityPrefix.Length).TrimEnd('|')

                $rule = [PSCustomObject]@{
                    id = $currentId
                    title = $currentTitle
                    helpUri = $ruleSet.HelpUriFormat -f $currentAnchor
                    category = $currentCategory
                    default = $severity
                }

                $rules += $rule

                $currentAnchor = $null
                $currentId = $null
                $currentTitle = $null
                $currentCategory = $null
            }

            return
        }

    }

New-AnalyzerSpecification -Kind 'rules' -Item $rules
