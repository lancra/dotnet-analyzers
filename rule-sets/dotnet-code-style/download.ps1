[CmdletBinding()]
param ()

. "$PSScriptRoot/Get-FormattingOption.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/Format-Plaintext.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/Test-RuleSetDifference.ps1"

function Read-Link {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Text
    )
    begin {
        $textGroup = 'Text'
        $urlGroup = 'Url'
    }
    process {
        $links = [ordered]@{}
        $Text |
            Select-String -Pattern "\[(?<$textGroup>.+?)\]\((?<$urlGroup>.+?)\)" -AllMatches |
            Select-Object -ExpandProperty Matches |
            ForEach-Object {
                $linkText = $_.Groups[$textGroup].Value
                $linkUrl = $_.Groups[$urlGroup].Value

                $links[$linkText] = $linkUrl
            }

        $links
    }
}

$urlFormat = 'https://raw.githubusercontent.com/dotnet/docs/main/docs/fundamentals/code-analysis/style-rules/{0}'
$ruleIndexUrl = $urlFormat -f 'index.md'
$csharpFormattingUrl = $urlFormat -f 'csharp-formatting-options.md'
$dotnetFormattingUrl = $urlFormat -f 'dotnet-formatting-options.md'

$tableTitleHeader = '> | Rule ID | Title | Option |'

enum RuleParserState {
    Search # Looking for a table title header in the document
    Header # Skipping the table alignment header
    Active # Parsing rules from the table
    Done # Ignoring any additional content
}
$state = [RuleParserState]::Search

$rules = @()

$optionsJobs = @()
$optionsFunctionDefinition = ${function:Get-FormattingOption}.ToString()

(& curl --silent $ruleIndexUrl) |
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

        if ($state -eq [RuleParserState]::Done) {
            return
        }

        if (-not $_) {
            $state = [RuleParserState]::Done
            return
        }

        # Remove '> | ' from the beginning of the line and ' |' from the end.
        $rawLine = $_.Substring(4, $_.Length - 6)
        $links = Read-Link $rawLine

        $rawLine = Format-Plaintext $rawLine
        $rowValues = ($rawLine -split '\|').Trim()

        $rule = [ordered]@{}
        $rule.id = $rowValues[0]
        $rule.title = $rowValues[1]
        $rule.options = @()

        $urls = @()

        $optionsText = $rowValues[2]
        if ($rule.id -eq 'IDE0055') {
            $urls += ,$csharpFormattingUrl
            $urls += ,$dotnetFormattingUrl
        } elseif ($optionsText) {
            $ruleUrl = $urlFormat -f $links[$rule.id]
            $urls += $ruleUrl
        }

        if ($urls.Length -gt 0) {
            $optionsJob = Start-ThreadJob -Name $rule.Id -ScriptBlock {
                param(
                    [string[]]$Urls
                )

                ${function:Get-FormattingOption} = $using:optionsFunctionDefinition

                $options = @()
                $Urls |
                    ForEach-Object {
                        $options += (Get-FormattingOption -Url $_)
                    }

                return ,$options
            } -ArgumentList (,$urls)
            $optionsJobs += $optionsJob
        }

        $rules += $rule
    }

$jsonDepth = 6
Wait-Job $optionsJobs | Out-Null
$optionsJobs |
    ForEach-Object {
        $options = Receive-Job -Job $_
        $rule = $rules |
            Where-Object -Property id -EQ $_.Name |
            Select-Object -First 1

        $rule.options = @($options |
            ConvertTo-Json -Depth $jsonDepth |
            ConvertFrom-Json)

        Remove-Job -Job $_
    }

$path = Join-Path -Path $PSScriptRoot -ChildPath 'rules.json'

$output = [ordered]@{}
$output.'$schema' = $env:DOTNET_ANALYZERS_SCHEMA
$output.timestamp = (Get-Date -Format 'o')
$output.rules = $rules

if (Test-RuleSetDifference -Path $path -Json ($output.rules | ConvertTo-Json -Depth $jsonDepth)) {
    $output | ConvertTo-Json -Depth $jsonDepth > $path
}
