namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1858
{
    public static bool Method(string text)
        => text.IndexOf("foo") == 0;
}
