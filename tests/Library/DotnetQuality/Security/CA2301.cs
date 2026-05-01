using System.Runtime.Serialization.Formatters.Binary;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2301
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2300:Do not use insecure deserializer BinaryFormatter",
        Justification = "Deserialization must be performed to surface CA2301.")]
    public static void Method(Stream stream)
    {
#pragma warning disable SYSLIB0011 // Required to surface CA2301.
        BinaryFormatter formatter = new();
#pragma warning restore SYSLIB0011 // Type or member is obsolete

        _ = formatter.Deserialize(stream);
    }
}
