using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2326
{
    public static JsonSerializerSettings Method()
    {
        JsonSerializerSettings settings = new()
        {
            TypeNameHandling = TypeNameHandling.All,
            SerializationBinder = new MySerializationBinder(),
        };

        settings.TypeNameHandling = (TypeNameHandling)1;
        return settings;
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
