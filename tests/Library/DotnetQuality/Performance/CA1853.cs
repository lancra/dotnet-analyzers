namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1853
{
    public static void Method(Dictionary<string, int> dictionary)
    {
        if (dictionary.ContainsKey("foo"))
        {
            dictionary.Remove("foo");
        }
    }
}
