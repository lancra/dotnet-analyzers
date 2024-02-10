function Merge-RuleSetting {
    [CmdletBinding()]
    param ()
    begin {
        . "$env:DOTNET_ANALYZERS_FUNCTIONS/Get-Setting.ps1"

        $actionProperty = 'Action'
        $idProperty = 'Id'
        $titleProperty = 'Title'
        $ruleSetProperty = 'RuleSet'
        $categoryProperty = 'Category'
        $severityProperty = 'Severity'
        $reasoningProperty = 'Reasoning'
    }
    process {
        $ruleSets = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-sets.csv"

        $rawOnlineRules = @()
        $ruleSets |
            ForEach-Object {
                $rulesPath = "$env:DOTNET_ANALYZERS_RULE_SETS/$($_.Directory)/rules.json"
                if (-not (Test-Path -Path $rulesPath)) {
                    Write-Warning "Skipping merge of $($_.Name) rule settings, no downloaded rules found"
                    return
                }

                $ruleSetRules = Get-Content -Path $rulesPath |
                    ConvertFrom-Json |
                    Select-Object -ExpandProperty 'rules'

                $ruleSetRules | Add-Member -MemberType NoteProperty -Name $ruleSetProperty -Value $_.Name

                $rawOnlineRules += $ruleSetRules
            }

        $selectProperties = @(
            @{Name = $idProperty; Expression = {$_.id}},
            @{Name = $titleProperty; Expression = {$_.title}},
            $ruleSetProperty,
            @{Name = $categoryProperty; Expression = {$_.category}},
            @{Name = $severityProperty; Expression = {$_.default}}
        )
        $onlineRules = $rawOnlineRules | Select-Object -Property $selectProperties

        $settingsPath = "$env:DOTNET_ANALYZERS_DATA_SETS/rule-settings.csv"
        $localRules = Get-Setting -Path $settingsPath

        $ids = @()
        $ids += $onlineRules | Select-Object -ExpandProperty $idProperty
        $ids += $localRules | Select-Object -ExpandProperty $idProperty

        $script:atLeastOneAction = $false
        $mergedRules = $ids |
            Select-Object -Unique |
            ForEach-Object {
                $onlineRule = $onlineRules | Where-Object -Property $idProperty -EQ $_ | Select-Object -First 1
                $localRule = $localRules | Where-Object -Property $idProperty -EQ $_ | Select-Object -First 1

                $rule = $localRule ?? $onlineRule

                if (-not ($rule.PSObject.Properties | Where-Object -Property Name -EQ $actionProperty)) {
                    $rule | Add-Member -MemberType NoteProperty -Name $actionProperty -Value ''
                }

                if ($localRule) {
                    if (-not $onlineRule) {
                        $rule.$actionProperty = 'Removed'
                        $script:atLeastOneAction = $true
                    }
                } else {
                    $rule.$actionProperty = 'New'
                    $script:atLeastOneAction = $true

                    $rule | Add-Member -MemberType NoteProperty -Name $reasoningProperty -Value ''
                }

                $rule
            }

        $outputProperties = @(
            $idProperty,
            $titleProperty,
            $ruleSetProperty,
            $categoryProperty,
            $severityProperty,
            $reasoningProperty
        )
        if ($script:atLeastOneAction) {
            $outputProperties = ,$actionProperty + $outputProperties
        }

        $mergedRules |
            Select-Object -Property $outputProperties |
            Export-Csv -Path $settingsPath -UseQuotes AsNeeded

    }
}
