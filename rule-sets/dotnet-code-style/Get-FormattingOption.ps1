function Get-FormattingOption {
    [CmdletBinding()]
    [OutputType([ordered[]])]
    param (
        [Parameter(Mandatory)]
        [string]$Url
    )
    begin {
        . "$env:DOTNET_ANALYZERS_FUNCTIONS/Format-Plaintext.ps1"

        enum OptionParserState {
            Search # Looking for an option header in the document
            Header # Skipping the key-value table header
            Active # Parsing properties from the key-value table
        }
        $state = [OptionParserState]::Search

        $tableTitleHeaderPrefix = '| Property'

        $nameProperty = 'Option name'
        $firstValueProperty = 'Option values'
        $defaultProperty = 'Default option value'
        $pipeEscapeCharacter = '&#124;'

        $optionValueSpecifications = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/option-value-specifications.csv"
    }
    process {
        Write-Verbose "Parsing formatting options from $(Split-Path -Path $Url -Leaf)."
        $options = @()
        $currentOption = [ordered]@{}

        (& curl --silent $Url) |
            ForEach-Object {
                if ($state -eq [OptionParserState]::Search) {
                    if ($_.StartsWith($tableTitleHeaderPrefix)) {
                        $state = [OptionParserState]::Header
                    }

                    return
                }

                if ($state -eq [OptionParserState]::Header) {
                    $state = [OptionParserState]::Active
                    return
                }

                if (-not $_) {
                    $state = [OptionParserState]::Search
                    $options += $currentOption
                    $currentOption = [ordered]@{}
                    return
                }

                # Remove '| ' from the beginning of the line and ' |' from the end.
                $rawLine = $_.Substring(2, $_.Length - 4)
                $rowValues = ((Format-Plaintext $rawLine) -split '\|').Trim()

                # Skip rule tables, options table are all we're interested in here.
                if ($rowValues.Length -eq 2) {
                    $state = $state = [OptionParserState]::Search
                    return
                }

                $property = $rowValues[0]
                $value = $rowValues[1]

                # NOTE: Update the replacement value when .NET 9 is released in Nov-2024.
                $value = $value.Replace('true in .NET 8 when_types_loosely_match in .NET 9 and later versions', 'true')

                $valueObject = [ordered]@{ 'value' = $value; 'description' = $rowValues[2] }

                $pipeIndex = $value.IndexOf($pipeEscapeCharacter)
                if ($pipeIndex -ne -1) {
                    $valueObject.value = $value.Substring(0, $pipeIndex - 1)
                    $valueObject.Insert(1, 'alternate', $value.Substring($pipeIndex + $pipeEscapeCharacter.Length + 1))
                }

                $valueSpecification = $optionValueSpecifications |
                    Where-Object -Property 'Old' -EQ $value |
                    Select-Object -First 1
                if ($valueSpecification) {
                    if ($valueSpecification.New) {
                        $valueObject.value = $valueSpecification.New
                    }

                    $specification = $valueSpecification.Description
                    if (-not $specification) {
                        $specification = $valueSpecification.Old
                    }

                    $valueObject.Insert(@($valueObject.Keys).Length - 1, 'specification', $specification)
                }

                if ($property -eq $nameProperty) {
                    $currentOption.name = $value
                } elseif ($property -eq $firstValueProperty) {
                    $currentOption.values = @($valueObject)
                } elseif (-not $property) {
                    $currentOption.values += $valueObject
                } elseif ($property -eq $defaultProperty) {
                    $currentOption.default = $value
                }
            }

        $options
    }
}
