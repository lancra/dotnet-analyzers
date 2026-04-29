using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1846
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Style",
        "IDE0057:Use range operator",
        Justification = "Usage of Substring is required to surface this diagnostic.")]
    public static void Method(string text)
    {
        _ = int.TryParse(text.Substring(7), out var x);
        _ = int.TryParse(text.Substring(2, 5), out var y);
        Debug.WriteLine(x);
        Debug.WriteLine(y);
    }
}
