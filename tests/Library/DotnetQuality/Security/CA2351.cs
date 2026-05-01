using System.Data;
using System.Xml;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA2351
{
    public static DataSet Method(XmlReader reader)
    {
        DataSet dataSet = new();
        dataSet.ReadXml(reader);
        return dataSet;
    }
}
