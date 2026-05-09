using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal readonly struct CA2207
{
    private static readonly int _first;
    private static readonly int _second;

    static CA2207()
    {
        _first = 1;
        _second = 2;
    }

    public static void Method()
        => Debug.WriteLine($"{_first} {_second}");
}
