using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2300
{
    public static void Method(Stream stream)
    {
#pragma warning disable SYSLIB0011 // Required to surface CA2300.
        BinaryFormatter formatter = new()
#pragma warning restore SYSLIB0011 // Type or member is obsolete
        {
            Binder = new MySerializationBinder(),
        };

        _ = formatter.Deserialize(stream);
    }

    private sealed class MySerializationBinder : SerializationBinder
    {
        public override Type? BindToType(string assemblyName, string typeName)
            => typeof(string);
    }
}
