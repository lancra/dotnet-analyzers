using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1820
{
    public static void Method(string text)
    {
        if (text != string.Empty)
        {
            Debug.WriteLine(text);
        }
    }
}
