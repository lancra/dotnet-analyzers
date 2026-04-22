function Format-MarkdownAnchor {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string] $Text
    )
    begin {
        $wordSplitPattern = '\s+'
        $replacementPattern = '[^\w]'
    }
    process {
        $words = [regex]::Split($Text, $wordSplitPattern) |
            ForEach-Object {
                [regex]::Replace($_, $replacementPattern, '').ToLower()
            }
        return $words -join '-'
    }
}
