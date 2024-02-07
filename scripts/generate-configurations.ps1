[CmdletBinding()]
param ()

. "$env:DOTNET_ANALYZERS_FUNCTIONS/New-RuleConfiguration.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/New-OptionConfiguration.ps1"

Write-Output "Generating rule configuration (.globalconfig)"
New-RuleConfiguration

Write-Output "Generating option configuration (partial.editorconfig)"
New-OptionConfiguration
