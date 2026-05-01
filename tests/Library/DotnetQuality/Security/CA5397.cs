using System.Diagnostics;
using System.Security.Authentication;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5397
{
    public static void Method()
    {
#pragma warning disable SYSLIB0039 // Required to surface CA5397.
#pragma warning disable CS0618 // Required to surface CA5397.
        var ssl2 = SslProtocols.Ssl2;
        var ssl3 = SslProtocols.Ssl3;
#pragma warning restore CS0618 // Type or member is obsolete
        var tls = SslProtocols.Tls;
        var tls11 = SslProtocols.Tls11;
#pragma warning restore SYSLIB0039 // Type or member is obsolete
        Debug.WriteLine($"{ssl2} {ssl3} {tls} {tls11}");
    }
}
