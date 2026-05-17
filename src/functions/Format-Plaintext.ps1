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

        # The lookahead ensures that generic arity specifiers are not treated as code blocks (e.g. System.Collections.ArrayList`1).
        $codeSearch = "``(?<$groupName>.*?)``(?!\d\>)"

        # The non-capturing group removes docfx options used to customize cross references in Microsoft Learn.
        # See: https://dotnet.github.io/docfx/docs/links-and-cross-references.html#more-options-for-cross-referencing-net-api-docs
        $crossReferenceSearch = "<xref:(?<$groupName>.*?)(?:\*\?.*?)?>"

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
            -creplace $emojiSearch `
            -replace '&lt;', '<' `
            -replace '&gt;', '>'
        $plaintext.Trim()
    }
}
