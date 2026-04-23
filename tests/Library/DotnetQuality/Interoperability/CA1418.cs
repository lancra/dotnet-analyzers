using System.Runtime.Versioning;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Interoperability;

internal static class CA1418
{
    [SupportedOSPlatform("Solaris")]
    public static void SolarisApi()
    {
    }

    [UnsupportedOSPlatform("Android10")]
    public static void DoesNotWorkOnAndroid()
    {
    }

    [SupportedOSPlatform("Linux4.8")]
    public static void LinuxApi()
    {
    }
}
