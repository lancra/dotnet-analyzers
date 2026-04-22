function Get-GitHubFileLine {
    [CmdletBinding()]
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory)]
        [string] $Uri
    )
    process {
        $contentBase64 = & gh api $Uri |
            ConvertFrom-Json |
            Select-Object -ExpandProperty 'content'
        $content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($contentBase64))

        # GitHub (git) returns LF delimited content while PowerShell expects CRLF.
        return $content -split "`n"
    }
}
