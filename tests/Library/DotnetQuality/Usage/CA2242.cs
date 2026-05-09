using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2242
{
    private const float ZeroFloat = 0;
    private const double ZeroDouble = 0;

    public static void Method()
    {
        Debug.WriteLine(0 / ZeroFloat == float.NaN);
        Debug.WriteLine(0 / ZeroFloat != float.NaN);
        Debug.WriteLine(float.IsNaN(0 / ZeroFloat));
        Debug.WriteLine(0 / ZeroDouble == double.NaN);
        Debug.WriteLine(0 / ZeroDouble != double.NaN);
        Debug.WriteLine(double.IsNaN(0 / ZeroDouble));
    }
}
