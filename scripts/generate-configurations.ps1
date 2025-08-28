<#
.SYNOPSIS
Generates .NET configuration files from local ruleset settings.

.DESCRIPTION
Converts the CSV settings for each rule and option into lines within a
globalconfig and/or editorconfig file.

.PARAMETER MergeConfiguration
Specifies that the resulting configuration should be represented by a single
globalconfig file. The default is to place rule configurations in the
globalconfig file and option configurations in the partial editorconfig file.

.PARAMETER IncludeVersion
Specifies that the repository version should be added as a header in generated
configuration files.
#>
[CmdletBinding()]
param (
    [switch] $MergeConfiguration,
    [switch] $IncludeVersion
)

. "$env:DOTNET_ANALYZERS_FUNCTIONS/New-RuleConfiguration.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/New-OptionConfiguration.ps1"

$ruleConfigurationName = $MergeConfiguration ? 'combined' : 'rule'
Write-Output "Generating $ruleConfigurationName configuration (.globalconfig)"
New-RuleConfiguration -IncludeOption:$MergeConfiguration -IncludeVersion:$IncludeVersion

if (-not $MergeConfiguration) {
    Write-Output 'Generating option configuration (partial.editorconfig)'
    New-OptionConfiguration -IncludeVersion:$IncludeVersion
}
