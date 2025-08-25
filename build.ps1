[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter()]
    [string]$RuleSet,
    [switch]$SkipDownload,
    [switch]$MergeConfiguration,
    [switch]$IncludeVersion
)

. "$PSScriptRoot/functions/Format-Plaintext.ps1"
. "$PSScriptRoot/functions/Get-RuleSet.ps1"
. "$PSScriptRoot/functions/Get-Setting.ps1"
. "$PSScriptRoot/functions/Get-Version.ps1"
. "$PSScriptRoot/functions/Merge-OptionSetting.ps1"
. "$PSScriptRoot/functions/Merge-RuleSetting.ps1"
. "$PSScriptRoot/functions/New-OptionConfiguration.ps1"
. "$PSScriptRoot/functions/New-RuleConfiguration.ps1"
. "$PSScriptRoot/functions/Switch-Environment.ps1"
. "$PSScriptRoot/functions/Test-RuleSetDifference.ps1"

try {
    New-Item -ItemType Directory -Path "$PSScriptRoot/artifacts" -Force | Out-Null

    Switch-Environment

    if (-not $SkipDownload) {
        & "$env:DOTNET_ANALYZERS_SCRIPTS/download-rules.ps1" -RuleSet $RuleSet
    }

    & "$env:DOTNET_ANALYZERS_SCRIPTS/generate-settings.ps1"

    & "$env:DOTNET_ANALYZERS_SCRIPTS/generate-configurations.ps1" `
        -MergeConfiguration:$MergeConfiguration `
        -IncludeVersion:$IncludeVersion
}
finally {
    Switch-Environment
}
