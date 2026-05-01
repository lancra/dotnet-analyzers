using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2328
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2326:Do not use TypeNameHandling values other than None",
        Justification = "Required to surface CA2328.")]
    public static string? Method(bool condition)
    {
        JsonSerializerSettings settings = new()
        {
            SerializationBinder = new MySerializationBinder(),
        };

        if (condition)
        {
            settings.TypeNameHandling = TypeNameHandling.All;
            settings.SerializationBinder = null;
        }

        return JsonConvert.DeserializeObject<string>("foo", settings);
    }

    private sealed class MySerializationBinder : ISerializationBinder
    {
        public void BindToName(Type serializedType, out string? assemblyName, out string? typeName)
        {
            assemblyName = "foo";
            typeName = "bar";
        }

        public Type BindToType(string? assemblyName, string typeName)
            => typeof(string);
    }
}
