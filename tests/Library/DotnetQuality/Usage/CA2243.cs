using System.Runtime.InteropServices;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Usage;

[TestGuid("")]
[TestUri("")]
[TestUrl("")]
[TestUrn("")]
[TestVersion("")]
internal static class CA2243
{
    [AttributeUsage(AttributeTargets.All)]
    [ComVisible(true)]
    public sealed class TestGuidAttribute(string guid) : Attribute
    {
        public string Guid { get; } = guid;
    }

    [AttributeUsage(AttributeTargets.All)]
    [ComVisible(true)]
    public sealed class TestUriAttribute(string uri) : Attribute
    {
        public string Uri { get; } = uri;
    }

    [AttributeUsage(AttributeTargets.All)]
    [ComVisible(true)]
    public sealed class TestUrlAttribute(string url) : Attribute
    {
        public string Url { get; } = url;
    }

    [AttributeUsage(AttributeTargets.All)]
    [ComVisible(true)]
    public sealed class TestUrnAttribute(string urn) : Attribute
    {
        public string Urn { get; } = urn;
    }

    [AttributeUsage(AttributeTargets.All)]
    [ComVisible(true)]
    public sealed class TestVersionAttribute(string version) : Attribute
    {
        public string Version { get; } = version;
    }
}
