function Merge-OptionSetting {
    [CmdletBinding()]
    param ()
    begin {
        . "$env:DOTNET_ANALYZERS_FUNCTIONS/Get-Setting.ps1"

        $actionProperty = 'Action'
        $nameProperty = 'Name'
        $idProperty = 'Id'
        $ruleSetProperty = 'RuleSet'
        $categoryProperty = 'Category'
        $defaultProperty = 'Default'
        $valueProperty = 'Value'
        $reasoningProperty = 'Reasoning'
    }
    process {
        $ruleSets = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-sets.csv"

        $rawOnlineOptions = @()
        $ruleSets |
            ForEach-Object {
                $rulesPath = "$env:DOTNET_ANALYZERS_RULE_SETS/$($_.Directory)/rules.json"
                if (-not (Test-Path -Path $rulesPath)) {
                    Write-Warning "Skipping merge of $($_.Name) option settings, no downloaded rules found"
                    return
                }

                $ruleSetOptions = Get-Content -Path $rulesPath |
                    ConvertFrom-Json |
                    Select-Object -ExpandProperty 'rules' |
                    Where-Object -Property 'options' |
                    Select-Object -Property 'id' -ExpandProperty 'options'

                $ruleSetOptions | Add-Member -MemberType NoteProperty -Name $ruleSetProperty -Value $_.Name
                $ruleSetOptions | Add-Member -MemberType NoteProperty -Name $categoryProperty -Value ''

                $rawOnlineOptions += $ruleSetOptions
            }

        $selectProperties = @(
            @{Name = $nameProperty; Expression = {$_.name}},
            @{Name = $idProperty; Expression = {$_.id}},
            $ruleSetProperty,
            $categoryProperty,
            @{Name = $defaultProperty;Expression = {$_.default}}
        )
        $onlineOptions = $rawOnlineOptions | Select-Object -Property $selectProperties

        $settingsPath = "$env:DOTNET_ANALYZERS_DATA_SETS/option-settings.csv"
        $localOptions = Get-Setting -Path $settingsPath

        $names = @()
        $names += $onlineOptions | Select-Object -ExpandProperty $nameProperty
        $names += $localOptions | Select-Object -ExpandProperty $nameProperty

        $script:atLeastOneAction = $false
        $mergedOptions = $names |
            Select-Object -Unique |
            Sort-Object |
            ForEach-Object {
                $matchingOnlineOptions = $onlineOptions | Where-Object -Property $nameProperty -EQ $_
                $onlineOption = $matchingOnlineOptions | Select-Object -First 1
                if ($matchingOnlineOptions.Length -gt 1) {
                    $onlineOption.$idProperty = ($matchingOnlineOptions |
                        Select-Object -ExpandProperty $idProperty |
                        Sort-Object) -join '/'
                }

                $localOption = $localOptions | Where-Object -Property $nameProperty -EQ $_ | Select-Object -First 1

                $option = $localOption ?? $onlineOption

                if (-not ($option.PSObject.Properties | Where-Object -Property Name -EQ $actionProperty)) {
                    $option | Add-Member -MemberType NoteProperty -Name $actionProperty -Value ''
                }

                if ($localOption) {
                    if (-not $onlineOption) {
                        $option.$actionProperty = 'Removed'
                        $script:atLeastOneAction = $true
                    }
                } else {
                    $option.$actionProperty = 'New'
                    $script:atLeastOneAction = $true

                    $option | Add-Member -MemberType NoteProperty -Name $valueProperty -Value ''
                    $option | Add-Member -MemberType NoteProperty -Name $reasoningProperty -Value ''
                }

                $option
            }

        $outputProperties = @(
            $nameProperty,
            $idProperty,
            $ruleSetProperty,
            $categoryProperty,
            $defaultProperty,
            $valueProperty,
            $reasoningProperty
        )
        if ($script:atLeastOneAction) {
            $outputProperties = ,$actionProperty + $outputProperties
        }

        $mergedOptions |
            Select-Object -Property $outputProperties |
            Export-Csv -Path $settingsPath -UseQuotes AsNeeded
    }
}
