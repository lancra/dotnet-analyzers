[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter()]
    [string]$RuleSet,
    [switch]$SkipDownload,
    [switch]$MergeConfiguration,
    [switch]$IncludeVersion
)

. "$PSScriptRoot/functions/Switch-Environment.ps1"

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
