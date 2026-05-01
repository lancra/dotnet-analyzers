using System.Xml;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5370
{
#pragma warning disable CS0618 // Required to surface CA5370.
    public static XmlValidatingReader Method(Stream xmlFragment, XmlNodeType fragmentType, XmlParserContext context)
        => new(xmlFragment, fragmentType, context);
#pragma warning restore CS0618 // Type or member is obsolete
}
