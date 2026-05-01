namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5399
{
    public static void Method()
    {
        using HttpClientHandler handler = new()
        {
            CheckCertificateRevocationList = false,
        };
        using HttpClient client = new(handler);
    }
}
