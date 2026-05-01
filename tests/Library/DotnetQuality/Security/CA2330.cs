using Newtonsoft.Json;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2330
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2326:Do not use TypeNameHandling values other than None",
        Justification = "Required to surface CA2329.")]
    public static string? Method(JsonReader reader, bool condition)
    {
        JsonSerializer serializer = new();

        if (condition)
        {
            serializer.TypeNameHandling = TypeNameHandling.Auto;
        }

        return serializer.Deserialize<string>(reader);
    }
}
