[CmdletBinding()]
param ()

. "$PSScriptRoot/Get-DocumentationUri.ps1"
. "$PSScriptRoot/Get-FormattingOption.ps1"

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

$ruleIndexUrl = Get-DocumentationUri -Document 'index.md'
$csharpFormattingUrl = Get-DocumentationUri -Document 'csharp-formatting-options.md'
$dotnetFormattingUrl = Get-DocumentationUri -Document 'dotnet-formatting-options.md'

$tableTitleHeader = '> | Rule ID | Title | Option |'

$ruleSet = Get-RuleSet -Id ([uri]::new($PSScriptRoot).Segments[-1])

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
$ruleSetDirectoryPath = $PSScriptRoot

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

        $rule = [PSCustomObject]@{
            id = $rowValues[0]
            title = $rowValues[1]
            helpUri = $ruleSet.HelpUriFormat -f $links[$rowValues[0]].Trim('.md')
            options = @()
        }

        $urls = @()

        $optionsText = $rowValues[2]
        if ($rule.id -eq 'IDE0055') {
            $urls += ,$csharpFormattingUrl
            $urls += ,$dotnetFormattingUrl
        } elseif ($optionsText) {
            $urls += (Get-DocumentationUri -Document $links[$rule.id])
        }

        if ($urls.Length -gt 0) {
            $optionsJob = Start-ThreadJob -Name $rule.Id -ScriptBlock {
                param(
                    [string[]]$Urls
                )

                ${function:Get-FormattingOption} = $using:optionsFunctionDefinition

                $options = @()
                $urls |
                    ForEach-Object {
                        $options += (Get-FormattingOption -Url $_ -Directory $using:ruleSetDirectoryPath)
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

$output = [ordered]@{
    '$schema' = $env:DOTNET_ANALYZERS_SCHEMA
    timestamp = Get-Date -Format 'o'
    rules = $rules |
        Sort-Object -Property 'id'
}

if (Test-RuleSetDifference -Path $path -Json ($output.rules | ConvertTo-Json -Depth $jsonDepth)) {
    $output | ConvertTo-Json -Depth $jsonDepth > $path
}
