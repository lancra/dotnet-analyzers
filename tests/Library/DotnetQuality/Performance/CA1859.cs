using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

public static class CA1859
{
    public static void Method()
        => Debug.WriteLine(Method(true));

    private static IEnumerable<int> Method(bool condition)
        => !condition ? [] : new List<int>();
}
