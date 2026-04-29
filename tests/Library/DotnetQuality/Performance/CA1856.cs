using System.Diagnostics.CodeAnalysis;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1856
{
    public static char M1([ConstantExpected(Min = "a")] char value)
        => value;

    public static decimal M2([ConstantExpected] decimal value)
        => value;

    public static int M3([ConstantExpected(Max = 0, Min = 1)] int value)
        => value;

    public static int M4([ConstantExpected(Min = long.MinValue)] int value)
        => value;
}
