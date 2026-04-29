namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1854
{
    public static int? Method(IDictionary<string, int> dictionary)
        => dictionary.ContainsKey("foo") ? dictionary["foo"] : null;
}
