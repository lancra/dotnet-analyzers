using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5400
{
    public static void Method()
    {
        using HttpClientHandler handler = new()
        {
            CheckCertificateRevocationList = true,
        };

        if (RandomNumberGenerator.GetInt32(6) == 4)
        {
            handler.CheckCertificateRevocationList = false;
        }

        using HttpClient client = new(handler);
    }
}
