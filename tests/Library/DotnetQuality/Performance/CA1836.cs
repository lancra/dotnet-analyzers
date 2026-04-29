using System.Collections.Concurrent;
using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1836
{
    public static void Method(ConcurrentQueue<int> queue)
    {
        var isEmpty = queue.Count == 0;
        Debug.WriteLine(isEmpty ? "empty" : "not empty");
    }
}
