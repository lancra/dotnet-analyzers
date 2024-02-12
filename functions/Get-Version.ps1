function Get-Version {
    [CmdletBinding()]
    param ()
    process {
        $commitId = & git rev-parse HEAD
        "lancra/dotnet-analyzers@$commitId"
    }
}
