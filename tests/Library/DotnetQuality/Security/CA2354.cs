using System.Data;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2354
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2300:Do not use insecure deserializer BinaryFormatter",
        Justification = "Required to surface CA2354.")]
    public static MyClass Method(Stream stream)
    {
#pragma warning disable SYSLIB0011 // Required to surface CA2354.
        BinaryFormatter formatter = new()
#pragma warning restore SYSLIB0011 // Type or member is obsolete
        {
            Binder = new MySerializationBinder(),
        };

        return (MyClass)formatter.Deserialize(stream);
    }

    [Serializable]
    public sealed class MyClass
    {
        public MyOtherClass OtherClass { get; set; } = new();
    }

    [Serializable]
    public sealed class MyOtherClass : IDisposable
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage(
            "Security",
            "CA2352:Unsafe DataSet or DataTable in serializable type can be vulnerable to remote code execution attacks",
            Justification = "Required to surface CA2354.")]
        private readonly DataSet _dataSet = new();

        public void Dispose()
        {
            Dispose(disposing: true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing)
        {
            if (disposing)
            {
                _dataSet?.Dispose();
            }
        }
    }

    private sealed class MySerializationBinder : SerializationBinder
    {
        public override Type? BindToType(string assemblyName, string typeName)
            => typeof(string);
    }
}
