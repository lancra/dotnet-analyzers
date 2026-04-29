using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1825
{
    public static void Method()
    {
        var array = new int[0];
        Debug.WriteLine(array);
    }
}
