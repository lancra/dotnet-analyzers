function Format-Plaintext {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Text
    )
    begin {
        $groupName = 'text'

        $linkSearch = "\[(?<$groupName>.+?)\]\((?<Url>.+?)\)"
        $boldItalicSearch = "\*(?<$groupName>.*?)\*"
        $codeSearch = "``(?<$groupName>.*?)``"
        $crossReferenceSearch = "<xref:(?<$groupName>.*?)\*.*?>"

        $htmlLineBreakSearch = '<br\s*?\/>'
        $htmlLineBreakAlternateSearch = '<\/br>'
        $footnoteSearch = '†'

        $emojiSearch = '[\uD800-\uDFFF]'

        $textGroupReplace = "`${$groupName}"
    }
    process {
        $plaintext = $Text -replace $linkSearch, $textGroupReplace `
            -replace $boldItalicSearch, $textGroupReplace `
            -replace $codeSearch, $textGroupReplace `
            -replace $crossReferenceSearch, $textGroupReplace `
            -replace $htmlLineBreakSearch, ' ' `
            -replace $htmlLineBreakAlternateSearch, ' ' `
            -replace $footnoteSearch, '' `
            -creplace $emojiSearch
        $plaintext.Trim()
    }
}
