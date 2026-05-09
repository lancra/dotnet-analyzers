namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

internal static class CA2262
{
    public static HttpClientHandler Method()
        => new()
        {
            MaxResponseHeadersLength = 512,
        };
}
