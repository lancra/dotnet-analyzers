using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1826
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Performance",
        "CA1829:Use Length/Count property instead of Count() when available",
        Justification = "Overlaps with this rule but provides coverage on additional enumerable types.")]
    public static void Method(IReadOnlyList<int> list)
    {
        Debug.WriteLine(list.First());
        Debug.WriteLine(list.FirstOrDefault());
        Debug.WriteLine(list.Last());
        Debug.WriteLine(list.LastOrDefault());
        Debug.WriteLine(list.Count());
    }
}
