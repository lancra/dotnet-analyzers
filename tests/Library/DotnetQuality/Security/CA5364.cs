using System.Net;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5364
{
    public static void Method()
    {
#pragma warning disable SYSLIB0014 // Required to surface CA5364.
#pragma warning disable CS0618 // Required to surface CA5364.
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3;
#pragma warning restore CS0618 // Type or member is obsolete
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11;
#pragma warning restore SYSLIB0014 // Type or member is obsolete
    }
}
