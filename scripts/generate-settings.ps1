[CmdletBinding()]
param ()

. "$env:DOTNET_ANALYZERS_FUNCTIONS/Merge-OptionSetting.ps1"
. "$env:DOTNET_ANALYZERS_FUNCTIONS/Merge-RuleSetting.ps1"

Write-Output 'Merging settings for analyzer rules'
Merge-RuleSetting

Write-Output 'Merging settings for analyzer options'
Merge-OptionSetting
