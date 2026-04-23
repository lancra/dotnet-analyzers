using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public static class CA1062
{
    public static void Write(string text)
    {
        if (text.Length > 0)
        {
            Debug.WriteLine(text);
        }
    }
}
