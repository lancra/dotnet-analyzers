function Get-VersionComment {
    [CmdletBinding()]
    param ()
    process {
        $commitId = & git rev-parse HEAD
        "# lancra/dotnet-analyzers@$commitId"
    }
}
