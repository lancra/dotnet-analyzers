using System.Runtime.Versioning;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Interoperability;

internal static class CA1416
{
    [SupportedOSPlatform("linux")]
    public static void LinuxOnlyApi()
    {
    }

    [SupportedOSPlatform("windows")]
    [SupportedOSPlatform("ios14.0")]
    public static void SupportedOnWindowsIos14AndMacCatalyst14()
    {
    }

    public static void Caller()
    {
        LinuxOnlyApi();
        SupportedOnWindowsIos14AndMacCatalyst14();
    }
}
