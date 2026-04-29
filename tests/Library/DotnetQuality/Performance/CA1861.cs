using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1861
{
    public static void Method()
    {
        var message = string.Join(" ", new[] { "Hello", "World!", });
        Debug.WriteLine(message);
    }
}
