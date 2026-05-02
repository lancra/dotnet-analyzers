function Get-DocumentationUri {
    [CmdletBinding()]
    [OutputType([uri])]
    param(
        [Parameter(Mandatory)]
        [string] $Document
    )
    process {
        [uri]::new(('https://raw.githubusercontent.com/dotnet/docs/main/docs/fundamentals/code-analysis/style-rules/{0}' -f $Document))
    }
}
