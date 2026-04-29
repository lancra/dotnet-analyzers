using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal sealed class CA1822
{
    public void Method()
        => Debug.WriteLine("test");
}
