using System.Runtime.Serialization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

public class CA2237(int baseValue) : ISerializable
{
    private readonly int _baseValue = baseValue;

    public void GetObjectData(SerializationInfo info, StreamingContext context)
    {
        ArgumentNullException.ThrowIfNull(info);
        info.AddValue(nameof(_baseValue), _baseValue);
    }
}
