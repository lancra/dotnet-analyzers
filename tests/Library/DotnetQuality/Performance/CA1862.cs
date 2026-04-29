using System.Globalization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1862
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Globalization",
        "CA1308:Normalize strings to uppercase",
        Justification = "These methods are required to verify all occurrences of this diagnostic.")]
    public static void Method(string one, string two)
    {
        _ = one.ToLower(CultureInfo.InvariantCulture).CompareTo(two.ToLower(CultureInfo.InvariantCulture));
        _ = one.ToLowerInvariant().CompareTo(two.ToLowerInvariant());
        _ = one.ToUpper(CultureInfo.InvariantCulture).CompareTo(two.ToUpper(CultureInfo.InvariantCulture));
        _ = one.ToUpperInvariant().CompareTo(two.ToUpperInvariant());
    }
}
