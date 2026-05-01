using System.Xml.XPath;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5372
{
    public static XPathDocument Method(Stream stream)
        => new(stream);
}
