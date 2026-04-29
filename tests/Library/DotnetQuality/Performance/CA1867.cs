namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1867
{
    public static void Method(string text)
    {
        _ = text.StartsWith("a", StringComparison.OrdinalIgnoreCase);
        _ = text.EndsWith("a", StringComparison.OrdinalIgnoreCase);
        _ = text.IndexOf("a", StringComparison.OrdinalIgnoreCase);
        _ = text.LastIndexOf("a", StringComparison.OrdinalIgnoreCase);
    }
}
