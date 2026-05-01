using System.Data;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2352
{
    [Serializable]
    public sealed class MyClass
    {
        public DataSet DataSet { get; set; } = new();
    }
}
