using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Naming;

internal sealed class CA1713
{
    public event EventHandler? BeforeClose;

    public event EventHandler? AfterClose;

    public static void Method()
    {
        Debug.WriteLine(nameof(BeforeClose));
        Debug.WriteLine(nameof(AfterClose));
    }
}
