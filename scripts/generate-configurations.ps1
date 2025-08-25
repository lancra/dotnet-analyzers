[CmdletBinding()]
param (
    [switch]$MergeConfiguration,
    [switch]$IncludeVersion
)

$ruleConfigurationName = $MergeConfiguration ? 'combined' : 'rule'
Write-Output "Generating $ruleConfigurationName configuration (.globalconfig)"
New-RuleConfiguration -IncludeOption:$MergeConfiguration -IncludeVersion:$IncludeVersion

if (-not $MergeConfiguration) {
    Write-Output 'Generating option configuration (partial.editorconfig)'
    New-OptionConfiguration -IncludeVersion:$IncludeVersion
}
