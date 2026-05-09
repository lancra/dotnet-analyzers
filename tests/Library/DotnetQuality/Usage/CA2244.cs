using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2244
{
    public static void Method()
    {
        var dictionary = new Dictionary<int, int>
        {
            [1] = 1,
            [2] = 2,
            [1] = 3,
        };
        Debug.WriteLine(dictionary);
    }
}
