function New-RuleConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param ()
    process {
        $severities = @{}
        Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/severities.csv" |
            ForEach-Object { $severities[$_.Name] = $_.Configuration }

        $ruleSets = @{}
        Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-sets.csv" |
            ForEach-Object { $ruleSets[$_.Name] = [bool]::Parse($_.Configure) }

        $categories = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/categories.csv" |
            Where-Object { $ruleSets[$_.RuleSet] }

        $settings = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-settings.csv" |
            Where-Object { $ruleSets[$_.RuleSet] }

        $settingsWithEmptySeverity = $settings |
            Where-Object { -not $_.Severity }
        if ($settingsWithEmptySeverity.Length -gt 0) {
            $ids = ($settingsWithEmptySeverity | Select-Object -ExpandProperty Id) -join ', '
            Write-Error "Please specify a severity for the following settings: $ids"
            throw 'All analyzer settings must specify a severity.'
        }

        $settingsWithUnmappedSeverity = $settings |
            Where-Object { $_.Severity -and -not $severities[$_.Severity] }
        if ($settingsWithUnmappedSeverity.Length -gt 0) {
            $invalidSeverities = ($settingsWithUnmappedSeverity | Select-Object -InputObject { "$($_.Id)=$($_.Severity)" }) -join ', '
            Write-Error "Please specify a valid severity for the following settings: $invalidSeverities"

            throw 'All analyzer settings must specify a valid severity.'
        }

        $settingFormat = 'dotnet_diagnostic.{0}.severity = {1}'
        $builder = [System.Text.StringBuilder]::new()

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

                $matchingSettings = $settings |
                    Where-Object -Property RuleSet -EQ $_.RuleSet |
                    Where-Object -Property Category -EQ $_.Category

                $matchingSettings |
                    ForEach-Object -Begin { $script:j = 0 } -Process {
                        $lastSetting = -not ($j -lt $matchingSettings.Length - 1)

                        $setting = $settingFormat -f $_.Id, $severities[$_.Severity]
                        [void]$builder.Append($setting)

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
