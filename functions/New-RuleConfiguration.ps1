function New-RuleConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [switch]$IncludeOption,
        [switch]$IncludeVersion
    )
    begin {
        . "$env:DOTNET_ANALYZERS_FUNCTIONS/Get-Version.ps1"

        $severities = @{}
        Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/severities.csv" |
            ForEach-Object { $severities[$_.Name] = $_.Configuration }

        $ruleSets = @{}
        Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-sets.csv" |
            ForEach-Object { $ruleSets[$_.Name] = [bool]::Parse($_.Configure) }

        $categories = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/categories.csv" |
            Where-Object { $ruleSets[$_.RuleSet] }

        $ruleSettings = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-settings.csv" |
            Where-Object { $ruleSets[$_.RuleSet] }

        $ruleSettingsWithEmptySeverity = $ruleSettings |
            Where-Object { -not $_.Severity }
        if ($ruleSettingsWithEmptySeverity.Length -gt 0) {
            $ids = ($ruleSettingsWithEmptySeverity | Select-Object -ExpandProperty Id) -join ', '
            Write-Error "Please specify a severity for the following settings: $ids"
            throw 'All analyzer settings must specify a severity.'
        }

        $ruleSettingsWithUnmappedSeverity = $ruleSettings |
            Where-Object { $_.Severity -and -not $severities[$_.Severity] }
        if ($ruleSettingsWithUnmappedSeverity.Length -gt 0) {
            $invalidSeverities = ($ruleSettingsWithUnmappedSeverity | Select-Object -InputObject { "$($_.Id)=$($_.Severity)" }) -join ', '
            Write-Error "Please specify a valid severity for the following settings: $invalidSeverities"

            throw 'All analyzer settings must specify a valid severity.'
        }

        $optionSettings = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/option-settings.csv" |
            Where-Object { $ruleSets[$_.RuleSet] }

        $ruleSettingFormat = 'dotnet_diagnostic.{0}.severity = {1}'
        $optionSettingFormat = '{0} = {1} # {2}'
        $builder = [System.Text.StringBuilder]::new()
    }
    process {
        if ($IncludeVersion) {
            $version = Get-Version
            [void]$builder.AppendLine("# $version")
        }

        [void]$builder.AppendLine('is_global = true')
        [void]$builder.AppendLine()

        $categories |
            ForEach-Object -Begin { $script:i = 0 } -Process {
                $lastRuleSet = -not ($i -lt $categories.Length - 1)

                [void]$builder.Append('# ')
                [void]$builder.Append($_.RuleSet)
                [void]$builder.Append(': ')

                if ($_.Category) {
                    [void]$builder.Append($_.Category)
                    [void]$builder.Append(' ')
                }

                [void]$builder.Append('<')
                [void]$builder.Append($_.Url)
                [void]$builder.AppendLine('>')

                $ruleSettingLines = $ruleSettings |
                    Where-Object -Property RuleSet -EQ $_.RuleSet |
                    Where-Object -Property Category -EQ $_.Category |
                    ForEach-Object { $ruleSettingFormat -f $_.Id, $severities[$_.Severity] }

                $lines = $ruleSettingLines

                if ($IncludeOption) {
                    $optionSettingLines = $optionSettings |
                        Where-Object -Property RuleSet -EQ $_.RuleSet |
                        Where-Object -Property Category -EQ $_.Category |
                        ForEach-Object { $optionSettingFormat -f $_.Name, $_.Value, $_.Id }

                    if ($optionSettingLines) {
                        $lines += ,'' + $optionSettingLines
                    }
                }

                $lines |
                    ForEach-Object -Begin { $script:j = 0 } -Process {
                        $lastSetting = -not ($j -lt $lines.Length - 1)

                        [void]$builder.Append($_)

                        if (-not ($lastRuleSet -and $lastSetting)) {
                            [void]$builder.AppendLine()
                        }

                        $j++
                    }

                # Script scope required due to https://github.com/PowerShell/PSScriptAnalyzer/issues/1163
                $j = 0

                if (-not $lastRuleSet) {
                    [void]$builder.AppendLine()
                }

                $i++
            }

        $artifactsDirectory = "$env:DOTNET_ANALYZERS_ROOT/artifacts"
        New-Item -ItemType Directory -Path $artifactsDirectory -Force | Out-Null

        $configurationPath = "$artifactsDirectory/.globalconfig"
        $builder.ToString() | Out-File -FilePath $configurationPath
    }
}
