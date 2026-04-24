using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Executable.DotnetQuality.Maintainability;

public static class CA1515
{
    public static void Method()
        => Debug.WriteLine("42");
}
