function New-OptionConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param ()
    process {
        $settings = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATASETS/option-settings.csv"

        $settingFormat = '{0} = {1} # {2}'
        $builder = [System.Text.StringBuilder]::new()

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

        $artifactsDirectory = "$env:DOTNET_ANALYZERS_ROOT/artifacts"
        New-Item -ItemType Directory -Path $artifactsDirectory -Force | Out-Null

        $configurationPath = "$artifactsDirectory/partial.editorconfig"
        $builder.ToString() | Out-File -FilePath $configurationPath
    }
}
