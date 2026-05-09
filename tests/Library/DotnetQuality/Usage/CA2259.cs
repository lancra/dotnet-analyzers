using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal sealed class CA2259
{
    [ThreadStatic]
    private readonly int _value = 42;

    public void Write()
        => Debug.WriteLine(_value);
}
