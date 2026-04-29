using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1831
{
    public static void Method(string text)
    {
        ReadOnlySpan<char> slice = text[1..3];
        Debug.WriteLine(slice.ToString());
    }
}
