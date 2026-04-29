using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1845
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Style",
        "IDE0057:Use range operator",
        Justification = "Usage of Substring is required to surface this diagnostic.")]
    public static void Method()
    {
        var text = "fwobz the fwutzle";
        var stringOne = text.Substring(10) + "---" + text.Substring(0, 5);
        var stringTwo = string.Concat(text.AsSpan(10), "---", text.AsSpan(0, 5));
        Debug.WriteLine(stringOne);
        Debug.WriteLine(stringTwo);
    }
}
