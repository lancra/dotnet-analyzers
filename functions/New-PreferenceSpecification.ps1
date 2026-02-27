function New-PreferenceSpecification {
    [CmdletBinding()]
    [OutputType([bool])]
    param()
    begin {
        $script:hasChanges = $false

        $rootDirectoryPath = Join-Path -Path $PSScriptRoot -ChildPath '..'
        $configurationPath = Join-Path -Path $rootDirectoryPath -ChildPath 'configuration.json'

        $preferencesPath = Join-Path -Path $rootDirectoryPath -ChildPath '.preferences.json'
        $hasPreferences = Test-Path -Path $preferencesPath
        $getPreferences = { Get-Content -Path $preferencesPath | ConvertFrom-Json }

        function Get-PropertyName {
            [CmdletBinding()]
            [OutputType([string[]])]
            param(
                [Parameter(Mandatory)]
                [pscustomobject] $RuleSet
            )
            process {
                $RuleSet.properties.PSObject.Properties |
                    Select-Object -ExpandProperty Name
            }
        }

        function New-PropertyValue {
            [CmdletBinding()]
            [OutputType([object])]
            param(
                [Parameter(Mandatory)]
                [string] $Type
            )
            process {
                switch ($Type) {
                    'array' { New-Object System.Collections.ArrayList }
                    'bool' { $false }
                    'object' { [pscustomobject]@{} }
                    'string' { '' }
                    default { throw "Unrecognized property type '$Type'." }
                }
            }
        }
    }
    process {
        $preferences = $hasPreferences ? $getPreferences.Invoke() : [pscustomobject]@{}

        Get-Content -Path $configurationPath |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'ruleSets' |
            Select-Object -Property 'id', 'properties' |
            ForEach-Object {
                $newRuleSet = $_
                $hasRuleSet = $null -ne $preferences."$($newRuleSet.id)"
                if (-not $hasRuleSet) {
                    $script:hasChanges = $true
                    $ruleSet = [pscustomobject]@{
                        enabled = $true
                        properties = [pscustomobject]@{}
                    }

                    $preferences |
                        Add-Member -MemberType NoteProperty -Name $newRuleSet.id -Value $ruleSet
                }

                $existingRuleSet = $preferences."$($newRuleSet.id)"

                $propertyNames = @()
                $existingPropertyNames = Get-PropertyName -RuleSet $existingRuleSet
                $propertyNames += $existingPropertyNames
                $newPropertyNames = Get-PropertyName -RuleSet $newRuleSet
                $propertyNames += $newPropertyNames
                $propertyNames |
                    Select-Object -Unique |
                    ForEach-Object {
                        $name = $_
                        $isExisting = $null -ne ($existingPropertyNames |
                            Where-Object { $_ -eq $name })
                        $isNew = $null -ne ($newPropertyNames |
                            Where-Object { $_ -eq $name })

                        if ($isExisting -and $isNew) {
                            return
                        } elseif ($isExisting) {
                            $script:hasChanges = $true
                            $existingRuleSet.properties.PSObject.Properties.Remove($name)
                        } elseif ($isNew) {
                            $script:hasChanges = $true
                            $value = New-PropertyValue -Type $newRuleSet.properties.$name.type
                            $existingRuleSet.properties |
                                Add-Member -MemberType NoteProperty -Name $name -Value $value
                        }
                    }
            }

        $preferences |
            ConvertTo-Json -Depth 10 |
            Set-Content -Path $preferencesPath

        return $script:hasChanges
    }
}
