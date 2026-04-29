namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1864
{
    public static void Method(Dictionary<int, string> dictionary)
    {
        if (!dictionary.ContainsKey(42))
        {
            dictionary.Add(42, "foo");
        }
    }
}
