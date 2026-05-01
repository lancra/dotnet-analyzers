using Newtonsoft.Json;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2327
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2326:Do not use TypeNameHandling values other than None",
        Justification = "Required to surface CA2327.")]
    public static string? Method()
    {
        JsonSerializerSettings settings = new()
        {
            TypeNameHandling = TypeNameHandling.Auto,
        };
        return JsonConvert.DeserializeObject<string>("foo", settings);
    }
}
