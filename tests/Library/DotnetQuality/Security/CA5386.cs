using System.Net;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5386
{
    public static void Method()
#pragma warning disable SYSLIB0014 // Required to surface CA5386.
        => ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
#pragma warning restore SYSLIB0014 // Type or member is obsolete
}
