using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2219
{
    public static void Method()
    {
        try
        {
            Debug.WriteLine("test");
        }
        finally
        {
            throw new InvalidOperationException("message");
        }
    }
}
