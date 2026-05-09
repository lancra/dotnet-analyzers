using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2200
{
    public static void Method()
    {
        try
        {
            Debug.WriteLine("foo");
        }
        catch (InvalidOperationException ex)
        {
            throw ex;
        }
    }
}
