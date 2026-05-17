function Remove-MarkdownTableAffix {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $Text
    )
    begin {
        $affix = '|'
        $longPrefix = "$affix "
        $codeBlockPrefix = "> $longPrefix"
        $prefixes = @($codeBlockPrefix, $longPrefix, $affix)

        $longSuffix = " $affix"
        $suffixes = @($longSuffix, $affix)
    }
    process {
        $prefixLength = 0
        foreach ($prefix in $prefixes) {
            if ($Text.StartsWith($prefix)) {
                $prefixLength = $prefix.Length
                break
            }
        }

        $suffixLength = 0
        foreach ($suffix in $suffixes) {
            if ($Text.EndsWith($suffix)) {
                $suffixLength = $suffix.Length
                break
            }
        }

        $trimLength = $prefixLength + $suffixLength
        $Text.Substring($prefixLength, $Text.Length - $trimLength)
    }
}
