using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2264
{
    public static void Method(int value)
    {
        ArgumentNullException.ThrowIfNull(value);
        Debug.WriteLine(value);
    }
}
