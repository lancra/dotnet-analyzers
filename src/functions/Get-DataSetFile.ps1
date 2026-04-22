function Get-DataSetFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $File
    )
    process {
        $baseDirectoryRelative = "$PSScriptRoot/../data-sets"
        $baseDirectory = Resolve-Path -Path $baseDirectoryRelative
        $path = Join-Path -Path $baseDirectory -ChildPath $File
        return $path
    }
}
