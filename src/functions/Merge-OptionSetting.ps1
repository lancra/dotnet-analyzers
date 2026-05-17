function Merge-OptionSetting {
    [CmdletBinding()]
    param ()
    begin {
        $actionProperty = 'Action'
        $ruleSetProperty = 'RuleSet'
        $nameProperty = 'Name'
        $defaultProperty = 'Default'
        $valueProperty = 'Value'
        $reasoningProperty = 'Reasoning'
    }
    process {
        $rawOnlineOptions = @()
        Get-RuleSet |
            ForEach-Object {
                $ruleSet = $_
                $optionsPath = Get-RuleSetFile -RuleSet $ruleSet.Id -File 'options.json'
                if (-not (Test-Path -Path $optionsPath)) {
                    return
                }

                $ruleSetOptions = Get-Content -Path $optionsPath |
                    ConvertFrom-Json |
                    Select-Object -ExpandProperty 'options'

                $ruleSetOptions | Add-Member -MemberType NoteProperty -Name $ruleSetProperty -Value $ruleSet.Name

                $rawOnlineOptions += $ruleSetOptions
            }

        $selectProperties = @(
            $ruleSetProperty,
            @{Name = $nameProperty; Expression = {$_.name}},
            @{Name = $defaultProperty;Expression = {$_.default}}
        )
        $onlineOptions = $rawOnlineOptions | Select-Object -Property $selectProperties

        $settingsPath = Get-DataSetFile -File 'option-settings.csv'
        $localOptions = Get-Setting -Path $settingsPath

        $names = @()
        $names += $onlineOptions | Select-Object -ExpandProperty $nameProperty
        $names += $localOptions | Select-Object -ExpandProperty $nameProperty

        $mergedOptions = $names |
            Select-Object -Unique |
            Sort-Object |
            ForEach-Object {
                $onlineOption = $onlineOptions |
                    Where-Object -Property $nameProperty -EQ $_ |
                    Select-Object -First 1

                $localOption = $localOptions |
                    Where-Object -Property $nameProperty -EQ $_ |
                    Select-Object -First 1

                $option = [PSCustomObject]@{
                    $ruleSetProperty = $onlineOption.$ruleSetProperty ?? $localOption.$ruleSetProperty
                    $nameProperty = $onlineOption.$nameProperty ?? $localOption.$nameProperty
                    $defaultProperty = $onlineOption.$defaultProperty ?? $localOption.$defaultProperty
                    $valueProperty = $localOption.$valueProperty
                    $reasoningProperty = $localOption.$reasoningProperty
                }

                if (-not ($option.PSObject.Properties | Where-Object -Property Name -EQ $actionProperty)) {
                    $option | Add-Member -MemberType NoteProperty -Name $actionProperty -Value 'None'
                }

                if ($localOption) {
                    if (-not $onlineOption) {
                        $option.$actionProperty = 'Removed'
                    }
                } else {
                    $option.$actionProperty = 'New'
                }

                $option
            }

        $outputProperties = @(
            $actionProperty,
            $ruleSetProperty,
            $nameProperty,
            $defaultProperty,
            $valueProperty,
            $reasoningProperty
        )

        $mergedOptions |
            Select-Object -Property $outputProperties |
            Sort-Object -Property $nameProperty |
            Export-Csv -Path $settingsPath -UseQuotes AsNeeded
    }
}
