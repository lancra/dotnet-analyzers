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
    [string] $RuleSet,
    [switch] $SkipDownload,
    [switch] $MergeConfiguration,
    [switch] $IncludeVersion
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
