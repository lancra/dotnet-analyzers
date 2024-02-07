function Format-Plaintext {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Text
    )
    begin {
        $linkSearch = '\[(?<Text>.+?)\]\((?<Url>.+?)\)'
        $boldItalicSearch = '\*(?<Text>.*?)\*'
        $codeSearch = '`(?<Text>.*?)`'
        $htmlLineBreakSearch = '<br\s*?\/>'
        $htmlLineBreakAlternateSearch = '<\/br>'

        $textGroupReplace = '${Text}'
    }
    process {
        $Text -replace $linkSearch, $textGroupReplace `
            -replace $boldItalicSearch, $textGroupReplace `
            -replace $codeSearch, $textGroupReplace `
            -replace $htmlLineBreakSearch, ' ' `
            -replace $htmlLineBreakAlternateSearch, ' '
    }
}
