using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1841
{
    public static void Method(Dictionary<int, string> dictionary)
    {
        if (dictionary.Keys.Contains(42))
        {
            Debug.WriteLine("has key 42");
        }

        if (dictionary.ContainsKey(42))
        {
            Debug.WriteLine("has key 42");
        }

        if (dictionary.Values.Contains("foo"))
        {
            Debug.WriteLine("has value foo");
        }

        if (dictionary.ContainsValue("foo"))
        {
            Debug.WriteLine("has value foo");
        }
    }
}
