using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Maintainability;

internal static class CA1508
{
    public static void Method(int i, int j)
    {
        if (i != 0)
        {
            return;
        }

        if (j != 0)
        {
            return;
        }

        if (i != j)
        {
            Debug.WriteLine("Not equal.");
        }
    }
}
