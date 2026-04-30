using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Reliability;

internal static class CA2000
{
    public static void Method()
    {
        var fileStream = new FileStream("C:\\temp.txt", FileMode.Open);
        Debug.WriteLine(fileStream.ToString());
    }
}
