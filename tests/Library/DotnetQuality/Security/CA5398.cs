using System.Diagnostics;
using System.Security.Authentication;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5398
{
    public static void Method()
    {
        var protocols = SslProtocols.Tls13;
        Debug.WriteLine(protocols);
    }
}
