namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1870
{
    private static readonly char[] MyValues = ['a', 'b', 'c', 'x', 'y', 'z'];

    public static int IndexOfMyValues(ReadOnlySpan<char> text)
        => text.IndexOfAny(MyValues);

    public static bool ContainsOnlyMyValues(ReadOnlySpan<char> text)
        => !text.ContainsAnyExcept("abcxyz");
}
