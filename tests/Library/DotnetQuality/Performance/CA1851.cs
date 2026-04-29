using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1851
{
    public static void Method(IEnumerable<int> list)
    {
        var count1 = list.Count();
        var count2 = list.Count();
        Debug.WriteLine($"{count1} {count2}");
    }
}
