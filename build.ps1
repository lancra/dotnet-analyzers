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

.PARAMETER DownloadOnly
Specifies that only the remote metadata download should be executed.

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
            $ruleSetIds = Get-Content -Path "$PSScriptRoot/configuration.json" |
                ConvertFrom-Json |
                Select-Object -ExpandProperty 'ruleSets' |
                Select-Object -ExpandProperty 'id'
            $_ -in $ruleSetIds
        },
        ErrorMessage = 'Rule set not found.')]
    [ArgumentCompleter(
        {
            param($commandName, $parameterName, $wordToComplete)
            $ruleSetIds = Get-Content -Path "$PSScriptRoot/configuration.json" |
                ConvertFrom-Json |
                Select-Object -ExpandProperty 'ruleSets' |
                Select-Object -ExpandProperty 'id'
            $ruleSetIds -like "$wordToComplete*"
        })]
    [string] $RuleSet,
    [switch] $SkipDownload,
    [switch] $DownloadOnly,
    [switch] $MergeConfiguration,
    [switch] $IncludeVersion
)

. "$PSScriptRoot/src/functions/Format-MarkdownAnchor.ps1"
. "$PSScriptRoot/src/functions/Format-Plaintext.ps1"
. "$PSScriptRoot/src/functions/Get-DataSetFile.ps1"
. "$PSScriptRoot/src/functions/Get-GitHubFileLine.ps1"
. "$PSScriptRoot/src/functions/Get-RuleSet.ps1"
. "$PSScriptRoot/src/functions/Get-RuleSetFile.ps1"
. "$PSScriptRoot/src/functions/Get-Setting.ps1"
. "$PSScriptRoot/src/functions/Get-Severity.ps1"
. "$PSScriptRoot/src/functions/Get-VersionComment.ps1"
. "$PSScriptRoot/src/functions/Merge-OptionSetting.ps1"
. "$PSScriptRoot/src/functions/Merge-RuleSetting.ps1"
. "$PSScriptRoot/src/functions/New-NamingOption.ps1"
. "$PSScriptRoot/src/functions/New-OptionConfiguration.ps1"
. "$PSScriptRoot/src/functions/New-PreferenceSpecification.ps1"
. "$PSScriptRoot/src/functions/New-RuleConfiguration.ps1"
. "$PSScriptRoot/src/functions/New-RuleSpecification.ps1"
. "$PSScriptRoot/src/functions/Test-RuleSetDifference.ps1"

$artifactsDirectory = Join-Path -Path $PSScriptRoot -ChildPath 'artifacts'
New-Item -ItemType Directory -Path $artifactsDirectory -Force |
    Out-Null

$artifactsDirectoryContents = Join-Path -Path $artifactsDirectory -ChildPath '*'
Remove-Item -Path $artifactsDirectoryContents

$preferencesChanged = New-PreferenceSpecification
if ($preferencesChanged) {
    Write-Output "`e[33mPreferences have been modified from the configuration. Review the settings and re-execute the build.`e[39m"
    return
}

if (-not $SkipDownload) {
    & "$PSScriptRoot/src/scripts/download-rules.ps1" -RuleSet $RuleSet
}

if (-not $DownloadOnly) {
    & "$PSScriptRoot/src/scripts/generate-settings.ps1"

    & "$PSScriptRoot/src/scripts/generate-configurations.ps1" `
        -MergeConfiguration:$MergeConfiguration `
        -IncludeVersion:$IncludeVersion
}
