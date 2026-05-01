using System.Xml.Schema;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA3061
{
#pragma warning disable CS0618 // Required to surface CA3061.
    public static void Method(XmlSchemaCollection collection)
#pragma warning restore CS0618 // Type or member is obsolete
        => collection.Add("urn: bookstore - schema", "books.xsd");
}
