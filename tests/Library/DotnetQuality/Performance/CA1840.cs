using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1840
{
    public static void Method()
    {
        var id = Thread.CurrentThread.ManagedThreadId;
        Debug.WriteLine(id);
    }
}
