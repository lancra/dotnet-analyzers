function Merge-RuleSetting {
    [CmdletBinding()]
    param ()
    begin {
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
                $rulesPath = Get-RuleSetFile -RuleSet $ruleSet.Id -File 'rules.json'
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
                    $rule | Add-Member -MemberType NoteProperty -Name $actionProperty -Value 'None'
                }

                if ($localRule) {
                    if (-not $onlineRule) {
                        $rule.$actionProperty = 'Removed'
                    }
                } else {
                    $rule.$actionProperty = 'New'
                }

                $rule
            }

        $outputProperties = @(
            $actionProperty,
            $idProperty,
            $titleProperty,
            $ruleSetProperty,
            $categoryProperty,
            $severityProperty,
            $reasoningProperty
        )

        $mergedRules |
            Select-Object -Property $outputProperties |
            Sort-Object -Property $ruleSetProperty, $categoryProperty, $idProperty |
            Export-Csv -Path $settingsPath -UseQuotes AsNeeded

    }
}
