using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2019
{
    [ThreadStatic]
    private static object obj = new();

    public static void Method()
        => Debug.WriteLine(obj.ToString());
}
