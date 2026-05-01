using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5381
{
    public static void Method()
    {
        var storeName = StoreName.Root;

        if (RandomNumberGenerator.GetInt32(6) == 4)
        {
            storeName = StoreName.My;
        }

        using var store = new X509Store(storeName);
        using var certificate = X509CertificateLoader.LoadCertificate([]);
        store.Add(certificate);
    }
}
