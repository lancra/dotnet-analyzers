namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1866
{
    public static void Method(string text)
    {
        _ = text.StartsWith("a");
        _ = text.EndsWith("a");
        _ = text.IndexOf("a");
        _ = text.LastIndexOf("a");
    }
}
