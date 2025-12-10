<#
.SYNOPSIS
Builds up-to-date .NET analyzer configurations.

.DESCRIPTION
Downloads latest analyzer metadata from remote sources and merges it with
repository settings in order to generate configuration that can be consumed
within .NET projects.

.PARAMETER RuleSet
Specifies the ruleset to download metadata for. Metadata is downloaded for all
rulesets when this is not provided.

.PARAMETER SkipDownload
Specifies that the remote metadata download should not be executed.

.PARAMETER MergeConfiguration
Specifies that the resulting configuration should be represented by a single
globalconfig file. The default is to place rule configurations in the
globalconfig file and option configurations in the partial editorconfig file.

.PARAMETER IncludeVersion
Specifies that the repository version should be added as a header in generated
configuration files.
#>
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter()]
    [ValidateScript(
        {
            $ruleSetIds = Get-Content -Path $PSScriptRoot/configuration.json |
                ConvertFrom-Json |
                Select-Object -ExpandProperty 'ruleSets' |
                Select-Object -ExpandProperty 'id'
            $_ -in $ruleSetIds
        },
        ErrorMessage = 'Rule set not found.')]
    [ArgumentCompleter(
        {
            param($commandName, $parameterName, $wordToComplete)
            $ruleSetIds = Get-Content -Path $PSScriptRoot/configuration.json |
                ConvertFrom-Json |
                Select-Object -ExpandProperty 'ruleSets' |
                Select-Object -ExpandProperty 'id'
            $ruleSetIds -like "$wordToComplete*"
        })]
    [string] $RuleSet,
    [switch] $SkipDownload,
    [switch] $MergeConfiguration,
    [switch] $IncludeVersion
)

. "$PSScriptRoot/functions/Format-Plaintext.ps1"
. "$PSScriptRoot/functions/Get-RuleSet.ps1"
. "$PSScriptRoot/functions/Get-Setting.ps1"
. "$PSScriptRoot/functions/Get-Severity.ps1"
. "$PSScriptRoot/functions/Get-Version.ps1"
. "$PSScriptRoot/functions/Merge-OptionSetting.ps1"
. "$PSScriptRoot/functions/Merge-RuleSetting.ps1"
. "$PSScriptRoot/functions/New-NamingOption.ps1"
. "$PSScriptRoot/functions/New-OptionConfiguration.ps1"
. "$PSScriptRoot/functions/New-RuleConfiguration.ps1"
. "$PSScriptRoot/functions/Switch-Environment.ps1"
. "$PSScriptRoot/functions/Test-RuleSetDifference.ps1"

try {
    New-Item -ItemType Directory -Path "$PSScriptRoot/artifacts" -Force | Out-Null

    Switch-Environment

    if (-not $SkipDownload) {
        & "$PSScriptRoot/scripts/download-rules.ps1" -RuleSet $RuleSet
    }

    & "$PSScriptRoot/scripts/generate-settings.ps1"

    & "$PSScriptRoot/scripts/generate-configurations.ps1" `
        -MergeConfiguration:$MergeConfiguration `
        -IncludeVersion:$IncludeVersion
}
finally {
    Switch-Environment
}
