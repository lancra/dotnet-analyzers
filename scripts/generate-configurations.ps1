[CmdletBinding()]
param (
    [switch]$MergeConfiguration
)

. "$env:DOTNET_ANALYZERS_FUNCTIONS/New-RuleConfiguration.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/New-OptionConfiguration.ps1"

$ruleConfigurationName = $MergeConfiguration ? 'combined' : 'rule'
Write-Output "Generating $ruleConfigurationName configuration (.globalconfig)"
New-RuleConfiguration -IncludeOption:$MergeConfiguration

if (-not $MergeConfiguration) {
    Write-Output 'Generating option configuration (partial.editorconfig)'
    New-OptionConfiguration
}
