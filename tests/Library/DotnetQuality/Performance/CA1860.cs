namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1860
{
    public static bool HasElements(string[] strings)
        => strings.Any();
}
