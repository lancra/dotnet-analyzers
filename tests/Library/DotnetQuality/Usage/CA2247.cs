using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2247
{
    public static void Method()
    {
        var tcs = new TaskCompletionSource<int>(TaskContinuationOptions.RunContinuationsAsynchronously);
        Debug.WriteLine(tcs);
    }
}
