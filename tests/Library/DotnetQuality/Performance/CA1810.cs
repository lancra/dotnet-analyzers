using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal sealed class CA1810
{
    private static readonly int _theInteger;
    private static readonly string? _theString;

    static CA1810()
    {
        _theInteger = 3;
        _theString = "foo";
    }

    public static void Print()
        => Debug.WriteLine($"{_theInteger} {_theString}");
}
