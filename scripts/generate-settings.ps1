[CmdletBinding()]
param ()

Write-Output 'Merging settings for analyzer rules'
Merge-RuleSetting

Write-Output 'Merging settings for analyzer options'
Merge-OptionSetting
