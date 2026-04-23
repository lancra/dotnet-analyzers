using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Design;

public static class CA1045
{
    public static void Test(ref string value) => Debug.WriteLine(value);
}
