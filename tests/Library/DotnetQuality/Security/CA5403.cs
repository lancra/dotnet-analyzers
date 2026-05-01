using System.Security.Cryptography.X509Certificates;
using System.Text;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5403
{
    public static void Method(string path)
    {
        var bytes = Encoding.ASCII.GetBytes("AAAAAaazaoensuth");
        File.WriteAllBytes(path, bytes);
#pragma warning disable SYSLIB0057 // Required to surface CA5403.
        using var certificate = new X509Certificate2(path);
#pragma warning restore SYSLIB0057 // Type or member is obsolete
    }
}
