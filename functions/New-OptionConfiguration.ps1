function New-OptionConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [switch]$IncludeVersion
    )
    begin {
        . "$env:DOTNET_ANALYZERS_FUNCTIONS/Get-Version.ps1"

        $ruleSets = @{}
        Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/rule-sets.csv" |
            ForEach-Object { $ruleSets[$_.Name] = [bool]::Parse($_.Configure) }

        $settings = Import-Csv -Path "$env:DOTNET_ANALYZERS_DATA_SETS/option-settings.csv" |
            Where-Object { $ruleSets[$_.RuleSet] }

        if ($settings.Length -eq 0) {
            Write-Warning 'Skipping configuration generation, no options settings found'
            return
        }

        $settingFormat = '{0} = {1} # {2}'
        $builder = [System.Text.StringBuilder]::new()
    }
    process {
        if ($IncludeVersion) {
            $version = Get-Version
            [void]$builder.AppendLine("# $version")
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

        $artifactsDirectory = "$env:DOTNET_ANALYZERS_ROOT/artifacts"
        New-Item -ItemType Directory -Path $artifactsDirectory -Force | Out-Null

        $configurationPath = "$artifactsDirectory/partial.editorconfig"
        $builder.ToString() | Out-File -FilePath $configurationPath
    }
}
