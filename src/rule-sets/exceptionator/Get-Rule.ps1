function Get-Rule {
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory)]
        [string] $Uri,

        [Parameter(Mandatory)]
        [string] $HelpUriFormat,

        [Parameter(Mandatory)]
        [string] $Directory,

        [Parameter()]
        [string[]] $ReadmeLine
    )
    begin {
        # Since this script is executed within parallel thread jobs, the global dot sources within the build script are inapplicable.
        . "$Directory/../../functions/Format-MarkdownAnchor.ps1"
        . "$Directory/../../functions/Get-GitHubFileLine.ps1"

        class Indexer {
            [int] $ClassDefinition
            [int] $RuleDefinitionStart
            [int] $RuleDefinitionEnd

            [void] SetClassDefinition([int] $value) {
                $this.ClassDefinition = $value
            }

            [void] SetRuleDefinitionStart([int] $value) {
                $this.RuleDefinitionStart = $value
            }

            [void] SetRuleDefinitionEnd([int] $value) {
                $this.RuleDefinitionEnd = $value
            }
        }

        enum IndexerState {
            ClassDefinition
            RuleDefinitionStart
            RuleDefinitionEnd
        }

        function Get-QuotedValue {
            [CmdletBinding()]
            [OutputType([string])]
            param(
                [Parameter(Mandatory)]
                [string] $Text
            )
            process {
                $valueGroupName = 'value'
                $valuePattern = "\`"(?<$valueGroupName>.*?)\`""
                return $Text |
                    Select-String -Pattern $valuePattern |
                    Select-Object -ExpandProperty Matches |
                    Select-Object -ExpandProperty Groups |
                    Where-Object -Property Name -EQ $valueGroupName |
                    Select-Object -ExpandProperty Value
            }
        }

        function Get-RuleLineValue {
            [CmdletBinding()]
            [OutputType([string])]
            param(
                [Parameter(Mandatory)]
                [string] $RuleLine,

                [Parameter()]
                [string[]] $PropertyLine
            )
            process {
                $value = Get-QuotedValue -Text $RuleLine
                if (-not $value) {
                    $propertyName = $RuleLine.Trim().Replace(',', '')
                    $propertyLines = @($PropertyLine)
                    for ($i = 0; $i -lt $propertyLines.Length; $i++) {
                        $line = $propertyLines[$i]
                        if ($line.Contains("$propertyName =")) {
                            $value = Get-QuotedValue -Text $line

                            # Handle strings defined on the line after the property.
                            if (-not $value) {
                                $value = Get-QuotedValue -Text $propertyLines[$i + 1]
                            }

                            return $value
                        }
                    }
                }

                return $value
            }
        }

        $classDefinitionPattern = 'class .*Analyzer : .*?Analyzer'
        $ruleDefinitionStartMatch = 'static readonly DiagnosticDescriptor Rule'
        $ruleDefinitionEndMatch = ');'

        $severityGroupName = 'severity'
        $severityPattern = "DiagnosticSeverity\.(?<$severityGroupName>.*?),"
    }
    process {
        $lines = Get-GitHubFileLine -Uri $Uri

        $indexer = [Indexer]::new()
        $state = [IndexerState]::ClassDefinition
        for ($i = 0; $i -lt $lines.Length; $i++) {
            $line = $lines[$i]

            if ($state -eq [IndexerState]::ClassDefinition) {
                if ($line -match $classDefinitionPattern) {
                    $indexer.SetClassDefinition($i)
                    $state = [IndexerState]::RuleDefinitionStart
                }

                continue
            }

            if ($state -eq [IndexerState]::RuleDefinitionStart) {
                if ($line.Contains($ruleDefinitionStartMatch)) {
                    $indexer.SetRuleDefinitionStart($i)
                    $state = [IndexerState]::RuleDefinitionEnd
                }

                continue
            }

            if ($state -eq [IndexerState]::RuleDefinitionEnd) {
                if ($line.Contains($ruleDefinitionEndMatch)) {
                    $indexer.SetRuleDefinitionEnd($i)
                    break
                }

                continue
            }
        }

        $propertyLines = $lines[($indexer.ClassDefinition + 1)..($indexer.RuleDefinitionStart - 1)]
        $ruleLines = $lines[($indexer.RuleDefinitionStart + 1)..($indexer.RuleDefinitionEnd)]

        $id = Get-RuleLineValue -RuleLine $ruleLines[0] -PropertyLine $propertyLines
        $title = Get-RuleLineValue -RuleLine $ruleLines[1] -PropertyLine $propertyLines
        $category = Get-RuleLineValue -RuleLine $ruleLines[3] -PropertyLine $propertyLines
        $severity = $ruleLines[4] |
            Select-String -Pattern $severityPattern |
            Select-Object -ExpandProperty Matches |
            Select-Object -ExpandProperty Groups |
            Where-Object -Property Name -EQ $severityGroupName |
            Select-Object -ExpandProperty Value

        $ruleReadmeLine = $ReadmeLine |
            Where-Object { $_.StartsWith("### ${id}:") }
        $headerText = $ruleReadmeLine.Substring(4)
        $headerAnchor = Format-MarkdownAnchor -Text $headerText

        $rule = [pscustomobject]@{
            id = $id
            title = $title
            category = $category
            helpUri = $HelpUriFormat -f $headerAnchor
            default = $severity
        }

        $rule
    }
}
