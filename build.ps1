[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter()]
    [string]$RuleSet,
    [switch]$SkipDownload,
    [switch]$MergeConfiguration
)

. "$PSScriptRoot/functions/Switch-Environment.ps1"

try {
    Switch-Environment

    if (-not $SkipDownload) {
        & "$env:DOTNET_ANALYZERS_SCRIPTS/download-rules.ps1" -RuleSet $RuleSet
    }

    & "$env:DOTNET_ANALYZERS_SCRIPTS/generate-settings.ps1"
    & "$env:DOTNET_ANALYZERS_SCRIPTS/generate-configurations.ps1" -MergeConfiguration:$MergeConfiguration
}
finally {
    Switch-Environment
}
