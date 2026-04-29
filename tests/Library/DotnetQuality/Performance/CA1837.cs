using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1837
{
    public static void Method()
    {
        var pid = Process.GetCurrentProcess().Id;
        Debug.WriteLine(pid);
    }
}
