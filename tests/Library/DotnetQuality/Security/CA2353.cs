using System.Data;
using System.Xml.Serialization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2353
{
    [XmlRoot]
    public sealed class MyClass
    {
        public DataSet DataSet { get; set; } = new();
    }
}
