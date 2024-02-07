function New-RuleConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param ()
    process {
        $severities = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/severities.csv"
        $groups = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/groups.csv"
        $settings = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/rule-settings.csv"

        $severityMappings = @{}
        $severities | ForEach-Object { $severityMappings[$_.Name] = $_.Configuration }

        $settingsWithEmptySeverity = $settings |
            Where-Object { -not $_.Severity }
        if ($settingsWithEmptySeverity.Length -gt 0) {
            $ids = ($settingsWithEmptySeverity | Select-Object -ExpandProperty Id) -join ', '
            Write-Error "Please specify a severity for the following settings: $ids"
            throw 'All analyzer settings must specify a severity.'
        }

        $settingsWithUnmappedSeverity = $settings |
            Where-Object { $_.Severity -and -not $severityMappings[$_.Severity] }
        if ($settingsWithUnmappedSeverity.Length -gt 0) {
            $invalidSeverities = ($settingsWithUnmappedSeverity | Select-Object -InputObject { "$($_.Id)=$($_.Severity)" }) -join ', '
            Write-Error "Please specify a valid severity for the following settings: $invalidSeverities"

            throw 'All analyzer settings must specify a valid severity.'
        }

        $settingFormat = 'dotnet_diagnostic.{0}.severity = {1}'
        $builder = [System.Text.StringBuilder]::new()
        $groups |
            ForEach-Object -Begin { $script:i = 0 } -Process {
                $lastGroup = -not ($i -lt $groups.Length - 1)

                [void]$builder.Append('# ')
                [void]$builder.Append($_.Group)
                [void]$builder.Append(': ')

                if ($_.Category) {
                    [void]$builder.Append($_.Category)
                    [void]$builder.Append(' ')
                }

                [void]$builder.Append('<')
                [void]$builder.Append($_.Url)
                [void]$builder.AppendLine('>')

                $matchingSettings = $settings |
                    Where-Object -Property Group -EQ $_.Group |
                    Where-Object -Property Category -EQ $_.Category

                $matchingSettings |
                    ForEach-Object -Begin { $script:j = 0 } -Process {
                        $lastSetting = -not ($j -lt $matchingSettings.Length - 1)

                        $setting = $settingFormat -f $_.Id, $severityMappings[$_.Severity]
                        [void]$builder.Append($setting)

                        if (-not ($lastGroup -and $lastSetting)) {
                            [void]$builder.AppendLine()
                        }

                        $j++
                    }

                # Script scope required due to https://github.com/PowerShell/PSScriptAnalyzer/issues/1163
                $j = 0

                if (-not $lastGroup) {
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
