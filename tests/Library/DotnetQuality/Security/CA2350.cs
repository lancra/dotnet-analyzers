using System.Data;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2350
{
    public static DataTable Method(string xml)
    {
        DataTable dataTable = new();
        dataTable.ReadXml(xml);
        return dataTable;
    }
}
