<#
.SYNOPSIS
Merges remote ruleset metadata with the local repository settings.

.DESCRIPTION
Combines the remote JSON metadata with local CSV settings, preserved manually
set fields from the latter. Descriptive fields are always sourced from the
remote metadata.
#>
[CmdletBinding()]
param ()

Write-Output 'Merging settings for analyzer rules'
Merge-RuleSetting

Write-Output 'Merging settings for analyzer options'
Merge-OptionSetting
