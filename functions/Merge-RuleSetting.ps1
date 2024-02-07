function Merge-RuleSetting {
    [CmdletBinding()]
    param ()
    begin {
        . "$env:DOTNET_ANALYZERS_FUNCTIONS/Get-Setting.ps1"

        $actionProperty = 'Action'
        $idProperty = 'Id'
        $titleProperty = 'Title'
        $groupProperty = 'Group'
        $categoryProperty = 'Category'
        $severityProperty = 'Severity'
        $reasoningProperty = 'Reasoning'
    }
    process {
        $rulesets = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/rulesets.csv"

        $rawOnlineRules = @()
        $rulesets |
            ForEach-Object {
                $groupRules = Get-Content -Path "$env:DOTNET_ANALYZERS_RULESETS/$($_.Directory)/rules.json" |
                    ConvertFrom-Json |
                    Select-Object -ExpandProperty 'rules'

                $groupRules | Add-Member -MemberType NoteProperty -Name $groupProperty -Value $_.Name

                $rawOnlineRules += $groupRules
            }

        $selectProperties = @(
            @{Name = $idProperty; Expression = {$_.id}},
            @{Name = $titleProperty;Expression = {$_.title}},
            $groupProperty,
            @{Name = $categoryProperty;Expression = {$_.category}}
        )
        $onlineRules = $rawOnlineRules | Select-Object -Property $selectProperties

        $settingsPath = "$env:DOTNET_ANALYZERS_DATASETS/rule-settings.csv"
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

                    $rule | Add-Member -MemberType NoteProperty -Name $severityProperty -Value ''
                    $rule | Add-Member -MemberType NoteProperty -Name $reasoningProperty -Value ''
                }

                $rule
            }

        $outputProperties = @(
            $idProperty,
            $titleProperty,
            $groupProperty,
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
