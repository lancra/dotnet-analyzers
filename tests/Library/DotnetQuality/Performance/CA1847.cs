namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1847
{
    public static bool Method(string text)
        => text.Contains("I", StringComparison.Ordinal);
}
