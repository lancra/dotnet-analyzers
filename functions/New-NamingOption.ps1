function New-NamingOption {
    [CmdletBinding()]
    [OutputType([string[]])]
    param()
    begin {
        $configurationPath = Join-Path -Path $PSScriptRoot -ChildPath '..' -AdditionalChildPath 'configuration.json'
        $ruleSetProperties = Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'ruleSets' |
            Where-Object -Property 'id' -EQ 'dotnet-code-style' |
            Select-Object -ExpandProperty 'properties'

        function Write-ValidationFailure {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory)]
                [string] $Message
            )
            process {
                Write-Output "`e[31m$Message`e[39m"
            }
        }

        $sourceDirectoryPath = Join-Path -Path $PSScriptRoot -ChildPath '..' -AdditionalChildPath 'data-sets', 'naming'
        function Get-Source {
            [CmdletBinding()]
            [OutputType([pscustomobject[]])]
            param(
                [Parameter(Mandatory)]
                [string] $FileName
            )
            process {
                $path = Join-Path -Path $sourceDirectoryPath -ChildPath $FileName
                Get-Content -Path $path |
                    ConvertFrom-Csv |
                    Sort-Object -Property Name
            }
        }

        function Test-Duplicate {
            [CmdletBinding()]
            [OutputType([string[]])]
            param(
                [Parameter(Mandatory)]
                [AllowEmptyCollection()]
                [pscustomobject[]] $Object,

                [Parameter(Mandatory)]
                [string] $Kind
            )
            process {
                $duplicateGroups = @($Object |
                    Where-Object { -not [string]::IsNullOrEmpty($_.Name) } |
                    Group-Object -Property Name |
                    Where-Object -Property Count -GT 1)
                if ($duplicateGroups.Length -eq 0) {
                    return @()
                }

                return $duplicateGroups |
                    ForEach-Object {
                        "The $Kind name $($_.Name) was defined $($_.Count) times instead of once."
                    }
            }
        }

        function Test-Required {
            [CmdletBinding()]
            [OutputType([string[]])]
            param(
                [Parameter(Mandatory)]
                [AllowEmptyCollection()]
                [pscustomobject[]] $Object,

                [Parameter(Mandatory)]
                [string] $Kind,

                [Parameter(Mandatory)]
                [string] $Property
            )
            process {
                $script:messages = @()
                $Object |
                    ForEach-Object {
                        $value = $_.$Property
                        if (-not [string]::IsNullOrEmpty($value)) {
                            return
                        }

                        $script:messages += "The required $Property value for $Kind $($_.Name) was not provided."
                    }

                return $script:messages
            }
        }

        $severities = Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'severities' |
            Select-Object -ExpandProperty 'id'
        function Test-Lookup {
            [CmdletBinding(DefaultParameterSetName = 'Lookup')]
            [OutputType([string[]])]
            param(
                [Parameter(Mandatory)]
                [AllowEmptyCollection()]
                [pscustomobject[]] $Object,

                [Parameter(Mandatory)]
                [string] $Kind,

                [Parameter(Mandatory)]
                [string] $Property,

                [Parameter(Mandatory, ParameterSetName = 'Lookup')]
                [string] $Lookup,

                [Parameter(Mandatory, ParameterSetName = 'LookupValue')]
                [string[]] $LookupValue,

                [Parameter(Mandatory, ParameterSetName = 'LookupValue')]
                [string] $LookupKind,

                [switch] $Multiple
            )
            begin {
                $lookupValues = switch ($PSCmdlet.ParameterSetName) {
                    'Lookup' {
                        Get-Content -Path $configurationPath |
                            ConvertFrom-Json |
                            Select-Object -ExpandProperty 'naming' |
                            Select-Object -ExpandProperty $Lookup
                    }
                    'LookupValue' { $LookupValue }
                }
                $listName = $PSCmdlet.ParameterSetName -eq 'Lookup' ? $Lookup : $LookupKind
            }
            process {
                $script:messages = @()
                $Object |
                    ForEach-Object {
                        $objectValue = $_.$Property
                        if ([string]::IsNullOrEmpty($objectValue)) {
                            return
                        }

                        $objectName = $_.Name
                        $objectValues = @($Multiple ? $objectValue -split ',' : $objectValue)
                        $objectValues |
                            ForEach-Object {
                                if (-not ($_ -in $lookupValues)) {
                                    $script:messages += `
                                        "The $Property value '$_' for $Kind $objectName was not in the configured $listName list."
                                }
                            }
                    }

                return $script:messages
            }
        }

        $referenceCounter = @{}
        function Test-Reference {
            [CmdletBinding()]
            [OutputType([string[]])]
            param(
                [Parameter(Mandatory)]
                [AllowEmptyCollection()]
                [pscustomobject[]] $Object,

                [Parameter(Mandatory)]
                [string] $Kind,

                [Parameter(Mandatory)]
                [string] $Property,

                [Parameter(Mandatory)]
                [pscustomobject[]] $ReferenceObject,

                [Parameter(Mandatory)]
                [string] $ReferenceKind
            )
            process {
                $script:messages = @()
                $Object |
                    ForEach-Object {
                        $referenceName = $_.$Property
                        if ([string]::IsNullOrEmpty($referenceName)) {
                            return
                        }

                        $referenceKey = "${ReferenceKind}:$referenceName"
                        if (-not $referenceCounter.ContainsKey($referenceKey)) {
                            $referenceCounter[$referenceKey] = 0
                        }

                        $referenceCount = $ReferenceObject |
                            Where-Object -Property Name -EQ $referenceName |
                            Measure-Object |
                            Select-Object -ExpandProperty Count
                        if ($referenceCount -gt 0) {
                            $referenceCounter[$referenceKey]++
                            return
                        }

                        $script:messages += `
                            "The $Property value '$referenceName' for $Kind $($_.Name) does not have a matching $ReferenceKind."
                    }

                return $script:messages
            }
        }
    }
    process {
        $messages = @()
        if (-not $ruleSetProperties.includeNaming) {
            return $messages
        }

        $styleKind = 'style'
        $styles = Get-Source -FileName 'styles.csv'
        $messages += Test-Required -Object $styles -Kind $styleKind -Property 'Name'
        $messages += Test-Required -Object $styles -Kind $styleKind -Property 'Capitalization'
        $messages += Test-Duplicate -Object $styles -Kind $styleKind
        $messages += Test-Lookup -Object $styles -Kind $styleKind -Property 'Capitalization' -Lookup 'capitalizations'

        $symbolKind = 'symbol'
        $symbols = Get-Source -FileName 'symbols.csv'
        $messages += Test-Required -Object $symbols -Kind $symbolKind -Property 'Name'
        $messages += Test-Required -Object $symbols -Kind $symbolKind -Property 'Kinds'
        $messages += Test-Required -Object $symbols -Kind $symbolKind -Property 'Accessibilities'
        $messages += Test-Duplicate -Object $symbols -Kind $symbolKind
        $messages += Test-Lookup -Object $symbols -Kind $symbolKind -Property 'Kinds' -Lookup 'symbols' -Multiple
        $messages += Test-Lookup -Object $symbols -Kind $symbolKind -Property 'Accessibilities' -Lookup 'accessibilities' -Multiple
        $messages += Test-Lookup -Object $symbols -Kind $symbolKind -Property 'Modifiers' -Lookup 'modifiers' -Multiple

        $ruleKind = 'rule'
        $rules = @(Get-Source -FileName 'rules.csv' |
            Where-Object { [bool]::Parse($_.Enabled) })
        $messages += Test-Required -Object $rules -Kind $ruleKind -Property 'Name'
        $messages += Test-Required -Object $rules -Kind $ruleKind -Property 'Symbol'
        $messages += Test-Required -Object $rules -Kind $ruleKind -Property 'Style'
        $messages += Test-Required -Object $rules -Kind $ruleKind -Property 'Severity'
        $messages += Test-Duplicate -Object $rules -Kind $ruleKind
        $messages += Test-Reference -Object $rules -Kind $ruleKind -Property 'Symbol' -ReferenceObject $symbols -ReferenceKind $symbolKind
        $messages += Test-Reference -Object $rules -Kind $ruleKind -Property 'Style' -ReferenceObject $styles -ReferenceKind $styleKind
        $messages += Test-Lookup -Object $rules -Kind $ruleKind -Property 'Severity' -LookupValue $severities -LookupKind 'severities'

        $messages |
            ForEach-Object {
                Write-ValidationFailure -Message $_
            }

        if ($messages.Length -gt 0) {
            throw "One or more naming specifications failed validation."
        }

        $lines = @()

        $lines += $symbols |
            ForEach-Object {
                $referenceKey = "${symbolKind}:$($_.Name)"
                $referenceCount = $referenceCounter[$referenceKey] ?? 0
                if ($referenceCount -eq 0) {
                    return
                }

                $prefix = "dotnet_naming_symbols.$($_.Name)"
                $symbolLines = @(
                    "$prefix.applicable_kinds = $($_.Kinds)",
                    "$prefix.applicable_accessibilities = $($_.Accessibilities)"
                )

                if (-not [string]::IsNullOrEmpty($_.Modifiers)) {
                    $symbolLines += "$prefix.required_modifiers = $($_.Modifiers)"
                }

                $symbolLines
            }

        $lines += $styles |
            ForEach-Object {
                $referenceKey = "${styleKind}:$($_.Name)"
                $referenceCount = $referenceCounter[$referenceKey] ?? 0
                if ($referenceCount -eq 0) {
                    return
                }

                $prefix = "dotnet_naming_style.$($_.Name)"
                $styleLines = @("$prefix.capitalization = $($_.Capitalization)")

                if (-not [string]::IsNullOrEmpty($_.Prefix)) {
                    $styleLines += "$prefix.required_prefix = $($_.Prefix)"
                }

                if (-not [string]::IsNullOrEmpty($_.Suffix)) {
                    $styleLines += "$prefix.required_suffix = $($_.Suffix)"
                }

                if (-not [string]::IsNullOrEmpty($_.Separator)) {
                    $styleLines += "$prefix.word_separator = $($_.Separator)"
                }

                $styleLines
            }

        $lines += $rules |
            ForEach-Object {
                $prefix = "dotnet_naming_rule.$($_.Name)"
                @(
                    "$prefix.symbols = $($_.Symbol)",
                    "$prefix.style = $($_.Style)",
                    "$prefix.severity = $($_.Severity)"
                )
            }

        $lines
    }
}
