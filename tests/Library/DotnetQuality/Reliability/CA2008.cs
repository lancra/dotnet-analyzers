using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2008
{
    public static void Method()
    {
        var task = Task.Factory.StartNew(() => { });
        Debug.WriteLine(task.ToString());
    }
}
