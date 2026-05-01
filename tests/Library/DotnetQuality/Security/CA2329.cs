using Newtonsoft.Json;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2329
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2326:Do not use TypeNameHandling values other than None",
        Justification = "Required to surface CA2329.")]
    public static string? Method(JsonReader reader)
    {
        JsonSerializer serializer = new()
        {
            TypeNameHandling = TypeNameHandling.Auto,
        };

        return serializer.Deserialize<string>(reader);
    }
}
