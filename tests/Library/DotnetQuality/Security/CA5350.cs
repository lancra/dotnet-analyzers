using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5350
{
    public static void Method()
    {
        using var sha1 = SHA1.Create();
        using var tripleDes = TripleDES.Create();
    }
}
