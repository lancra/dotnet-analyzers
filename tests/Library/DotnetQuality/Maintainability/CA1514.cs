using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1514
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Style",
        "IDE0057:Use range operator",
        Justification = "Rules overlap but keeping both provides more coverage to older target frameworks.")]
    public static void Method()
    {
        var message = "Hello World!";
        var world = message.Substring(6, message.Length - 6);
        Debug.WriteLine(world);
    }
}
