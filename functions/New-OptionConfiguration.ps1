function New-OptionConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [switch]$IncludeVersion
    )
    begin {
        $enabledRuleSetNames = Get-RuleSet -Enabled |
            Select-Object -ExpandProperty Name

        $settings = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/option-settings.csv" |
            Where-Object {
                $optionRuleSet = $_.RuleSet
                $enabledRuleSetNames |
                    Where-Object { $_ -eq $optionRuleSet }
                }

        if ($settings.Length -eq 0) {
            Write-Warning 'Skipping configuration generation, no options settings found'
            return
        }

        $settingFormat = '{0} = {1} # {2}'
        $builder = [System.Text.StringBuilder]::new()
    }
    process {
        if ($IncludeVersion) {
            $versionComment = Get-VersionComment
            [void]$builder.AppendLine($versionComment)
        }

        [void]$builder.AppendLine('root = true')
        [void]$builder.AppendLine()
        [void]$builder.AppendLine('# TODO: Add editorconfig settings here that are not analyzer rule options.')
        [void]$builder.AppendLine()
        [void]$builder.AppendLine('[*.{cs,vb}]')

        $settings |
            ForEach-Object -Begin { $script:i = 0 } -Process {
                $lastSetting = -not ($i -lt $settings.Length - 1)

                $settingLine = $settingFormat -f $_.Name, $_.Value, $_.Id
                [void]$builder.Append($settingLine)

                if (-not $lastSetting) {
                    [void]$builder.AppendLine()
                }

                $i++
            }

        $namingSettings = New-NamingOption
        if ($namingSettings) {
            [void]$builder.AppendLine()
            [void]$builder.AppendLine()

            $namingSettings |
                ForEach-Object -Begin { $script:j = 0 } -Process {
                    $lastSetting = -not ($j -lt $namingSettings.Length - 1)
                    [void]$builder.Append($_)

                    if (-not $lastSetting) {
                        [void]$builder.AppendLine()
                    }

                    $j++
                }
        }

        $artifactsDirectory = "$env:DOTNET_ANALYZERS_ROOT/artifacts"
        New-Item -ItemType Directory -Path $artifactsDirectory -Force | Out-Null

        $configurationPath = "$artifactsDirectory/partial.editorconfig"
        $builder.ToString() | Out-File -FilePath $configurationPath
    }
}
