using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2265
{
    public static void Method(Span<int> span)
    {
        if (span == null)
        {
            Debug.WriteLine("null");
        }

        if (span == default)
        {
            Debug.WriteLine("default");
        }

        if (span.IsEmpty)
        {
            Debug.WriteLine("empty");
        }
    }
}
