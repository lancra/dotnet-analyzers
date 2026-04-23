using System.Runtime.Versioning;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Interoperability;

internal static class CA1422
{
    [SupportedOSPlatform("Windows")]
    public static void M1()
        => ObsoletedOnWindows62();

    [ObsoletedOSPlatform("Windows6.2")]
    public static void ObsoletedOnWindows62()
    {
    }
}
