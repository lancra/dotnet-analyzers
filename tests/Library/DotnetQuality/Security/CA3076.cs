using System.Xml;
using System.Xml.Xsl;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA3076
{
    public static void Method()
    {
        var xslCompiledTransform = new XslCompiledTransform();
        var settings = XsltSettings.TrustedXslt;
        var resolver = new XmlUrlResolver();
        xslCompiledTransform.Load("testStylesheet", settings, resolver);
    }
}
