using System.Security.Cryptography.X509Certificates;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5380
{
    public static void Method()
    {
        var storeName = StoreName.Root;
        using var store = new X509Store(storeName);
        using var certificate = X509CertificateLoader.LoadCertificate([]);
        store.Add(certificate);
    }
}
