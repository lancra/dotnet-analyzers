using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

public static class CA1802
{
    private static readonly int X = 3;
    private static readonly double Y = X + 2.1;
    private static readonly string S = "readonly";

    public static void Print()
        => Debug.WriteLine($"{X} {Y} {S}");
}
