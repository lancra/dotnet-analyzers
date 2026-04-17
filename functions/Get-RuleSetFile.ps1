function Get-RuleSetFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $RuleSet,

        [Parameter(Mandatory)]
        [string] $File
    )
    process {
        $baseDirectoryRelative = "$PSScriptRoot/../rule-sets"
        $baseDirectory = Resolve-Path -Path $baseDirectoryRelative
        $path = Join-Path -Path $baseDirectory -ChildPath $RuleSet -AdditionalChildPath $File
        return $path
    }
}
