using System.Diagnostics;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

public static class CA2234
{
    public static void AddUri(string uriString)
        => Debug.WriteLine(uriString);

    public static void AddUri(Uri uri)
        => Debug.WriteLine(uri);

    public static void Method()
    {
        var uriString = "https://example.org";
        AddUri(uriString);
        AddUri(new Uri(uriString));
    }
}
