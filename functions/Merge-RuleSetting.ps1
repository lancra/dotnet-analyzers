function Merge-RuleSetting {
    [CmdletBinding()]
    param ()
    begin {
        . "$env:DOTNET_ANALYZERS_FUNCTIONS/Get-RuleSet.ps1"
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
        $rawOnlineRules = @()
        Get-RuleSet |
            ForEach-Object {
                $ruleSet = $_
                $rulesPath = "$env:DOTNET_ANALYZERS_RULE_SETS/$($ruleSet.Id)/rules.json"
                if (-not (Test-Path -Path $rulesPath)) {
                    Write-Warning "Skipping merge of $($ruleSet.Name) rule settings, no downloaded rules found"
                    return
                }

                $ruleSetRules = Get-Content -Path $rulesPath |
                    ConvertFrom-Json |
                    Select-Object -ExpandProperty 'rules' |
                    Sort-Object -Property 'category', 'id'

                $ruleSetRules | Add-Member -MemberType NoteProperty -Name $ruleSetProperty -Value $ruleSet.Name

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

                $rule = [PSCustomObject]@{
                    $idProperty = $onlineRule.$idProperty ?? $localRule.$idProperty
                    $titleProperty = $onlineRule.$titleProperty ?? $localRule.$titleProperty
                    $ruleSetProperty = $onlineRule.$ruleSetProperty ?? $localRule.$ruleSetProperty
                    $categoryProperty = $onlineRule.$categoryProperty ?? $localRule.$categoryProperty
                    $severityProperty = $localRule.$severityProperty ?? $onlineRule.$severityProperty
                    $reasoningProperty = $localRule.$reasoningProperty
                }

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
