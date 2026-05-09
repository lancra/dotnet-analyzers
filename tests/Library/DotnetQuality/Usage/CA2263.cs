using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2263
{
    public static int Method()
        => Marshal.SizeOf(typeof(bool));
}
