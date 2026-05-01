using System.Xml.Schema;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5371
{
    public static XmlSchema? Method(Stream stream, ValidationEventHandler validationEventHandler)
        => XmlSchema.Read(stream, validationEventHandler);
}
