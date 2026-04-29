using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal sealed class CA1805
{
    private readonly int _value = 0;

    public void Print()
        => Debug.WriteLine(_value);
}
