function Get-VersionComment {
    [CmdletBinding()]
    param ()
    process {
        $commitId = & git rev-parse HEAD
        $remoteUrl = (& git remote get-url origin).TrimEnd('.git')
        "# Source: $remoteUrl/tree/$commitId"
    }
}
