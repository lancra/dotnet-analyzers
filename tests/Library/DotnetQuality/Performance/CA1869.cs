using System.Text.Json;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Performance;

internal static class CA1869
{
    public static string Serialize<T>(T value)
    {
        JsonSerializerOptions options = new()
        {
            WriteIndented = true,
        };

        return JsonSerializer.Serialize(value, options);
    }

    public static T? Deserialize<T>(string json)
        => JsonSerializer.Deserialize<T>(json, new JsonSerializerOptions { AllowTrailingCommas = true, });
}
