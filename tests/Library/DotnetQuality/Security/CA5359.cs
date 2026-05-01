using System.Net;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5359
{
    public static void Method()
#pragma warning disable SYSLIB0014 // Required to surface CA5359.
        => ServicePointManager.ServerCertificateValidationCallback += (sender, cert, chain, error) => true;
#pragma warning restore SYSLIB0014 // Type or member is obsolete
}
