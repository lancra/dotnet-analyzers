using System.Xml.Serialization;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal sealed class CA5369
{
    public static void Method()
    {
        XmlSerializer serializer = new(typeof(TestClass));
        using FileStream stream = new("path", FileMode.Open);
        serializer.Deserialize(stream);
    }

    private sealed class TestClass
    {
    }
}
