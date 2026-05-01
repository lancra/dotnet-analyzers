using System.Security.Cryptography;

namespace DotnetAnalyzers.SmokeTests.Library.DotnetQuality.Security;

internal static class CA5358
{
    public static void Method()
    {
        using var aes = Aes.Create();
        aes.Mode = CipherMode.ECB;
        aes.Mode = CipherMode.OFB;
        aes.Mode = CipherMode.CFB;
    }
}
