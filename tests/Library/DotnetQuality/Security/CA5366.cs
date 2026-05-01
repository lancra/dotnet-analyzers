using System.Data;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5366
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage(
        "Security",
        "CA2351:Do not use DataSet.ReadXml() with untrusted data",
        Justification = "Required to surface CA5366.")]
    public static DataSet Method()
    {
        var dataSet = new DataSet();
        using var stream = new FileStream("path", FileMode.Open);
        dataSet.ReadXml(stream);
        return dataSet;
    }
}
