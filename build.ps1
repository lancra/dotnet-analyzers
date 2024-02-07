[CmdletBinding(SupportsShouldProcess)]
param (
    [switch]$SkipDownload
)

. "$PSScriptRoot/functions/Switch-Environment.ps1"

try {
    Switch-Environment

    if (-not $SkipDownload) {
        & "$env:DOTNET_ANALYZERS_SCRIPTS/download-rules.ps1"
    }

    & "$env:DOTNET_ANALYZERS_SCRIPTS/generate-settings.ps1"
}
finally {
    Switch-Environment
}
