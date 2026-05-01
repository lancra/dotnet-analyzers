using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2302
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2300:Do not use insecure deserializer BinaryFormatter",
        Justification = "Deserialization must be performed to surface CA2301.")]
    public static void Method(Stream stream, bool condition)
    {
#pragma warning disable SYSLIB0011 // Required to surface CA2300.
        BinaryFormatter formatter = new();
#pragma warning restore SYSLIB0011 // Type or member is obsolete

        if (condition)
        {
            formatter.Binder = new MySerializationBinder();
        }

        _ = (string)formatter.Deserialize(stream);
    }

    private sealed class MySerializationBinder : SerializationBinder
    {
        public override Type? BindToType(string assemblyName, string typeName)
            => typeof(string);
    }
}
